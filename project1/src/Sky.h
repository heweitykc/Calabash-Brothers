#ifndef _SKY_H_
#define _SKY_H_

#include "cocos2d.h"
USING_NS_CC;

class Sky : public CCLayer
{
public:
	CREATE_FUNC(Sky);
	virtual bool init();
private:
	CCSprite* _background;
	ccColor4F randomBrightColor();
	CCSprite* spriteWithColor(ccColor4F c1, ccColor4F c2, float textureSize, int nStripes);
	void genBackground();
};
#endif