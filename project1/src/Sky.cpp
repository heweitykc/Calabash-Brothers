#include "Sky.h"

ccColor4F Sky::randomBrightColor()
{
	while (true){
		float requiredBrightness = 192;
		ccColor4B randomColor =
			ccc4(CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, 0);
		if (randomColor.r > requiredBrightness ||
			randomColor.g > requiredBrightness ||
			randomColor.b > requiredBrightness) {
			return ccc4FFromccc4B(randomColor);
		}
	}
}

void Sky::genBackground()
{
	ccColor4F bgColor = randomBrightColor();
}

void Sky::setupWorld()
{
	b2Vec2 gravity = b2Vec2(0.0f, -7.0f);
	_world = new b2World(gravity);
	_world->SetAllowSleeping(true);
}

bool Sky::init()
{
	this->setTouchEnabled(true);
	_tapDown = false;

	setupWorld();
	setupDebugDraw();

	_terrain = Terrain::create();
	_terrain->initWithWorld(_world);
	this->addChild(_terrain);

	genBackground();	
	this->scheduleUpdate();
	this->setScale(1.0f);

	_hero = Hero::create();
	_hero->initWithWorld(_world);

	_terrain->getbatchNode()->addChild(_hero);

	return true;
}

void Sky::update(float delta)
{
	static double UPDATE_INTERVAL = 1.0f / 60.0f;
	static double MAX_CYCLES_PER_FRAME = 5;
	static double timeAccumulator = 0;

	timeAccumulator += delta;
	if (timeAccumulator > (MAX_CYCLES_PER_FRAME * UPDATE_INTERVAL)) {
		timeAccumulator = UPDATE_INTERVAL;
	}

	int32 velocityIterations = 3;
	int32 positionIterations = 2;
	while (timeAccumulator >= UPDATE_INTERVAL) {
		timeAccumulator -= UPDATE_INTERVAL;
		if (_tapDown) {
			if (!_hero->getAwake()) {
				_hero->wake();
				_tapDown = true;
			} else {
				_hero->dive();
			}
		} else {
			_hero->nodive();
		}
		_hero->limitVelocity();

		_world->Step(UPDATE_INTERVAL,velocityIterations, positionIterations);
		_world->ClearForces();
	}

	_hero->update();

	float offset = _hero->getPositionX();

	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	float scale = (winSize.height * 3 / 4) / _hero->getPositionY();
	if (scale > 1) scale = 1;
	_terrain->setScale(scale);
	_terrain->setOffsetX(offset);

	/*
	CCSize textureSize = _background->getTextureRect().size;
	_background->setTextureRect(CCRectMake(offset*0.7, 0, textureSize.width, textureSize.height));
	*/
}

void Sky::onTouchesBegan(const std::vector<Touch*>& touches, Event *unused_event)
{
	CCLOG("ccTouchesBegan");
	genBackground();
	_tapDown = true;
}

void Sky::onTouchesCancelled(const std::vector<Touch*>& touches, Event *unused_event)
{
	_tapDown = false;
}

void Sky::onTouchesEnded(const std::vector<Touch*>& touches, Event *unused_event)
{
	_tapDown = false;
}

void Sky::setupDebugDraw()
{
	_debugDraw = new GLESDebugDraw(PTM_RATIO*CCDirector::sharedDirector()->getContentScaleFactor());
	_world->SetDebugDraw(_debugDraw);
	_debugDraw->SetFlags(GLESDebugDraw::e_shapeBit);
}

CCScene* Sky::scene()
{
	CCScene *scene = CCScene::create();
	Sky *layer = Sky::create();	
	scene->addChild(layer);
	return scene;
}