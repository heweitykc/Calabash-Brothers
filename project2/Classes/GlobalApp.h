#ifndef _GLOBALAPP_H_
#define _GLOBALAPP_H_
#include <string>

class GlobalApp
{
public:
	static int mode;						// 0:��ͨģʽ   1:����ģʽ
	static std::string *uname;		// �û���
	static int GlobalApp::Game_Time;
	static int GlobalApp::Value;
};

#endif