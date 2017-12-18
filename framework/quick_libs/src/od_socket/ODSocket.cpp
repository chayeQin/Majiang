#include "ODSocket.h"

#ifdef WIN32
#pragma comment(lib, "wsock32")
#endif

using namespace cocos2d;

ODSocket::ODSocket(SOCKET sock)
{
	m_sock = sock;
    
    decodeType = TYPE_DECODE_JSON;
}

ODSocket::~ODSocket()
{
}

int ODSocket::Init()
{
#ifdef WIN32
	/*
	http://msdn.microsoft.com/zh-cn/vstudio/ms741563(en-us,VS.85).aspx

	typedef struct WSAData { 
		WORD wVersion;								//winsock version
		WORD wHighVersion;							//The highest version of the Windows Sockets specification that the Ws2_32.dll can support
		char szDescription[WSADESCRIPTION_LEN+1]; 
		char szSystemStatus[WSASYSSTATUS_LEN+1]; 
		unsigned short iMaxSockets; 
		unsigned short iMaxUdpDg; 
		char FAR * lpVendorInfo; 
	}WSADATA, *LPWSADATA; 
	*/
	WSADATA wsaData;
	//#define MAKEWORD(a,b) ((WORD) (((BYTE) (a)) | ((WORD) ((BYTE) (b))) << 8)) 
	WORD version = MAKEWORD(2, 0);
	int ret = WSAStartup(version, &wsaData);//win sock start up
	if ( ret ) {
//		cerr << "Initilize winsock error !" << endl;
		return -1;
	}
#endif
	return 0;
}
//this is just for windows
int ODSocket::Clean()
{
#ifdef WIN32
		return (WSACleanup());
#endif
		return 0;
}

ODSocket& ODSocket::operator = (SOCKET s)
{
	m_sock = s;
	return (*this);
}

ODSocket::operator SOCKET ()
{
	return m_sock;
}
//create a socket object win/lin is the same
// af:
bool ODSocket::Create(int bufPackMax)
{
	this->bufPackMax = bufPackMax;

	buf = new char[bufPackMax];

    // 优先
//	Director::getInstance()->getScheduler()->scheduleUpdate(this, -100, true);
//	Director::getInstance()->getScheduler()->pauseTarget(this);
    auto scheduler = Director::getInstance()->getScheduler();
    scheduler->schedule(schedule_selector(ODSocket::update), this, 1/60.0f, false);
//    schedule(SEL_SCHEDULE selector, Ref *target, float interval, bool paused)

	return true;
}

bool ODSocket::Connect(const char* ip, unsigned short port)
{
	bufLen = -1;
	bufPackIndex = 0;
	connectStatus = 0;

	struct addrinfo *ailist,*aip;
	struct addrinfo hint;
	int err;

	char strPort[6];
	sprintf(strPort, "%d", port);

	hint.ai_family = 0;
	hint.ai_socktype = SOCK_STREAM;
	hint.ai_flags = AI_CANONNAME;
	hint.ai_protocol = 0;
	hint.ai_addrlen = 0;
	hint.ai_addr = NULL;
	hint.ai_canonname = NULL;
	hint.ai_next = NULL;
	if ((err = getaddrinfo(ip, strPort, &hint, &ailist)) != 0) {
		CCLOG("getaddrinfo error: %s\n", gai_strerror(err));
		return false;
	}

	bool isConnectOk = false;
	struct sockaddr_in *sinp;
	char seraddr[INET_ADDRSTRLEN];
	short serport;
	for (aip = ailist; aip != NULL; aip = aip->ai_next) {
		sinp = (struct sockaddr_in *)aip->ai_addr;
		if (inet_ntop(sinp->sin_family, &sinp->sin_addr, seraddr, INET_ADDRSTRLEN) != NULL)
		{
			CCLOG("server address is %s\n", seraddr);
		}
		serport = ntohs(sinp->sin_port);
		CCLOG("server port is %d\n", serport);
		if ((m_sock = socket(aip->ai_family, SOCK_STREAM, 0)) < 0) {
			CCLOG("create socket failed: %s\n", strerror(errno));
			isConnectOk = false;
			continue;
		}
		CCLOG("create socket ok\n");
		if (connect(m_sock, aip->ai_addr, aip->ai_addrlen) < 0) {

			CCLOG("can't connect to %s: %s\n", ip, strerror(errno));
			isConnectOk = false;
			continue;
		}
		isConnectOk = true;

		break;
	}
	freeaddrinfo(ailist);

	if (!isConnectOk) {
		CCLOG("connect error!!");
		return false;
	}
	
	return true;
}

