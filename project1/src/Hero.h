#ifndef _HERO_H_
#define _HERO_H_

#define NUM_PREV_VELS   5

#include "cocos2d.h"
#include "Box2D\Box2D.h"
#include "GLES-Render.h"
#include "AppMacros.h"

USING_NS_CC;

#define NUM_PREV_VELS   5

class Hero : public CCSprite
{
public:
	CREATE_FUNC(Hero);

	b2World *_world;
	b2Body *_body;
	bool _awake;

	b2Vec2 _prevVels[NUM_PREV_VELS];
	int _nextVel;

	CCAnimation *_normalAnim;
	CCAnimate *_normalAnimate;

	bool getAwake();
	void wake();
	void dive();
	void limitVelocity();
	void initWithWorld(b2World *world);
	void update();
	void nodive();

	void createBody();
	void runNormalAnimation();
	void runForceAnimation();
};

#endif