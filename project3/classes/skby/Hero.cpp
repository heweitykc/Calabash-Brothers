#include "Hero.h"
#include "SimpleAudioEngine.h"
using namespace cocos2d;

Hero::Hero(void)
{
}

Hero::~Hero(void)
{
}

bool Hero::init()
{
	bool bRet = false;
	do 
	{
		CC_BREAK_IF(!ActionSprite::initWithSpriteFrameName("hero_idle_00.png"));		

		int i;
		//idle animation
		Vector<SpriteFrame*> idleFrames;
		for (i = 0; i < 6; i++)
		{
			CCSpriteFrame *frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(CCString::createWithFormat("hero_idle_%02d.png", i)->getCString());
			idleFrames.pushBack(frame);
		}
		CCAnimation *idleAnimation = CCAnimation::createWithSpriteFrames(idleFrames, float(1.0 / 12.0));
		this->setIdleAction(CCRepeatForever::create(CCAnimate::create(idleAnimation)));

		//attack animation
		Vector<SpriteFrame*> attackFrames;
		for (i = 0; i < 3; i++)
		{
			CCSpriteFrame *frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(CCString::createWithFormat("hero_attack_00_%02d.png", i)->getCString());
			attackFrames.pushBack(frame);
		}
		CCAnimation *attackAnimation = CCAnimation::createWithSpriteFrames(attackFrames, float(1.0 / 24.0));
		this->setAttackAction(CCSequence::create(CCAnimate::create(attackAnimation), CCCallFunc::create(this, callfunc_selector(Hero::idle)), NULL));

		//walk animation
		Vector<SpriteFrame*> walkFrames;
		for (i = 0; i < 8; i++)
		{
			CCSpriteFrame *frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(CCString::createWithFormat("hero_walk_%02d.png", i)->getCString());
			walkFrames.pushBack(frame);
		}
		CCAnimation *walkAnimation = CCAnimation::createWithSpriteFrames(walkFrames, float(1.0 / 12.0));
		this->setWalkAction(CCRepeatForever::create(CCAnimate::create(walkAnimation)));

		//hurt animation
		Vector<SpriteFrame*> hurtFrames;
		for (i = 0; i < 3; i++)
		{
			CCSpriteFrame *frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(CCString::createWithFormat("hero_hurt_%02d.png", i)->getCString());
			hurtFrames.pushBack(frame);
		}
		CCAnimation *hurtAnimation = CCAnimation::createWithSpriteFrames(hurtFrames, float(1.0 / 12.0));
		this->setHurtAction(CCSequence::create(CCAnimate::create(hurtAnimation), CCCallFunc::create(this, callfunc_selector(Hero::idle)), NULL));

		//knocked out animation
		Vector<SpriteFrame*> knockedOutFrames;
		for (i = 0; i < 5; i++)
		{
			CCSpriteFrame *frame = CCSpriteFrameCache::sharedSpriteFrameCache()->spriteFrameByName(CCString::createWithFormat("hero_knockout_%02d.png", i)->getCString());
			knockedOutFrames.pushBack(frame);
		}
		CCAnimation *knockedOutAnimation = CCAnimation::createWithSpriteFrames(knockedOutFrames, float(1.0 / 12.0));
		this->setKnockedOutAction(CCSequence::create(CCAnimate::create(knockedOutAnimation), CCBlink::create(2.0, 10.0), NULL));

		this->setCenterToBottom(39.0);
		this->setCenterToSides(29.0);
		this->setHitPoints(100.0);
		this->setDamage(20.0);
		this->setWalkSpeed(80.0);

		this->setHitbox(this->createBoundingBoxWithOrigin(ccp(-this->getCenterToSides(), -this->getCenterToBottom()),
			CCSizeMake(this->getCenterToSides() * 2, this->getCenterToBottom() * 2)));
		this->setAttackBox(this->createBoundingBoxWithOrigin(ccp(this->getCenterToSides(), -10), CCSizeMake(20, 20)));

		bRet = true;
	} while (0);

	return bRet;
}

void Hero::knockout()
{
	ActionSprite::knockout();
	CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect("pd_herodeath.wav");
}
