#include "SelectValue.h"
#include "BasicLayer.h"
#include "MainLogic.h"
#include "GlobalApp.h"

using namespace ui;

//  这个类 是 选择时间,选择开始结束数的 界面
SelectValue::SelectValue() 
{
	
}
SelectValue::~SelectValue()
{
}
bool SelectValue::init()
{
	if ( !CCLayer::init() )
	{
		return false;
	}

	Init();

	return true;
}

void SelectValue::Init()
{
	GlobalApp::Value = 0;
	GlobalApp::Game_Time = 1;

	UILayer* m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer,0,0);

	// 加载 选择时间的 json文件
	Layout* m_time = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("WBOne_Menu_1/WBOne_Menu_1.json"));
	m_pUiLayer->addWidget(m_time);

	// 申请本界面的 八个按钮，并同 m_time josn文件获得，这四个按钮
	for ( int i =0 ;i<9 ; i++){
		m_time_niu[i] = dynamic_cast<UIButton*>(m_time->getChildByName("Panel")->getChildByTag(i+100));	
		m_time_niu[i]->setPressedActionEnabled(true);
		//m_time_niu[i]->addReleaseEvent(this,menu_selector(SelectValue::Callback));  // 给这四个按钮加入回调
		m_time_niu[i]->addTouchEventListener(this, toucheventselector(SelectValue::Callback));
	}

	for ( int i =0 ;i<4 ; i++){
		time_view[i] = dynamic_cast<UIImageView*>(m_time->getChildByName("Panel")->getChildByTag(i + 200));
		time_view[i]->setVisible(false);
	}

	time_view[0]->setVisible(true);

	/*
	CCScale9Sprite* sacel9SprY = CCScale9Sprite::create("picc2.png");
	_editbox = CCEditBox::create(CCSizeMake(100, 30), sacel9SprY);	
	_editbox->setFontColor(ccc3(255,255,255));
	_editbox->setPosition(ccp(700,110));
	_editbox->setPlaceHolder("input yout name!!");
	this->addChild(_editbox);
	*/
}

//  按钮的回调方法
void SelectValue::Callback(CCObject* pSender, TouchEventType eventType)
{
	int  a  = dynamic_cast<UIButton*>(pSender)->getTag();  //  通过按钮的tag值，判断是点击的哪个按钮
	switch (a)
	{
		//开始游戏按钮
	case 100:   
		m_time_niu[0]->setBright(false);
		m_time_niu[1]->setBright(true);
		m_time_niu[2]->setBright(true);

		GlobalApp::Value = 1;
		break;  
		//开始数字选择的四个按钮
	case 101:    //开始号1-5按钮
		m_time_niu[1]->setBright(false);
		m_time_niu[0]->setBright(true);
		m_time_niu[2]->setBright(true);

		GlobalApp::Value = 2;
		break;
	case 102://开始号6-9按钮
		m_time_niu[2]->setBright(false);
		m_time_niu[0]->setBright(true);
		m_time_niu[1]->setBright(true);
		GlobalApp::Value = 3;
		break;
	case 103:
		time_view[0]->setVisible(true);

		time_view[1]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[3]->setVisible(false);
		GlobalApp::Game_Time  =1;
		break;
	case 104:
		time_view[1]->setVisible(true);
		time_view[0]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[3]->setVisible(false);
		GlobalApp::Game_Time = 2;
		break;
	case 105:
		time_view[2]->setVisible(true);
		time_view[1]->setVisible(false);
		time_view[0]->setVisible(false);
		time_view[3]->setVisible(false);
		GlobalApp::Game_Time = 3;
		break;	
	case 106:
		time_view[3]->setVisible(true);
		time_view[1]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[0]->setVisible(false);
		GlobalApp::Game_Time = 5;
		break;
	case 107:
		if (GlobalApp::Game_Time != 0 && GlobalApp::Value != 0)
		{
			GlobalApp::mode = 0;
			CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,MainLogic::scene())); //切换到主游戏界面logic
		}
		break;
	case 108:
		//退出游戏
		CCDirector::sharedDirector()->end();
		break;
	case 109:
		break;
	}
}



CCScene * SelectValue::scene()
{
	CCScene *sc = CCScene::create();
	sc->addChild( SelectValue::create());
	return sc;
}		