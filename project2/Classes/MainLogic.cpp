#include "MainLogic.h"
#include "BasicLayer.h"
#include "SelectValue.h"
#include "SimpleAudioEngine.h"

using namespace ui;

// ���������Ϸ�еĽ��棬���߼�
MainLogic::MainLogic()
{
	winSize = CCDirector::sharedDirector()->getWinSize();  //  ��ȡ��Ļ��С
	this->setKeypadEnabled(true);  //  �������ؼ�
	CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this,0,false);        //��Ӵ�����Ӧ�¼�//

	minute_int = Game_Time-1;
	second_int = 60;

	schedule(schedule_selector(MainLogic::walk_time),1);   // ʱ��仯��schedule(schedule_selector����
	schedule(schedule_selector(MainLogic::LV_logic),0.016);   //   �������

	_wsiSendText = new WebSocket();
	_wsiSendText->init(*this, "ws://115.28.42.84:8201");
}
MainLogic::~MainLogic()
{
}
bool MainLogic::init()  //��ʼ������
{
	if ( !CCLayer::init() )
	{
		return false;
	}
	Init();
	Select();
	return true;
}
void MainLogic::Init()  // ��ʼ��
{
	Down_id = 0;
	for ( int i =0 ; i<3 ;i++)
	{
		label_int[i] = 0;
	}
	Key_open = false;  // �����Ŀ���
	Time_open = true;

	LV = 0;   //��ǰ�ȼ�
	KongZhi_Lvup = 0;// ��������ı���
	delayed = 0;   //  ����������ʱ�� ʱ�仺�����
	isLvUi_show = false;  //  ��ʾ���������  ����
	isLvUi_int = 100;    //��ʾ���������  ����ʱ


	m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer,0,0);

	// ���� ����Ϸ������ josn�ļ� ,
	mainLogic = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("WBOne_MainLogic_1/WBOne_MainLogic_1.json"));
	m_pUiLayer->addWidget(mainLogic);

	for ( int i = 0; i<3; i++)
	{
		label[i] = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByTag(i + 200));      // ��ó����� �������ֱ�ǩ���ֱ����Ѵ���ȷ������
		sprintf(label_char,"%d",label_int[i]);
		label[i] ->setStringValue(label_char);

	}

	Quit_niu = dynamic_cast<UIButton*>(mainLogic->getChildByName("Panel")->getChildByTag(100));	//��� ������ �˳���ť
	Quit_niu->setPressedActionEnabled(true);	
	Quit_niu->addTouchEventListener(this, toucheventselector(MainLogic::callBack)); // �� �˳���ť����ص�	

	label_minute = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByName("ImageView")->getChildByTag(1000));       //���  ʱ�� �� �� ���ֱ�ǩ
	sprintf(minute_char,"%d",minute_int);
	label_minute->setStringValue(minute_char);

	label_second = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByName("ImageView")->getChildByTag(1001));           //���  ʱ�� �� �� ���ֱ�ǩ
	sprintf(second_char,"%d",second_int);
	label_second->setStringValue(second_char);

	//============================�����ǹ��ڽ�����

	UILayer * m_pUiLayer1 = UILayer::create();
	m_pUiLayer1->scheduleUpdate();
	addChild(m_pUiLayer1,5,0);

	// ���� �õ������� josn�ļ�
	Lvup = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("WB_Lvup_1/WB_Lvup_1.json"));
	m_pUiLayer1->addWidget(Lvup);
	UIButton * lv_niu[2];
	for ( int i = 0; i<2; i++)
	{
		lv_niu[i] = dynamic_cast<UIButton*>(Lvup->getChildByName("Panel")->getChildByTag(20 + i));
		lv_niu[i]->setEnabled(false);
		lv_niu[i]->setVisible(false);
	}
	for ( int i = 0; i<3; i++)
	{
		Lv_image[i] = dynamic_cast<UIImageView*>(Lvup->getChildByName("Panel")->getChildByTag(i + 10));
		Lv_image[i]->setVisible(false);
	}

	Lvup->setEnabled(false);

	m_emitter = CCParticleSystemQuad::create("Particle/a.plist");   
	m_emitter->m_bIsActive = false;
	m_emitter->setPosition(ccp(400,410));
	addChild(m_emitter,10);
	m_emitter->setLife(3.5f);
}

