#include "Terrain.h"

CCSprite* Terrain::spriteWithColor(ccColor4F bgColor, float textureSize)
{
	CCRenderTexture* rt = CCRenderTexture::create(textureSize, textureSize);
	rt->beginWithClear(bgColor.r, bgColor.g, bgColor.b, bgColor.a);

	rt->end();
	return CCSprite::createWithTexture(rt->getSprite()->getTexture());
}


ccColor4F Terrain::randomBrightColor()
{
	while (true){
		float requiredBrightness = 192;
		ccColor4B randomColor =
			ccc4(CCRANDOM_0_1() * 255,CCRANDOM_0_1() * 255,CCRANDOM_0_1() * 255,255);
		if (randomColor.r > requiredBrightness ||
			randomColor.g > requiredBrightness ||
			randomColor.b > requiredBrightness) {
			return ccc4FFromccc4B(randomColor);
		}
	}
}

void Terrain::genBackground()
{
	ccColor4F bgColor = randomBrightColor();
	_background = spriteWithColor(bgColor, 512);
	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	_background->setPosition(ccp(winSize.width / 2,winSize.height / 2));
	this->addChild(_background);	
}

bool Terrain::init()
{
	genBackground();
	setTouchEnabled(true);
	return true;
}