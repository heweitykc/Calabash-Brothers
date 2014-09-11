#ifndef _GAME_H_
#define _GAME_H_

#include "cocos2d.h"
USING_NS_CC;
#include "cocos-ext.h"

USING_NS_CC_EXT;
using namespace std;
using namespace ui;

class SelectValue:public CCLayer
{
public:

	SelectValue();
	~SelectValue();

	virtual bool init();  
	static CCScene* scene();
	CREATE_FUNC(SelectValue);

public:
	void Init();
	void Callback(CCObject* pSender, TouchEventType eventType);

public:
	UIButton * m_time_niu[9];
	UIImageView * time_view[4];


};
#endif