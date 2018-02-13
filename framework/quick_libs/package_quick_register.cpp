#include "package_quick_register.h"

USING_NS_CC;

void package_quick_register()
{
    auto engine = LuaEngine::getInstance();
    lua_State* L = engine->getLuaStack()->getLuaState();
    luaopen_quick_extensions(L);
	init_socket(L);
    
    lua_getglobal(L, "_G");
    if (lua_istable(L, -1))//stack:...,_G,
    {
        luaopen_cocos2dx_extra_luabinding(L);
    }
    lua_pop(L, 1);
}

