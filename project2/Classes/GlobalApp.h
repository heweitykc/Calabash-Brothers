#ifndef _GLOBALAPP_H_
#define _GLOBALAPP_H_
#include <string>

class GlobalApp
{
public:
	static int mode;						// 0:普通模式   1:竞技模式
	static std::string *uname;		// 用户名
	static int GlobalApp::Game_Time;
	static int GlobalApp::Value;
};

#endif