void MainLogic::Select()      // ѡ�� ��ֵ  ����
{
	//����ʱ������ ������ʹ�������
	cc_timeval psv;
	CCTime::gettimeofdayCocos2d(&psv, NULL);
	unsigned long int seed = psv.tv_sec*1000 + psv.tv_usec/1000;
	srand(seed);

	
	if ( Value == 1)    //   ��Valueֵ����1ʱ���ұ���1-5.
	{
		for ( int i=1;i<6;i++)
		{
			sprintf(map_page,"pic%d.png",i);
			value_image[i] = CCSprite::create(map_page);
			addChild(value_image[i]);
			if ( i<4)
			{
				value_image[i]->setPosition(ccp(400+((i-1)*120),180));
			}
			else
			{
				value_image[i]->setPosition(ccp(460+((i-4)*120),300));
			}
		}
		typ =CCRANDOM_0_1()*5+1;                  // ����ߵ��� �����1-5֮��
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value == 2)    //   ��Valueֵ����2ʱ���ұ���6-10.
	{
		for ( int i=6;i<11;i++)
		{
			sprintf(map_page,"pic%d.png",i);
			value_image[i] = CCSprite::create(map_page);
			addChild(value_image[i]);
			if ( i<9)
			{
				value_image[i]->setPosition(ccp(400+((i-6)*120),180));
			}
			else
			{
				value_image[i]->setPosition(ccp(460+((i-9)*120),300));
			}
		}
		typ =CCRANDOM_0_1()*5+6;           // ����ߵ��� �����6-10֮��
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value == 3)    //   ��Valueֵ����3ʱ���ұ���1-10.
	{
		for ( int i=1;i<11;i++)
		{
			sprintf(map_page,"pic%d.png",i);
			value_image[i] = CCSprite::create(map_page);
			addChild(value_image[i]);
			if ( i<4)
			{
				value_image[i]->setPosition(ccp(400+((i-1)*120),96));
			}
			else if (i>=4 && i<=6)
			{
				value_image[i]->setPosition(ccp(400+((i-4)*120),192));
			}
			else if (i>=7 && i<=9)
			{
				value_image[i]->setPosition(ccp(400+((i-7)*120),288));
			}
			else if (i==10)
			{
				value_image[i]->setPosition(ccp(520,384));
			}
		}
		typ =CCRANDOM_0_1()*10+1;         // ����ߵ��� �����1-10֮��
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	
}
void MainLogic::LV_logic(float dt)
{

	if ( isLvUi_show == true)         // ������ �õ������� �����isLvUi_int���٣���ԭ��ԭ��
	{
		isLvUi_int -- ;
		if ( isLvUi_int <=0)
		{
			mainLogic->setEnabled(true);
			Lvup->setEnabled(false);
			isLvUi_show = false;
			m_emitter->m_bIsActive = false;
			isLvUi_int = 0;
		}
	}
	for ( int i = LV;  i<3; i++)         // ������ �õ������� ����ʱ
	{
		if( KongZhi_Lvup >= 10+i*5)
		{
			delayed++;
			if ( delayed>=30)
			{
				Lvup->setEnabled(true);
				mainLogic->setEnabled(false);
				Lv_image[i]->setVisible(true);
				m_emitter->m_bIsActive = true;
				LV +=1;
				KongZhi_Lvup = 0;
				isLvUi_show = true;

				delayed = 0;
				isLvUi_int = 100;

			}
		}
	}
}
void MainLogic::walk_time(float dt)  //  ����ʱ�����
{
	second_int -=1;
	if ( second_int ==15 && minute_int ==0)
	{
		CCSprite * im = CCSprite::create("tishi1.png");
		im->setPosition(ccp(400,240));
		addChild(im);
		CCScaleTo * fa = CCScaleTo::create(0.5f,1.5f);
		CCScaleTo * fa1 = CCScaleTo::create(0.5f,0.5f);
		CCScaleTo * fa2 = CCScaleTo::create(0.5f,1.5f);
		CCScaleTo * fa3 = CCScaleTo::create(0.5f,0.5f);
		CCScaleTo * fa4 = CCScaleTo::create(0.5f,1.5f);
		CCScaleTo * fa5 = CCScaleTo::create(0.5f,0.5f);
		CCScaleTo * fa6 = CCScaleTo::create(0.5f,1.0f);
		CCFadeOut * kj = CCFadeOut::create(1.0f);
		im->runAction(CCSequence::create(fa,fa1,fa2,fa3,fa4,fa5,fa6,kj,NULL));
	}
	if ( second_int <0)
	{
		minute_int -= 1;
		if ( minute_int<0)
		{
			minute_int = 0;
			second_int = 0;

			if ( Time_open == true)
			{
				CCSprite * im = CCSprite::create("tishi2.png");
				im->setPosition(ccp(400,240));
				addChild(im);
				CCScaleTo * fa = CCScaleTo::create(0.4f,1.5f);
				CCScaleTo * fa1 = CCScaleTo::create(0.4f,0.5f);
				CCScaleTo * fa2 = CCScaleTo::create(0.4f,1.5f);
				CCScaleTo * fa3 = CCScaleTo::create(0.4f,0.5f);
				CCScaleTo * fa4 = CCScaleTo::create(0.4f,1.5f);
				CCScaleTo * fa5 = CCScaleTo::create(0.4f,0.5f);
				CCScaleTo * fa6 = CCScaleTo::create(0.3f,1.0f);
				CCFadeOut * kj = CCFadeOut::create(1.4f);
				im->runAction(CCSequence::create(fa,fa1,fa2,fa3,fa4,fa5,fa6,kj,CCCallFunc::create(this, 
					callfunc_selector(MainLogic::Call_SelectTime)),NULL));

				Time_open = false;
			}
			
		}
		else
		{
			second_int = 59;

		}
	}
	sprintf(second_char,"%d",second_int);
	label_second->setStringValue(second_char);

	sprintf(minute_char,"%d",minute_int);
	label_minute->setStringValue(minute_char);

}
bool MainLogic::ccTouchBegan(cocos2d::CCTouch * pTouch,cocos2d::CCEvent *pEvent)  // ���ʰ��»ص�
{
	CCPoint location = pTouch->getLocationInView();  
	//��������ת��ΪGL����ϵ�ĵ�  
	location = CCDirector::sharedDirector()->convertToGL(location);  
	

	if ( Value == 1)
	{
		for ( int i =1; i<6; i++)
		{
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)       // ������� ����5��������� ����һ��ʱ
			{
				CCScaleTo * a = CCScaleTo::create(0.2f,1.5f,1.5f);
				CCScaleTo * b = CCScaleTo::create(0.2f,1.0f,1.0f);
				value_image[i]->runAction(CCSequence::create(a,b,NULL));
				Down_id = i;
				label_int[0] +=1;   
				sprintf(label_char,"%d",label_int[0]);
				label[0] ->setStringValue(label_char);
				return true;
			}
		}
	}
	if ( Value == 2)
	{
		for ( int i =6; i<11; i++)
		{
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)        // ������� ����5��������� ����һ��ʱ
			{
				CCScaleTo * a = CCScaleTo::create(0.2f,1.5f,1.5f);
				CCScaleTo * b = CCScaleTo::create(0.2f,1.0f,1.0f);
				value_image[i]->runAction(CCSequence::create(a,b,NULL));
				Down_id = i;
				label_int[0] +=1;
				sprintf(label_char,"%d",label_int[0]);
				label[0] ->setStringValue(label_char);
				return true;
			}
		}
	}
	if ( Value == 3)
	{
		for ( int i =1; i<11; i++)
		{
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)   // ������� ����10��������� ����һ��ʱ
			{
				CCScaleTo * a = CCScaleTo::create(0.2f,1.5f,1.5f);
				CCScaleTo * b = CCScaleTo::create(0.2f,1.0f,1.0f);
				value_image[i]->runAction(CCSequence::create(a,b,NULL));
				Down_id = i;
				label_int[0] +=1;
				sprintf(label_char,"%d",label_int[0]);
				label[0] ->setStringValue(label_char);
				return true;
			}
		}
	}

	return false;
}
void MainLogic::ccTouchMoved(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent)    //�����ƶ��ص�
{

}
void MainLogic::ccTouchEnded(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent)   //����̧��ص�
{
	BasicLayer basicLayer;
	basicLayer.runNestSound(Down_id); 
	CCLog("DDDDDDDDDD %d" , Down_id);
	if ( Down_id == typ)  //������� ��ֵ����ߵ� �� ��ͬʱ�� ������Ч����ȷ+1��
	{
		par = CCParticleSun::create();
		this->addChild(par, 10);
		par->setPosition(value_image[Down_id]->getPosition());
		CCMoveTo * a = CCMoveTo::create(0.8f,ccp( 150,240));
		//ccColor4F cccEnd={0,0,1.0,1.0};  
		//par->setStartColor(cccEnd);  
		//par->setStartColorVar(cccEnd);
		//par->setEndColor(cccEnd);
		//par->setEndColorVar(cccEnd);
		par->runAction(CCSequence::create(a,CCCallFunc::create(this, callfunc_selector(MainLogic::Public_Call)),NULL)); //  �����MoveTo����ص�

		label_int[1] +=1;
		sprintf(label_char,"%d",label_int[1]);
		label[1] ->setStringValue(label_char);
		Key_open = true;//  ���°�����Key_open = true����ֹ�ظ���

		

	}
	else   //������� ��ֵ����ߵ� �� ����ͬʱ�� ������+1��
	{
		label_int[2] +=1;
		sprintf(label_char,"%d",label_int[2]);
		label[2] ->setStringValue(label_char);
	}
	
}
void MainLogic::Public_Call()  
{
	this->removeChild(Image,true);  // ж�� ��ߵ�ͼƬ
	this->removeChild(par,true);    // ж�� ����Ч��
	Key_open = false;
	KongZhi_Lvup +=1;


	//����������  ���� ���� value ��ֵ���¹��� ��ߵ�ͼƬ
	if ( Value ==1)
	{
		typ =CCRANDOM_0_1()*5+1;
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value ==2)
	{
		typ =CCRANDOM_0_1()*5+6;
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value ==3)
	{
		typ =CCRANDOM_0_1()*10+1;
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
}

void MainLogic::Call_SelectTime()
{
	CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,SelectValue::scene())); //�л�������Ϸ����logic
}


void MainLogic::callBack(CCObject* pSender, TouchEventType eventType)
{
	CCDirector::sharedDirector()->end(); // �˳� ��Ϸ
}

//��׿ ���ؼ��Ļص�
void MainLogic::keyBackClicked(){
	CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,SelectValue::scene())); //�л�������Ϸ����logic
}
CCScene * MainLogic::scene(){
	CCScene *sc = CCScene::create();
	sc->addChild( MainLogic::create());
	return sc;
}	

void MainLogic::onOpen(WebSocket* ws)
{
	CCLOG("conencted");
}

void MainLogic::onMessage(WebSocket* ws, const WebSocket::Data& data)
{
	CCLOG("onMessage");
}

void MainLogic::onClose(WebSocket* ws)
{
	CCLOG("onClose");
}

void MainLogic::onError(WebSocket* ws, const WebSocket::ErrorCode& error)
{
	CCLOG("onError");
}