#include "MainUI.h"
#include "SelectValue.h"
#include "ArenaUI.h"

bool MainUI::init()
{
	UILayer* m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer, 0, 0);

	Layout* m_time = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("main/main.json"));
	m_pUiLayer->addWidget(m_time);

	UIButton* _btn0 = dynamic_cast<UIButton*>(m_time->getChildByName("Button_25"));
	UIButton* _btn1 = dynamic_cast<UIButton*>(m_time->getChildByName("Button_26"));

	_btn0->addTouchEventListener(this, toucheventselector(MainUI::Callback0));
	_btn1->addTouchEventListener(this, toucheventselector(MainUI::Callback1));

	return true;
}

CCScene * MainUI::scene()
{
	CCScene *sc = CCScene::create();
	sc->addChild(MainUI::create());
	return sc;
}

void MainUI::Callback0(CCObject* pSender, TouchEventType eventType)
{
	CCDirector::sharedDirector()->replaceScene(SelectValue::scene());
}

void MainUI::Callback1(CCObject* pSender, TouchEventType eventType)
{
	CCDirector::sharedDirector()->replaceScene(ArenaUI::scene());
}