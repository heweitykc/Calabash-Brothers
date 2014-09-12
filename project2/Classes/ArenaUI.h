#ifndef _ARENAUI_H_
#define _ARENAUI_H_

#include "cocos2d.h"
USING_NS_CC;
#include "cocos-ext.h"

USING_NS_CC_EXT;
using namespace std;
using namespace ui;

class ArenaUI :public CCLayer
{
public:
	virtual bool init();
	static CCScene* scene();
	CREATE_FUNC(ArenaUI);

	void Callback0(CCObject* pSender, TouchEventType eventType);	

	UITextField *_input0;
};

#endif