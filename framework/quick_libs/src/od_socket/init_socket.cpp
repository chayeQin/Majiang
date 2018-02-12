// std includes
#include <map>
#include <thread>

// cocos includes

// self includes
#include "init_socket.h"
#include "ODSocket.h"
#ifdef WIN32
#include<Winsock2.h>
#else
#include <arpa/inet.h>
#endif
using namespace std;
using namespace cocos2d;

// socket
static ODSocket mySockets;
static const char* myIp;
static int myPort;

const int MAX_LEN = 1024 * 64;
const int test = 20170809;

/*
static const luaL_Reg socketlib[] = {
	{ "connect", connect },
	{ "isConnect", isConnect },
	{ "disconnect", disconnect },
	{ "send", send },
	{ NULL, NULL }
};
*/

void init_socket(lua_State *l)
{
	// init lua func
	lua_register(l,"connect",connect);
    lua_register(l,"isConnect",isConnect);
    lua_register(l,"disconnect",disconnect);
    lua_register(l,"setDecodeType",setDecodeType);
	lua_register(l,"send",send);
	lua_register(l,"readZip",readZip);
	lua_register(l, "initProtoMap", initProtoMap);
	lua_register(l, "initTypeMap", initTypeMap);
	lua_register(l,"node_gray",node_gray);

	// init connect
	mySockets.Init();
	mySockets.Create(MAX_LEN);
}

int connect(lua_State *l)
{
	if (mySockets.connectStatus != 0)
	{
		return 0;
	}
	myIp = lua_tostring(l,-2);
	myPort = lua_tointeger(l,-1);

	mySockets.connectStatus = -1;

	//pthread_create(&mySockets.s_connectThread, NULL, thread_connect, &mySockets);
	std::thread connectThread(thread_connect, &mySockets);
	//pthread_detach(mySockets.s_connectThread);
	connectThread.detach();
	

	return 0;
}
int isConnect(lua_State *l)
{
	lua_pushboolean(l,mySockets.connectStatus > 0);
	return 1;
}
int disconnect(lua_State *l)
{
    mySockets.connectStatus = 0;
    mySockets.Close();
    
    return 0;
}

// 设置解码方式
int setDecodeType(lua_State *l)
{
    int type = lua_tointeger(l,-1);
    if(type == 1)
    {
        mySockets.decodeType = TYPE_DECODE_1_BYTE;
    }
    else
    {
        mySockets.decodeType = TYPE_DECODE_2_BYTE;
    }
    
    return 0;
}

// ∑¢ÀÕ ˝æ›
int send(lua_State *l)
{
	if(mySockets.connectStatus <= 0){
		return 0;
	}
	const char* msg = lua_tostring(l,-1);
	int len = strlen(msg);
	unsigned char* buf;
	unsigned long bufLen = len;
	buf = new unsigned char[bufLen + 4];
/*	memcpy(&buf[4], msg, len);*/
	while(true)
	{
		buf = new unsigned char[bufLen + 4];
		int result = compress(&buf[4],&bufLen,(unsigned char *)msg,len);
		if (Z_BUF_ERROR == result)
		{
			delete[] buf;
			bufLen += bufLen;
		}
		else if (Z_OK == result)
		{
			break;
		}
		else
		{
			CCLOG("*** zip error");
			return 0;
		}
	}

	CCLOG("*** send(%d)", bufLen);
	unsigned long tmpLen = ntohl(bufLen);

	memcpy(buf, &tmpLen, 4);
	lua_pushnumber(l,bufLen + 4);

	mySockets.Send((char *)buf,bufLen + 4);
	delete []buf;
	return 1;
}

