#include "MainLogic.h"
#include "BasicLayer.h"
#include "SelectValue.h"
#include "SimpleAudioEngine.h"

using namespace ui;

// 这个类是游戏中的界面，主逻辑
MainLogic::MainLogic()
{
	winSize = CCDirector::sharedDirector()->getWinSize();  //  获取屏幕大小
	this->setKeypadEnabled(true);  //  开启返回键
	CCDirector::sharedDirector()->getTouchDispatcher()->addTargetedDelegate(this,0,false);        //添加触摸响应事件//

	minute_int = Game_Time-1;
	second_int = 60;

	schedule(schedule_selector(MainLogic::walk_time),1);   // 时间变化的schedule(schedule_selector）；
	schedule(schedule_selector(MainLogic::LV_logic),0.016);   //   检测升级

	_wsiSendText = new WebSocket();
	_wsiSendText->init(*this, "ws://115.28.42.84:8201");
}
MainLogic::~MainLogic()
{
}
bool MainLogic::init()  //初始化场景
{
	if ( !CCLayer::init() )
	{
		return false;
	}
	Init();
	Select();
	return true;
}
void MainLogic::Init()  // 初始化
{
	Down_id = 0;
	for ( int i =0 ; i<3 ;i++)
	{
		label_int[i] = 0;
	}
	Key_open = false;  // 按键的开关
	Time_open = true;

	LV = 0;   //当前等级
	KongZhi_Lvup = 0;// 完成升级的变量
	delayed = 0;   //  当可以升级时的 时间缓冲变量
	isLvUi_show = false;  //  显示升级界面的  开关
	isLvUi_int = 100;    //显示升级界面的  倒计时


	m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer,0,0);

	// 加载 主游戏背景的 josn文件 ,
	mainLogic = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("WBOne_MainLogic_1/WBOne_MainLogic_1.json"));
	m_pUiLayer->addWidget(mainLogic);

	for ( int i = 0; i<3; i++)
	{
		label[i] = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByTag(i + 200));      // 获得场景的 三个数字标签，分别是已答，正确，错误
		sprintf(label_char,"%d",label_int[i]);
		label[i] ->setStringValue(label_char);

	}

	Quit_niu = dynamic_cast<UIButton*>(mainLogic->getChildByName("Panel")->getChildByTag(100));	//获得 场景的 退出按钮
	Quit_niu->setPressedActionEnabled(true);	
	Quit_niu->addTouchEventListener(this, toucheventselector(MainLogic::callBack)); // 给 退出按钮加入回调	

	label_minute = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByName("ImageView")->getChildByTag(1000));       //获得  时间 分 的 数字标签
	sprintf(minute_char,"%d",minute_int);
	label_minute->setStringValue(minute_char);

	label_second = dynamic_cast<UILabelAtlas*>(mainLogic->getChildByName("Panel")->getChildByName("ImageView")->getChildByTag(1001));           //获得  时间 秒 的 数字标签
	sprintf(second_char,"%d",second_int);
	label_second->setStringValue(second_char);

	//============================以下是关于奖励的

	UILayer * m_pUiLayer1 = UILayer::create();
	m_pUiLayer1->scheduleUpdate();
	addChild(m_pUiLayer1,5,0);

	// 加载 得到奖励的 josn文件
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

void MainLogic::Select()      // 选择 数值  函数
{
	//设置时间种子 ，可以使用随机数
	cc_timeval psv;
	CCTime::gettimeofdayCocos2d(&psv, NULL);
	unsigned long int seed = psv.tv_sec*1000 + psv.tv_usec/1000;
	srand(seed);

	
	if ( Value == 1)    //   当Value值等于1时，右边是1-5.
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
		typ =CCRANDOM_0_1()*5+1;                  // 把左边的数 随机在1-5之间
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value == 2)    //   当Value值等于2时，右边是6-10.
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
		typ =CCRANDOM_0_1()*5+6;           // 把左边的数 随机在6-10之间
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	if ( Value == 3)    //   当Value值等于3时，右边是1-10.
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
		typ =CCRANDOM_0_1()*10+1;         // 把左边的数 随机在1-10之间
		sprintf(map_page,"picc%d.png",typ);
		Image = CCSprite::create(map_page);
		addChild(Image);
		Image->setPosition(ccp( 150 , 240));
	}
	
}
void MainLogic::LV_logic(float dt)
{

	if ( isLvUi_show == true)         // 当出现 得到奖励的 界面后，isLvUi_int减少，还原成原样
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
	for ( int i = LV;  i<3; i++)         // 当满足 得到奖励的 积分时
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
void MainLogic::walk_time(float dt)  //  控制时间减少
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
bool MainLogic::ccTouchBegan(cocos2d::CCTouch * pTouch,cocos2d::CCEvent *pEvent)  // 触笔按下回调
{
	CCPoint location = pTouch->getLocationInView();  
	//将触摸点转换为GL坐标系的点  
	location = CCDirector::sharedDirector()->convertToGL(location);  
	

	if ( Value == 1)
	{
		for ( int i =1; i<6; i++)
		{
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)       // 当点击的 是这5个数里面的 其中一个时
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
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)        // 当点击的 是这5个数里面的 其中一个时
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
			if (value_image[i]->boundingBox().containsPoint(location) && Key_open == false)   // 当点击的 是这10个数里面的 其中一个时
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
void MainLogic::ccTouchMoved(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent)    //触笔移动回调
{

}
void MainLogic::ccTouchEnded(cocos2d::CCTouch *pTouch,cocos2d::CCEvent *pEvent)   //触笔抬起回调
{
	BasicLayer basicLayer;
	basicLayer.runNestSound(Down_id); 
	CCLog("DDDDDDDDDD %d" , Down_id);
	if ( Down_id == typ)  //当点击的 数值和左边的 数 相同时， 播放特效，正确+1，
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
		par->runAction(CCSequence::create(a,CCCallFunc::create(this, callfunc_selector(MainLogic::Public_Call)),NULL)); //  给这个MoveTo加入回调

		label_int[1] +=1;
		sprintf(label_char,"%d",label_int[1]);
		label[1] ->setStringValue(label_char);
		Key_open = true;//  按下按键后Key_open = true，防止重复按

		

	}
	else   //当点击的 数值和左边的 数 不相同时， 错误数+1，
	{
		label_int[2] +=1;
		sprintf(label_char,"%d",label_int[2]);
		label[2] ->setStringValue(label_char);
	}
	
}
void MainLogic::Public_Call()  
{
	this->removeChild(Image,true);  // 卸掉 左边的图片
	this->removeChild(par,true);    // 卸掉 粒子效果
	Key_open = false;
	KongZhi_Lvup +=1;


	//以下是重新  构造 根据 value 的值从新构造 左边的图片
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
	CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,SelectValue::scene())); //切换到主游戏界面logic
}


void MainLogic::callBack(CCObject* pSender, TouchEventType eventType)
{
	CCDirector::sharedDirector()->end(); // 退出 游戏
}

//安卓 返回键的回调
void MainLogic::keyBackClicked(){
	CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,SelectValue::scene())); //切换到主游戏界面logic
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