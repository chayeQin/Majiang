#import "IOSPay.h"
#import<CommonCrypto/CommonDigest.h>

#define USER_DEFAULT_KEY @"jyx_appstore_pay_info"

@implementation IOSPay

@synthesize produDict;
@synthesize delegate;

// 默认WEB地址
NSString* LYT_WEB_URL = @"http://g1-new-yhbz.awwgc.com:8080/ws/";

-(id)init
{
    self = [super init];
    self.produDict = [[NSMutableDictionary alloc] init];
    self.webUrl = LYT_WEB_URL;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self]; // 监听回调
    return self;
}

#pragma mark - 开始支付
- (void)pay:(NSString*)productId param:(NSString*)param
{
    NSArray* arr = [NSArray arrayWithObjects:productId, param, nil];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:USER_DEFAULT_KEY];
    
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"加载IAP %@", productId);
        [self requestProducts:productId];
    } else {
        //不允许程序内付费购买;
        [self message:@"can't buy!"];
    }
}

#pragma mark - 请求商品信息
- (void)requestProducts:(NSString*)productId {
    [self showLoading];
    
    SKProduct *product = [produDict objectForKey:productId];
    if (product){
        //添加付款请求到队列
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        return;
    }
    
    NSSet *productIds = [NSSet setWithObject:productId];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    productsRequest.delegate = self;
    [productsRequest start];
}

#pragma mark - appstore回调 请求商品信息回调
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    SKProduct *product = [products count] > 0 ? [products objectAtIndex:0] : nil;
    if (product) {
        [produDict setObject:product forKey:product.productIdentifier];
        [self requestProducts:product.productIdentifier];
    } else {
        [self hideLoading];
        //无法获取商品信息
        [self message:[NSString stringWithFormat:@"no products info :%@", product.productIdentifier]];
        NSLog(@"无法获取商品信息");
    }
}

#pragma mark - appstore回调 付款请求回调
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction {
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStateDeferred:
                //购买中 交易被推迟
                break;
            case SKPaymentTransactionStateFailed:
                //购买监听 交易失败
                [self failedTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchased:
                //购买监听 交易完成
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStateRestored:
                //购买监听 恢复成功
                [self restoreTransaction:tran];
                break;
            default:
                break;
        }
    }
}

#pragma mark - 交易事务处理
// 交易成功
- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [self checkReceipt:transaction];
    [self finishTransaction:transaction wasSuccessful:YES];
}

// 交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    [self finishTransaction:transaction wasSuccessful:NO];
    [self hideLoading];
    [self message:@"pay fail"];
    [self.delegate payCallBack:1];
}

// 交易恢复
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [self finishTransaction:transaction wasSuccessful:YES];
    [self hideLoading];
    [self.delegate payCallBack:-1];
}

//结束交易事务
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful {
    //获取订单号，从userdefult
    //NSString *orderId = transaction.payment.applicationUsername;
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)showLoading
{
    if(loadingView != nil)
    {
        return;
    }
    
    UIWindow* parent = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [[UIScreen mainScreen] bounds];
    //创建UIActivityIndicatorView背底半透明View
    loadingView = [[UIView alloc] initWithFrame:rect];
    [loadingView setBackgroundColor:[UIColor blackColor]];
    [loadingView setAlpha:0.7];
    [parent addSubview:loadingView];
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    CGPoint point = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    [activityIndicator setCenter:point];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadingView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [loadingView release];
    [activityIndicator release];
}

-(void)hideLoading
{
    if(loadingView == nil)
    {
        return;
    }
    
    [loadingView removeFromSuperview];
    loadingView = nil;
}

-(void)message:(NSString*) msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    [alter release];
}

#pragma mark - 提交服务端
-(void) checkReceipt:(SKPaymentTransaction *)transaction
{
    if(transaction.transactionState != SKPaymentTransactionStatePurchased)
    {
        NSLog(@"iap state is %d", (int)(transaction.transactionState));
        [self.delegate payCallBack:3];
        return;
    }
    
    NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_KEY];
    if(arr == nil)
    {
        NSLog(@"USER_DEFAULT_KEY is nil");
        [self.delegate payCallBack:4];
        return;
    }

    NSString* productId = [arr objectAtIndex:0];
    NSString* param = [arr objectAtIndex:1];
    
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@sdkIospay", self.webUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString* postStr = [NSString stringWithFormat:@"param=%@&receipt=%@", param, receiptString];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [self hideLoading];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue
            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (connectionError) {
                    return;
                }
                
                if(data == nil)
                {
                    NSLog(@"post server error!");
                    return;
                }
                
                NSString* strResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                BOOL isOk = [strResult isEqualToString:@"1"];
                if(isOk)
                {
                    [self.delegate payCallBack:0];
                }
                else
                {
                    [self.delegate payCallBack:2];
                }
            }];
}

- (NSString*)md5:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}
@end
