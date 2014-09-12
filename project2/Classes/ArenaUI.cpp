#include "ArenaUI.h"
#include "MainLogic.h"
#include "GlobalApp.h"

bool ArenaUI::init()
{
	UILayer* m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer, 0, 0);	

	Layout* m_time = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("arena/arena.json"));
	m_pUiLayer->addWidget(m_time);

	UIButton* _btn0 = dynamic_cast<UIButton*>(m_time->getChildByName("Button_28"));	
	_input0 = dynamic_cast<UITextField*>(m_time->getChildByName("TextField_30"));

	_btn0->addTouchEventListener(this, toucheventselector(ArenaUI::Callback0));

	return true;
}

CCScene * ArenaUI::scene()
{
	CCScene *sc = CCScene::create();
	sc->addChild(ArenaUI::create());
	return sc;
}

void ArenaUI::Callback0(CCObject* pSender, TouchEventType eventType)
{
	//竞赛模式
	std::string *namestr = new std::string(_input0->getStringValue());
	if (namestr->size() <= 0) return;

	GlobalApp::mode = 1;
	GlobalApp::uname = namestr;
	CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5, MainLogic::scene())); //切换到主游戏界面logic	
}
