/*
 * define file about portable socket class. 
 * description:this sock is suit both windows and linux
 * design:odison
 * e-mail:odison@126.com>
 * 
 */

#ifndef _SOCKET_H_
#define _SOCKET_H_

extern "C" {
#include "tolua++.h"
}

//#include "cocos2d.h"
//#include "CCLuaValue.h"
//#include "CCLuaEngine.h"

namespace cocos2d{
	class Node;
	class GLProgram;
}

void init_socket(lua_State * l);
int connect(lua_State * l);
int isConnect(lua_State * l);
int disconnect(lua_State * l);
int send(lua_State * l);
int readZip(lua_State * l);
int initTypeMap(lua_State *l);
int initProtoMap(lua_State *l);
int setDecodeType(lua_State *l);

int node_gray(lua_State *l);
void node_set_shader_program(cocos2d::Node* n, cocos2d::GLProgram* s);

void my_print(lua_State *l);

void* thread_recv(void *arg);
void* thread_connect(void *arg);
#endif
