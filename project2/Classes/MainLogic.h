#ifndef _MAINLOGIC_H_
#define _MAINLOGIC_H_

#include "cocos2d.h"
USING_NS_CC;
#include "cocos-ext.h"
#include "network\WebSocket.h"

USING_NS_CC_EXT;
using namespace std;
using namespace ui;

class MainLogic :public CCLayer, public WebSocket::Delegate
{
public:

	MainLogic();
	~MainLogic();

	virtual bool init();  
	static CCScene* scene();
	CREATE_FUNC(MainLogic);

	virtual void onOpen(WebSocket* ws);
	virtual void onMessage(WebSocket* ws, const WebSocket::Data& data);
	virtual void onClose(WebSocket* ws);
	virtual void onError(WebSocket* ws, const WebSocket::ErrorCode& error);

	bool ccTouchBegan(cocos2d::CCTouch * pTouch,cocos2d::CCEvent *pEvent);
	void ccTouchMoved(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent);
	void ccTouchEnded(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent);

	virtual void keyBackClicked();       //android返回键
	void Init();
	void Select();

	void callBack(CCObject* pSender, TouchEventType eventType);
	void Public_Call();
	void walk_time( float dt);
	void Call_SelectTime();
	void LV_logic(float dt);
public:
	CCSize winSize;

	UILayer* m_pUiLayer;
	Layout* mainLogic;
	UIButton * Quit_niu;
	UILabelAtlas * label[3];
	char label_char[11];
	int label_int[3];
	CCParticleSun* par;


	CCSprite * value_image[11];
	char map_page [11];
	int id;
	CCSprite * Image;
	int typ;
	int Down_id;

	bool Key_open;

	char minute_char[11];
	int minute_int;  // 分数

	char second_char[11];
	int second_int;  // 秒
	bool Time_open;  //  时间的开关
	UILabelAtlas * label_minute;
	UILabelAtlas * label_second;

	Layout * Lvup;  //  得到奖励的json文件
	UIImageView * Lv_image[3];  //得到奖励的图片
	CCParticleSystemQuad * m_emitter;   //  得到奖励的例子效果

	int LV;   //当前等级
	int KongZhi_Lvup; // 完成升级的变量
	int delayed;   //  当可以升级时的 时间缓冲变量
	bool isLvUi_show;  //  显示升级界面的  开关
	int isLvUi_int;    //显示升级界面的  倒计时

	WebSocket* _wsiSendText;
};
#endif