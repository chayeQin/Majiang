#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>

@protocol IOSPayDelegate<NSObject>
// 支付回调
- (void)payCallBack:(int) state;
@end


@interface IOSPay : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    UIView* loadingView;
}


@property(nonatomic, readwrite) NSString* webUrl;
@property(nonatomic, readwrite) NSMutableDictionary* produDict;
@property(assign,nonatomic) id<IOSPayDelegate> delegate;

@end
