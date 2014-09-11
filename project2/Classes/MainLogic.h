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

	virtual void keyBackClicked();       //android���ؼ�
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
	int minute_int;  // ����

	char second_char[11];
	int second_int;  // ��
	bool Time_open;  //  ʱ��Ŀ���
	UILabelAtlas * label_minute;
	UILabelAtlas * label_second;

	Layout * Lvup;  //  �õ�������json�ļ�
	UIImageView * Lv_image[3];  //�õ�������ͼƬ
	CCParticleSystemQuad * m_emitter;   //  �õ�����������Ч��

	int LV;   //��ǰ�ȼ�
	int KongZhi_Lvup; // ��������ı���
	int delayed;   //  ����������ʱ�� ʱ�仺�����
	bool isLvUi_show;  //  ��ʾ���������  ����
	int isLvUi_int;    //��ʾ���������  ����ʱ

	WebSocket* _wsiSendText;
};
#endif