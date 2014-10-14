#pragma once
#include "cocos2d.h"

class SimpleDPad;

class SimpleDPadDelegate
{
public:
	virtual void didChangeDirectionTo(SimpleDPad *simpleDPad, cocos2d::CCPoint direction) = 0;
	virtual void isHoldingDirection(SimpleDPad *simpleDPad, cocos2d::CCPoint direction) = 0;
	virtual void simpleDPadTouchEnded(SimpleDPad *simpleDPad) = 0;
};

class SimpleDPad : public cocos2d::Layer
{
public:
	SimpleDPad(void);
	~SimpleDPad(void);

	static SimpleDPad* dPadWithFile(cocos2d::CCString *fileName, float radius);
	bool initWithFile(cocos2d::CCString *filename, float radius);

	void onEnterTransitionDidFinish();
	void onExit();
	void update(float dt);

	void onTouchesBegin(const std::vector<cocos2d::Touch*>& touches, cocos2d::Event* event);
	void onTouchesMove(const std::vector<cocos2d::Touch*>& touches, cocos2d::Event* event);
	void onTouchesEnd(const std::vector<cocos2d::Touch*>& touches, cocos2d::Event* event);

	void updateDirectionForTouchLocation(cocos2d::CCPoint location);

	CC_SYNTHESIZE(SimpleDPadDelegate*, _delegate, Delegate);
	CC_SYNTHESIZE(bool, _isHeld, IsHeld);

protected:
	float _radius;
	cocos2d::CCPoint _direction;
};
