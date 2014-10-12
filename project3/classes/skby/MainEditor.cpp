#include "MainEditor.h"

USING_NS_CC;
using namespace ui;

Scene* MainEditor::createScene()
{
	auto scene = Scene::create();
	auto layer = MainEditor::create();
	scene->addChild(layer);
	return scene;
}

bool MainEditor::init()
{
	if (!Layer::init()){
		return false;
	}

	_touchGroup = Layer::create();
	addChild(_touchGroup);

	_layout0 = static_cast<Layout*>(cocostudio::GUIReader::getInstance()->widgetFromJsonFile("res/ui/skbyui_1/skbyui_1.json"));
	_touchGroup->addChild(_layout0);

	_roleBtn = static_cast<Button*>(Helper::seekWidgetByName(_layout0, "roletab"));
	_weaponBtn = static_cast<Button*>(Helper::seekWidgetByName(_layout0, "weapontab"));
	_playBtn = static_cast<Button*>(Helper::seekWidgetByName(_layout0, "playbtn"));
	_closeBtn = static_cast<Button*>(Helper::seekWidgetByName(_layout0, "closebtn"));

	_idtxt = static_cast<TextField*>(Helper::seekWidgetByName(_layout0, "idtxt"));
	_weaknumtxt = static_cast<TextField*>(Helper::seekWidgetByName(_layout0, "weaknumtxt"));

	_roleBtn->addTouchEventListener(CC_CALLBACK_2(MainEditor::touchEvent, this));
	_weaponBtn->addTouchEventListener(CC_CALLBACK_2(MainEditor::touchEvent, this));
	_playBtn->addTouchEventListener(CC_CALLBACK_2(MainEditor::touchEvent, this));
	_closeBtn->addTouchEventListener(CC_CALLBACK_2(MainEditor::touchEvent, this));

	return true;
}

void MainEditor::touchEvent(Ref *pSender, Widget::TouchEventType type)
{
	if (type != Widget::TouchEventType::ENDED) return;
	Button *btn = static_cast<Button*>(pSender);
	std::string btnname = btn->getName();
	if (btnname.compare("roletab") == 0){

	} else if (btnname.compare("weapontab") == 0){

	} else if (btnname.compare("closebtn") == 0){
		Director::getInstance()->end();
	} else if (btnname.compare("playbtn") == 0){
		
	}
}