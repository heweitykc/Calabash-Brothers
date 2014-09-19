#include "PlayerTown.h"
#include "HelloWorldScene.h"

#include <string>

USING_NS_CC;
using namespace cocostudio;

Scene* PlayerTown::createScene()
{
	// 'scene' is an autorelease object
	auto scene = Scene::create();

	// 'layer' is an autorelease object
	auto layer = PlayerTown::create();

	// add layer as a child to scene
	scene->addChild(layer);

	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
bool PlayerTown::init()
{
	//////////////////////////////
	// 1. super init first
	if (!Layer::init())
	{
		return false;
	}
	
	Size visibleSize = Director::getInstance()->getVisibleSize();
	Vec2 origin = Director::getInstance()->getVisibleOrigin();

	auto closeItem = MenuItemImage::create(
		"CloseNormal.png",
		"CloseSelected.png",
		CC_CALLBACK_1(PlayerTown::menuCloseCallback, this));

	closeItem->setPosition(Vec2(origin.x + visibleSize.width - closeItem->getContentSize().width / 2,
		origin.y + closeItem->getContentSize().height / 2));

	auto menu = Menu::create(closeItem, NULL);
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu, 1);

	auto sprite = Sprite::create("HelloWorld.png");
	sprite->setPosition(Vec2(visibleSize.width / 2 + origin.x, visibleSize.height / 2 + origin.y));
	addChild(sprite);

	ArmatureDataManager::getInstance()->addArmatureFileInfo("armature/knight.png", "armature/knight.plist", "armature/knight.xml");
	ArmatureDataManager::getInstance()->addArmatureFileInfo("HeroAnimation/HeroAnimation0.png", "HeroAnimation/HeroAnimation0.plist", "HeroAnimation/Hero.ExportJson");
	ArmatureDataManager::getInstance()->addArmatureFileInfo("armature/armature1.ExportJson");
	ArmatureDataManager::getInstance()->addArmatureFileInfo("armature/horse.ExportJson");
	ArmatureDataManager::getInstance()->addArmatureFileInfo("newres/armature1.ExportJson");

	_hero = Armature::create("armature1");
	_hero->getAnimation()->playByIndex(0);
	this->addChild(_hero);
	_hero->setPosition(200, 300);

	_horse = Armature::create("horse");
	_horse->getAnimation()->playByIndex(1);
	this->addChild(_horse);
	_horse->setPosition(200, 300);
	
	//_hero->getBone("hero")->removeDisplay(0);
	//_hero->stopAllActions();

	_msglb = LabelTTF::create("Hello World", "Arial", 24);
	this->addChild(_msglb);

	a = 1;
	_cc = 0;
	this->schedule(schedule_selector(PlayerTown::move));

	return true;
}

void PlayerTown::move(float dt)
{	
	float nowx = _hero->getPositionX();
	if (nowx > 600){
		a = -1;
		_hero->setScaleX(-1);
	} else if (nowx <= 310){
		a = 1;
		_hero->setScaleX(1);
	}
	_hero->setPosition(nowx + a * 3, 300);
	std::stringstream ss;
	ss << _cc;
	std::string lbstr;
	ss >> lbstr;
	_msglb->setString(lbstr);
	_cc++;	
}

void PlayerTown::menuCloseCallback(Ref* pSender)
{
	Director::getInstance()->replaceScene(HelloWorld::createScene());
}