int ODSocket::Send(const char* buf, int len, int flags)
{
	int bytes;
	int count = 0;

	while ( count < len ) {

		bytes = send(m_sock, buf + count, len - count, flags);
		if ( bytes == -1 || bytes == 0 )
			return -1;
		count += bytes;
	} 

	return count;
}

int ODSocket::Recv(char* buf, int len, int flags)
{
	return (recv(m_sock, buf, len, flags));
}

int ODSocket::Close()
{
	bufLen = -1;
	bufPackIndex = 0;
	connectStatus = 0;
#ifdef WIN32
	return (closesocket(m_sock));
#else
	// return (close(m_sock));
	// 强制关闭
	return (shutdown(m_sock,2));
#endif
}

int ODSocket::GetError()
{
#ifdef WIN32
	return (WSAGetLastError());
#else
	return 0;//(errno);
#endif
}

void ODSocket::doupdate()
{
	if(Director::getInstance()->getScheduler()->isTargetPaused(this))
	{
		Director::getInstance()->getScheduler()->resumeTarget(this);
	}
}

void ODSocket::readObj(lua_State *l, char *buf, unsigned char type)
{
    if (tableIndex >= tableLen)
    {
        lua_pushnil(l);
        return;
    }
    
    if (type == 0)
    {
        type = buf[tableIndex++];
    }
    
    if (TYPE_NULL == type)
    {
        lua_pushnil(l);
    }
    else if (TYPE_BOOL == type)
    {
        lua_pushboolean(l, buf[tableIndex] == 1);
        tableIndex += 1;
    }
    else if (TYPE_INT == type)
    {
        int v = 0;
        memcpy(&v, &buf[tableIndex], 4);
        lua_pushinteger(l, v);
        tableIndex += 4;
    }
    else if (TYPE_FLOAT == type)
    {
        float v = 0;
        memcpy(&v, &buf[tableIndex], 4);
        lua_pushnumber(l, v);
        tableIndex += 4;
    }
    else if (TYPE_LONG == type || TYPE_DATE == type)
    {
        long long v = 0;
        memcpy(&v, &buf[tableIndex], 8);
        lua_pushnumber(l, v);
        tableIndex += 8;
    }
    else if (TYPE_DOUBLE == type)
    {
        double v = 0;
        memcpy(&v, &buf[tableIndex], 8);
        lua_pushnumber(l, v);
        tableIndex += 8;
    }
    else if (TYPE_STRING == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        if (v_len < 1)
        {
            lua_pushstring(l, "");
        }
        else
        {
            char* v = new char[v_len + 1];
            memset(v, 0, v_len + 1);
            memcpy(v, &buf[tableIndex], v_len);
            v[v_len] = 0;
            tableIndex += v_len;
            lua_pushstring(l, v);
            delete[]v;
        }
        
    }
    else if (TYPE_LIST == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        lua_newtable(l);
        for (int j = 1; j <= v_len; j++)
        {
            lua_pushinteger(l, j);
            readObj(l, buf, 0);
            lua_settable(l, -3);
        }
    }
    else if (TYPE_MAP == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        lua_newtable(l);
        for (int j = 0; j < v_len; j++)
        {
            readObj(l, buf, 0);//key
            readObj(l, buf, 0);//value
            lua_settable(l, -3);
        }
    }
    else if (TYPE_CONVERT == type)
    {
        int typeId = 0;
        memcpy(&typeId, &buf[tableIndex], 2);
        std::map<int, std::string>::iterator it= typeMap->find(typeId);
        if (it == typeMap->end())
        {
            lua_pushnil(l);
        }
        else
        {
            tableIndex += 2;
            lua_pushstring(l, (it->second).c_str());
        }
    }
    else
    {
        std::map<int,SocketType*>::iterator it;
        it = protoMap->find(type);
        if (it == protoMap->end())
        {
            lua_pushnil(l);
            return;
        }
        lua_newtable(l);
        SocketType *s_type = it->second;
        while (s_type != NULL )
        {
            lua_pushstring(l,s_type->name);
            readObj(l,buf,s_type->type);
            lua_settable(l,-3);
            s_type = s_type->next;
        }
    }
}

