/*
 * define file about portable socket class. 
 * description:this sock is suit both windows and linux
 * design:odison
 * e-mail:odison@126.com>
 * 
 */

#ifndef _ODSOCKET_H_
#define _ODSOCKET_H_

// std heads
#include <thread> // std::thread
#include <mutex> // std::mutex
#include <condition_variable> // std::condition_variable
#include <queue> // std::queue
#include <map> // std::map


// cocos2d heads
#include "cocos2d.h"
#include "CCLuaValue.h"
#include "CCLuaEngine.h"

#include "zlib.h"
//#include "fcntl.h"

#ifdef WIN32
	#include <winsock.h>
	#include <ws2tcpip.h>
	typedef int				socklen_t;
#else
	#include <sys/socket.h>
	#include <netinet/in.h>
	#include <netdb.h>
	#include <fcntl.h>
	#include <unistd.h>
	#include <sys/stat.h>
	#include <sys/types.h>
	#include <arpa/inet.h>
	typedef int				SOCKET;

	//#pragma region define win32 const variable in linux
	#define INVALID_SOCKET	-1
	#define SOCKET_ERROR	-1
	//#pragma endregion
#endif

//  ˝æ›∞¸¿‡–Õ
typedef struct _SocketType{
	const char *name;
	int type;
	_SocketType *next;
}SocketType;

//  ˝æ›∞¸¿‡–Õ
const char TYPE_NULL = 1;
const char TYPE_BOOL = 2;
const char TYPE_INT = 3;
const char TYPE_FLOAT = 4;
const char TYPE_LONG = 5;
const char TYPE_DOUBLE = 6;
const char TYPE_DATE = 7;
const char TYPE_STRING = 8;
const char TYPE_LIST = 9;
const char TYPE_MAP = 10;
const char TYPE_CONVERT = 11;

const int TYPE_DECODE_1_BYTE = 1;
const int TYPE_DECODE_2_BYTE = 2;
const int TYPE_DECODE_JSON = 3;

class ODSocket : cocos2d::Object
{

public:
	ODSocket(SOCKET sock = INVALID_SOCKET);
	~ODSocket();

	// Create socket object for snd/recv data
	bool Create(int bufPackMax);

	// Connect socket
	bool Connect(const char* ip, unsigned short port);

	//#endregion
	
	// Send socket
	int Send(const char* buf, int len, int flags = 0);

	// Recv socket
	int Recv(char* buf, int len, int flags = 0);
	
	// Close socket
	int Close();

	// Get errno
	int GetError();
	
	//#pragma region just for win32
	// Init winsock DLL 
	static int Init();	
	// Clean winsock DLL
	static int Clean();
	//#pragma endregion

	ODSocket& operator = (SOCKET s);

	operator SOCKET ();

	cocos2d::LUA_FUNCTION rhand;
	char* buf;
	int bufLen;
	int bufPackIndex;
	int bufPackMax;
	// -2 ¡¨Ω” ß∞‹Œ¥∑µªÿ£¨£≠1¡¨Ω”÷–£¨0Œ¥Ω¯––¡¨Ω”£¨1¡¨Ω”≥…π¶Œ¥∑µªÿ£¨2¡¨Ω”≥…π¶
	int connectStatus;
    int decodeType; // 解密类型

	// ∑¥”≥…‰±Ì
	int tableIndex;
	int tableLen;
	std::map<int,SocketType*>* protoMap; // –≠“È”≥…‰
	std::map<int, std::string>* typeMap; // ¿‡–Õ”≥…‰
	//std::thread s_connectThread;
	//std::thread s_recvThread;
	std::condition_variable s_sendCond;
	std::mutex s_recvDataQueueMutex;

    void update(float dt);
    void readObj(lua_State *l,char *buf,unsigned char type); // 1字节表示自定义类长度
    void readObj2(lua_State *l,char *buf,unsigned char type); // 2字节表示自定义类长度
	void readJsonObj(lua_State *l, char *buf); // 使用json格式 
	void push(char* buf,int len,int recvSize);
	void checkPack();
	void setNonblock(int socket);
	void doupdate();
protected:
	SOCKET m_sock;

	std::queue<char*> msgList;
	std::queue<int> msgLenList;
	std::queue<int> msgSizeList;
};

#endif
