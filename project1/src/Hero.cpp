#include "Hero.h"

void Hero::createBody()
{
	float radius = 16.0f;	
	CCSize size = CCDirector::sharedDirector()->getWinSize();
	int screenH = size.height;

	CCPoint startPosition = ccp(0, screenH / 2 + radius);

	b2BodyDef bd;
	bd.type = b2_dynamicBody;
	bd.linearDamping = 0.1f;
	bd.fixedRotation = true;
	bd.position.Set(startPosition.x / PTM_RATIO, startPosition.y / PTM_RATIO);
	_body = _world->CreateBody(&bd);

	b2CircleShape shape;
	shape.m_radius = radius / PTM_RATIO;

	b2FixtureDef fd;
	fd.shape = &shape;
	fd.density = 1.0f;
	fd.restitution = 0.0f;
	fd.friction = 0.2;

	_body->CreateFixture(&fd);
}

void Hero::initWithWorld(b2World *world)
{
	this->initWithSpriteFrameName("seal1.png");
	_world = world;
	_nextVel = 0;
	createBody();

	_normalAnim = CCAnimation::create();
	_normalAnim->addSpriteFrame(CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName("seal1.png"));
	_normalAnim->addSpriteFrame(CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName("seal2.png"));
	_normalAnim->setDelayPerUnit(0.1);
}

void Hero::update()
{
	this->setPosition(ccp(_body->GetPosition().x*PTM_RATIO, _body->GetPosition().y*PTM_RATIO));
	b2Vec2 vel = _body->GetLinearVelocity();
	b2Vec2 weightedVel = vel;

	for (int i = 0; i < NUM_PREV_VELS; ++i) {
		weightedVel += _prevVels[i];
	}
	weightedVel = b2Vec2(weightedVel.x / NUM_PREV_VELS, weightedVel.y / NUM_PREV_VELS);
	_prevVels[_nextVel++] = vel;
	if (_nextVel >= NUM_PREV_VELS) _nextVel = 0;

	float angle = ccpToAngle(ccp(weightedVel.x, weightedVel.y));
	if (_awake) {
		this->setRotation(-1 * CC_RADIANS_TO_DEGREES(angle));
	}
}

bool Hero::getAwake()
{
	return _awake;
}

void Hero::wake()
{
	_awake = true;
	_body->SetActive(true);
	_body->ApplyLinearImpulse(b2Vec2(1, 2), _body->GetPosition());
}

void Hero::dive()
{
	_body->ApplyForce(b2Vec2(5, -50), _body->GetPosition());
}

void Hero::limitVelocity()
{
	if (!_awake) return;

	const float minVelocityX = 5;
	const float minVelocityY = -40;
	b2Vec2 vel = _body->GetLinearVelocity();
	if (vel.x < minVelocityX) {
		vel.x = minVelocityX;
	}
	if (vel.y < minVelocityY) {
		vel.y = minVelocityY;
	}
	_body->SetLinearVelocity(vel);
}

void Hero::runNormalAnimation()
{
	if (_normalAnimate || !_awake) return;	
	_normalAnimate = CCAnimate::create(_normalAnim);
	this->runAction(_normalAnimate);
}

void Hero::runForceAnimation()
{
	_normalAnimate->stop();
	_normalAnimate = NULL;
	this->setDisplayFrame(CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName("seal_downhill.png"));
}

void Hero::nodive()
{
	runNormalAnimation();
}