void ODSocket::readObj2(lua_State *l, char *buf, unsigned char type)
{
    if (tableIndex >= tableLen)
    {
        lua_pushnil(l);
        return;
    }
    
    if (type == 0)
    {
        memcpy(&type, &buf[tableIndex], 2);
        tableIndex += 2;
    }
    
    if (TYPE_NULL == type)
    {
        lua_pushnil(l);
    }
    else if (TYPE_BOOL == type)
    {
        lua_pushboolean(l, buf[tableIndex] == 1);
        tableIndex += 1;
    }
    else if (TYPE_INT == type)
    {
        int v = 0;
        memcpy(&v, &buf[tableIndex], 4);
        lua_pushinteger(l, v);
        tableIndex += 4;
    }
    else if (TYPE_FLOAT == type)
    {
        float v = 0;
        memcpy(&v, &buf[tableIndex], 4);
        lua_pushnumber(l, v);
        tableIndex += 4;
    }
    else if (TYPE_LONG == type || TYPE_DATE == type)
    {
        long long v = 0;
        memcpy(&v, &buf[tableIndex], 8);
        lua_pushnumber(l, v);
        tableIndex += 8;
    }
    else if (TYPE_DOUBLE == type)
    {
        double v = 0;
        memcpy(&v, &buf[tableIndex], 8);
        lua_pushnumber(l, v);
        tableIndex += 8;
    }
    else if (TYPE_STRING == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        if (v_len < 1)
        {
            lua_pushstring(l, "");
        }
        else
        {
            char* v = new char[v_len + 1];
            memset(v, 0, v_len + 1);
            memcpy(v, &buf[tableIndex], v_len);
            v[v_len] = 0;
            tableIndex += v_len;
            lua_pushstring(l, v);
            delete[]v;
        }
        
    }
    else if (TYPE_LIST == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        lua_newtable(l);
        for (int j = 1; j <= v_len; j++)
        {
            lua_pushinteger(l, j);
            readObj2(l, buf, 0);
            lua_settable(l, -3);
        }
    }
    else if (TYPE_MAP == type)
    {
        int v_len = 0;
        memcpy(&v_len, &buf[tableIndex], 2);
        tableIndex += 2;
        lua_newtable(l);
        for (int j = 0; j < v_len; j++)
        {
            readObj2(l, buf, 0);//key
            readObj2(l, buf, 0);//value
            lua_settable(l, -3);
        }
    }
    else if (TYPE_CONVERT == type)
    {
        int typeId = 0;
        memcpy(&typeId, &buf[tableIndex], 2);
        std::map<int, std::string>::iterator it= typeMap->find(typeId);
        if (it == typeMap->end())
        {
            lua_pushnil(l);
        }
        else
        {
            tableIndex += 2;
            lua_pushstring(l, (it->second).c_str());
        }
    }
    else
    {
        std::map<int,SocketType*>::iterator it;
        it = protoMap->find(type);
        if (it == protoMap->end())
        {
            lua_pushnil(l);
            return;
        }
        lua_newtable(l);
        SocketType *s_type = it->second;
        while (s_type != NULL )
        {
            lua_pushstring(l,s_type->name);
            readObj2(l,buf,s_type->type);
            lua_settable(l,-3);
            s_type = s_type->next;
        }
    }
}