// º”‘ÿ—πÀıŒƒ±æ
 int readZip(lua_State *l)
 {
 	const char* path = lua_tostring(l,-1);
 	ssize_t len = 0;
 	unsigned char * data = FileUtils::getInstance()->getFileData(path,"rb",&len);

	int r2 = -1;
 	if (len > 0)
	{
		unsigned char *tmp;
		unsigned long len2 = len * 2;
		while(true){
			 tmp = new unsigned char[len2];
			 r2 = uncompress(tmp,&len2,data,len);
			 if (Z_BUF_ERROR == r2)
			 {
				 delete[] tmp;
				 len2 += len2;
				 continue;
			 }
			 
			 if(Z_OK == r2)
			 {
				 char* buf = new char[len2 + 1];
				 memcpy((char*)buf,tmp,len2);
				 buf[len2] = 0;
				 lua_pushstring(l,buf);
				 lua_pushboolean(l,true);
				 delete []buf;
			 }
			 
			 break;
		}
		delete []tmp;
 	}

	if(Z_OK != r2)
	{
 		lua_pushstring(l,"");
 		lua_pushboolean(l,false);
	}

 	delete []data;

 	return 2;
 }

 // ≥ı ºªØ¿‡–Õ”≥…‰
 int initTypeMap(lua_State *l)
 {
	 if (!lua_istable(l, -1))
	 {
		 return 0;
	 }
	 if (mySockets.typeMap == NULL)
	 {
		 mySockets.typeMap = new map<int, string>();
	 }
	 else
	 {
		 mySockets.typeMap->clear();
	 }
	 map<int, string>* map = mySockets.typeMap;

	 lua_pushnil(l);
	 while (lua_next(l, -2))
	 {
		 int key = lua_tointeger(l, -2);
		 string value = lua_tostring(l, -1);
		 map->insert(pair<int, string>(key, value));
		 lua_pop(l, 1);
	 }

	 return 0;

 }
 
 // ≥ı ºªØ–≠“È”≥…‰
 int initProtoMap(lua_State *l)
{
	if (!lua_istable(l,-1))
	{
		return 0;
	}

	if (mySockets.protoMap == NULL)
	{
		mySockets.protoMap = new map<int, SocketType*>();
	}
	else
	{
		mySockets.protoMap->clear();
	}
	map<int, SocketType*>* map = mySockets.protoMap;

	/**
	{
		[1] = {{"key1",1},{"key2",1}},
	}
	*/
	lua_pushnil(l);
	while (lua_next(l,-2))
	{
		int key = lua_tointeger(l,-2);
		lua_pushnil(l);
		SocketType *sType1 = NULL;
		while (lua_next(l,-2))
		{
			SocketType *sType2 = new SocketType();
			lua_pushnil(l);
			lua_next(l,-2);
			sType2->name = (char *)lua_tostring(l,-1);
			lua_pop(l,1);
			lua_next(l,-2);
			sType2->type = lua_tointeger(l,-1);
			lua_pop(l,3);// …æ≥˝{key,1}

			if (sType1 == NULL)
			{
				map->insert(std::pair <int,SocketType*>(key,sType2));
			}
			else
			{
				sType1->next = sType2;
			}
			sType1 = sType2;
		}

		lua_pop(l,1);
	}

	return 0;
}
 
 // ±‰ª“
int node_gray(lua_State *l)
{
	if (!lua_isuserdata(l,1) || !lua_isboolean(l,2))
	{
		return 0;
	}

	Node* node = (Node*) tolua_tousertype(l,1,0);
	bool isGray = 1 == tolua_toboolean(l,2,0);
	GLProgram *p = NULL;
	if(isGray)
	{
		p = GLProgramCache::getInstance()->getGLProgram(GLProgram::SHADER_NAME_POSITION_GRAYSCALE);
	}
	else
	{
		p = GLProgramCache::getInstance()->getGLProgram(GLProgram::SHADER_NAME_POSITION_TEXTURE_COLOR_NO_MVP);
	}

	if(p == NULL) return 0;
	node_set_shader_program(node,p);
	
	return 0;
}

// …Ë÷√‰÷»æ∑Ω Ω
void node_set_shader_program(Node* n, GLProgram* s)
{
	if(n == NULL){
		return;
	}

	n->setGLProgram(s);
	Vector<Node*> vec = n->getChildren();
	Vector<Node*>::iterator itr = vec.begin();
	Vector<Node*>::iterator e = vec.end();
	for (; itr != e; ++itr){
		node_set_shader_program(*itr, s);
	}
}

 void my_print(lua_State *l)
 {
	 CCLOG("top ->>>");
	 int top = lua_gettop(l);
	 for (int i = 1;i <= top;i++)
	 {
		 CCLOG(" top type %d %d %s",i,i - top - 1,lua_typename(l,lua_type(l,i)));
	 }
 }

// œﬂ≥ÃΩ” ’ ˝æ›
void* thread_recv(void *arg)
{
	while(true) 
	{
		int max = mySockets.bufPackMax - mySockets.bufPackIndex;
		int len = mySockets.Recv(&mySockets.buf[mySockets.bufPackIndex],max,0);
		CCLOG("*** recv(%d)",len);
		if(len <= 0){
			int status = mySockets.connectStatus;
			mySockets.bufPackIndex = 0;
			mySockets.Close();
			if (status == 1 || status == 2)
			{
				mySockets.connectStatus = -2;
				mySockets.doupdate();
			}
			//pthread_exit(NULL);
			return NULL;
			//continue;
		}
		else
		{
			mySockets.bufPackIndex += len;
			mySockets.checkPack();
		}
	}
	return NULL;
}

void* thread_connect(void *arg)
{
	CCLOG("*** connect:%s:%d",myIp,myPort);
	bool ok = mySockets.Connect(myIp,myPort);
	if (ok){
		CCLOG("*** connect successful");
		mySockets.connectStatus = 1;

		//pthread_create(&mySockets.s_recvThread, NULL, thread_recv,&mySockets);
		std::thread recvThread(thread_recv, &mySockets);
		recvThread.detach();

		//pthread_detach(mySockets.s_recvThread);
	}else{
		CCLOG("*** connect failed");
		mySockets.Close();
		mySockets.connectStatus = -2;
	}
	mySockets.doupdate();

	return NULL;
}
