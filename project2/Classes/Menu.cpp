#include "Menu.h"
#include "MainLogic.h"
#include "BasicLayer.h"
#include "SelectValue.h"

//  ����� �ս���Ϸ��������

Menu::Menu() 
{

}
Menu::~Menu()
{
}
bool Menu::init()
{
	if ( !CCLayer::init() )
	{
		return false;
	}
	Init();
	return true;
}
void Menu::Init()
{
	schedule(schedule_selector(Menu::ggg),1);

	a= 0;

	CCSprite * im = CCSprite ::create("WB_MainLogic_1/background.jpg");
	addChild(im);

	//BasicLayer basicLayer;
	//basicLayer.runNestSound(0);  // ���ſ�ʼ��Ч

}
void Menu::ggg(float delta)
{
	a++;
	if(a>=15)
	{
		CCDirector::sharedDirector()->replaceScene(CCTransitionRotoZoom::create(0.5,SelectValue::scene())); //�л���SelectTime
	}
}




CCScene * Menu::scene()
{
	CCScene *sc = CCScene::create();
	sc->addChild( Menu::create());
	return sc;
}		