#ifndef _TERRAIN_H_
#define _TERRAIN_H_

#include "cocos2d.h"
USING_NS_CC;

class Terrain : public CCLayer
{
public:
	CREATE_FUNC(Terrain);
	virtual bool init();
private:
	CCSprite* _background;
	ccColor4F randomBrightColor();
	CCSprite* spriteWithColor(ccColor4F c1, ccColor4F c2, float textureSize, int nStripes);
	void genBackground();
};
#endif