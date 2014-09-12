#ifndef _MAINUI_H_
#define _MAINUI_H_

#include "cocos2d.h"
USING_NS_CC;
#include "cocos-ext.h"

USING_NS_CC_EXT;
using namespace std;
using namespace ui;

class MainUI :public CCLayer
{
public:
	virtual bool init();
	static CCScene* scene();
	CREATE_FUNC(MainUI);

	void Callback0(CCObject* pSender, TouchEventType eventType);
	void Callback1(CCObject* pSender, TouchEventType eventType);
};

#endif