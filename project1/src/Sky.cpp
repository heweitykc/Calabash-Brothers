#include "Sky.h"

CCSprite* Sky::spriteWithColor(ccColor4F c1, ccColor4F c2, float textureSize, int nStripes)
{
	CCRenderTexture* rt = CCRenderTexture::create(textureSize, textureSize);
	rt->beginWithClear(c1.r, c1.g, c1.b, c1.a);

	/*
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);

	float gradientAlpha = 0.7;
	CCPoint vertices[4];
	ccColor4F colors[4];
	int nVertices = 0;

	vertices[nVertices] = CCPointMake(0, 0);
	colors[nVertices++] = ccc4f( 0, 0, 0, 0);
	vertices[nVertices] = CCPointMake(textureSize, 0);
	colors[nVertices++] = ccc4f(0, 0, 0, 0);
	vertices[nVertices] = CCPointMake(0, textureSize);
	colors[nVertices++] = ccc4f(0, 0, 0, gradientAlpha);
	vertices[nVertices] = CCPointMake(textureSize, textureSize);
	colors[nVertices++] = ccc4f(0, 0, 0, gradientAlpha);

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);

	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);*/

	CCSprite *noise = CCSprite::create("tw/Noise.png");
	ccBlendFunc maskBlend = { GL_DST_COLOR, GL_ZERO };
	noise->setBlendFunc(maskBlend);
	noise->setPosition(ccp(textureSize / 2, textureSize / 2));
	noise->visit();

	rt->end();
	return CCSprite::createWithTexture(rt->getSprite()->getTexture());
}


ccColor4F Sky::randomBrightColor()
{
	while (true){
		float requiredBrightness = 192;
		ccColor4B randomColor =
			ccc4(CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, CCRANDOM_0_1() * 255, 255);
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
	ccColor4F color2 = randomBrightColor();
	int nStripes = ((CCRANDOM_0_1() * 4) + 1) * 2;

	_background = spriteWithColor(bgColor, color2, 512, nStripes);
	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	_background->setPosition(ccp(winSize.width / 2, winSize.height / 2));
	this->addChild(_background);
	//CCSprite *noise = CCSprite::create("tw/Noise.png");
	//this->addChild(noise);
}

bool Sky::init()
{
	genBackground();
	setTouchEnabled(true);
	return true;
}