#include "SelectValue.h"
#include "BasicLayer.h"
#include "MainLogic.h"

using namespace ui;

//  ����� �� ѡ��ʱ��,ѡ��ʼ�������� ����
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
	Value = 0;
	Game_Time = 1;

	UILayer* m_pUiLayer = UILayer::create();
	m_pUiLayer->scheduleUpdate();
	addChild(m_pUiLayer,0,0);

	// ���� ѡ��ʱ��� josn�ļ�
	Layout* m_time = dynamic_cast<Layout*>(GUIReader::shareReader()->widgetFromJsonFile("WBOne_Menu_1/WBOne_Menu_1.json"));
	m_pUiLayer->addWidget(m_time);

	// ���뱾����� �˸���ť����ͬ m_time josn�ļ���ã����ĸ���ť

	for ( int i =0 ;i<9 ; i++)
	{
		m_time_niu[i] = dynamic_cast<UIButton*>(m_time->getChildByName("Panel")->getChildByTag(i+100));	
		m_time_niu[i]->setPressedActionEnabled(true);
		//m_time_niu[i]->addReleaseEvent(this,menu_selector(SelectValue::Callback));  // �����ĸ���ť����ص�
		m_time_niu[i]->addTouchEventListener(this, toucheventselector(SelectValue::Callback));
	}
	for ( int i =0 ;i<4 ; i++)
	{
		time_view[i] = dynamic_cast<UIImageView*>(m_time->getChildByName("Panel")->getChildByTag(i + 200));
		time_view[i]->setVisible(false);
	}
	time_view[0]->setVisible(true);

}

//  ��ť�Ļص�����
void SelectValue::Callback(CCObject* pSender, TouchEventType eventType)
{
	int  a  = dynamic_cast<UIButton*>(pSender)->getTag();  //  ͨ����ť��tagֵ���ж��ǵ�����ĸ���ť
	switch (a)
	{
		//��ʼ��Ϸ��ť
	case 100:   
		m_time_niu[0]->setBright(false);
		m_time_niu[1]->setBright(true);
		m_time_niu[2]->setBright(true);

		Value = 1;
		break;  
		//��ʼ����ѡ����ĸ���ť
	case 101:    //��ʼ��1-5��ť
		m_time_niu[1]->setBright(false);
		m_time_niu[0]->setBright(true);
		m_time_niu[2]->setBright(true);

		Value = 2;
		break;
	case 102://��ʼ��6-9��ť
		m_time_niu[2]->setBright(false);
		m_time_niu[0]->setBright(true);
		m_time_niu[1]->setBright(true);
		Value = 3;
		break;
	case 103:
		time_view[0]->setVisible(true);

		time_view[1]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[3]->setVisible(false);
		Game_Time  =1;
		break;
	case 104:
		time_view[1]->setVisible(true);
		time_view[0]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[3]->setVisible(false);
		Game_Time = 2;
		break;
	case 105:
		time_view[2]->setVisible(true);
		time_view[1]->setVisible(false);
		time_view[0]->setVisible(false);
		time_view[3]->setVisible(false);
		Game_Time = 3;
		break;	
	case 106:
		time_view[3]->setVisible(true);
		time_view[1]->setVisible(false);
		time_view[2]->setVisible(false);
		time_view[0]->setVisible(false);
		Game_Time = 5;
		break;
	case 107:
		if ( Game_Time !=0 && Value != 0)   
		{
			CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,MainLogic::scene())); //�л�������Ϸ����logic
		}
		break;
	case 108:
		//�˳���Ϸ
		CCDirector::sharedDirector()->end();
		break;
	case 201:
		//����ģʽ

		break;
	}
}



CCScene * SelectValue::scene()
{
	CCScene *sc = CCScene::create();
	sc->addChild( SelectValue::create());
	return sc;
}		