void ODSocket::readJsonObj(lua_State *l, char *buf) {
	int v_len = tableLen;
	char* v = new char[v_len + 1];
	memset(v, 0, v_len + 1);
	memcpy(v, buf, v_len);
	v[v_len] = 0;
	lua_pushstring(l, v);
	delete[]v;
}

void ODSocket::update(float dt)
{
    //	Director::getInstance()->getScheduler()->pauseTarget(this);
    
    lua_State* L = cocos2d::LuaEngine::getInstance()->getLuaStack()->getLuaState();

	// 连接成功
	if (connectStatus == 1)
	{
		connectStatus = 2;
		int top = lua_gettop(L);
		lua_getglobal(L,"connectRhand");
		lua_pcall(L,0,0,0);
		lua_settop(L,top);
	}
	else if (connectStatus == -2)// 连接失败
	{
		connectStatus = 0;
		int top = lua_gettop(L);
		lua_getglobal(L,"connectFhand");
		lua_pcall(L,0,0,0);
		lua_settop(L,top);
	}

	// 收数数据
	s_recvDataQueueMutex.lock();
	while (0 < msgList.size())
	{
		int top = lua_gettop(L);
		char* buf = msgList.front();
		tableIndex = 0;
		tableLen = msgLenList.front();
		int recvSize = msgSizeList.front();

		lua_getglobal(L,"recvMsg");
        if(decodeType == TYPE_DECODE_1_BYTE)
        {
            readObj(L,buf,0);
        }
        else if(decodeType == TYPE_DECODE_2_BYTE)
        {
            readObj2(L,buf,0);
		}
		else {
			readJsonObj(L, buf);

		}
		lua_pushinteger(L,recvSize);
		lua_pcall(L,2,0,0);
		lua_settop(L,top);

		msgList.pop();
		msgLenList.pop();
		msgSizeList.pop();
		delete []buf;
	}
	s_recvDataQueueMutex.unlock();
}
void ODSocket::push(char* buf,int len,int recvSize)
{
	msgList.push(buf);
	msgLenList.push(len);
	msgSizeList.push(recvSize);

	doupdate();
}
void ODSocket::checkPack()
{
	// 还没收到过包
	if (bufLen == -1)
	{
		if(bufPackIndex < 2){
			return;
		}

		bufLen = buf[1] & 0xff;;
		bufLen += (buf[0] & 0xff) << 8;
		bufPackIndex -= 2;
		if(bufPackIndex > 0){
			memmove(buf,&buf[2],bufPackIndex);
		}
	}
	
	// 数据不够解包
	if (bufPackIndex < bufLen)
	{
		return;
	}

	unsigned long len = bufLen * 10;
	unsigned char *tmp;
	int result = 0;
	while (true)
	{
        if(decodeType == TYPE_DECODE_1_BYTE || decodeType == TYPE_DECODE_JSON)
        {
            tmp = new unsigned char[len];
            result = uncompress(tmp,&len,(unsigned char*)buf,bufLen);
            if(Z_BUF_ERROR == result){
                delete[] tmp;
                len += len;
                continue;
            }else if (Z_OK == result){
                char *buf = new char[len];
                memcpy(buf,tmp,len);
                s_recvDataQueueMutex.lock();
                push(buf,len,bufLen + 2);
                s_recvDataQueueMutex.unlock();
            }
            
            delete []tmp;
        }
        else
        {
            s_recvDataQueueMutex.lock();
            push(buf, bufLen, bufLen + 2);
            s_recvDataQueueMutex.unlock();
        }
		
		break;
	}
	
	bufPackIndex -= bufLen;
	if(bufPackIndex > 0)
	{
		memmove(buf,&buf[bufLen],bufPackIndex);
	}
	bufLen = -1;
	checkPack();
}
void ODSocket::setNonblock(int socket)
{
	/*
	int opts;
	opts=fcntl(socket,F_GETFL);
	if(opts<0)
	{
		return;
	}
	opts = opts|O_NONBLOCK;
	if(fcntl(socket,F_SETFL,opts)<0)
	{
		return;
	}
	*/
}
