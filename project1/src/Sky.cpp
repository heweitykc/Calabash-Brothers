#include "Sky.h"

CCSprite* Sky::spriteWithColor(ccColor4F bgColor, float textureSize)
{
	CCRenderTexture* rt = CCRenderTexture::create(textureSize, textureSize);
	rt->beginWithClear(bgColor.r, bgColor.g, bgColor.b, bgColor.a);

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
	glEnable(GL_TEXTURE_2D);
	/*
	CCSprite *noise = CCSprite::create("tw/Noise.png");
	ccBlendFunc maskBlend = { GL_DST_COLOR, GL_ZERO };
	noise->setBlendFunc(maskBlend);
	noise->setPosition(ccp(textureSize / 2, textureSize / 2));
	noise->visit();
	*/
	rt->end();
	return CCSprite::createWithTexture(rt->getSprite()->getTexture());
}

CCSprite* Sky::stripedSpriteWithColor1(ccColor4F c1, ccColor4F c2, float textureSize, int nStripes)
{
	CCRenderTexture* rt = CCRenderTexture::create(textureSize, textureSize);
	rt->beginWithClear(c1.r, c1.g, c1.b, c1.a);

	// 3: Draw into the texture    

	// Layer 1: Stripes
	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);

	CCPoint *vertices = new CCPoint[nStripes * 6];
	int nVertices = 0;
	float x1 = -textureSize;
	float x2;
	float y1 = textureSize;
	float y2 = 0;
	float dx = textureSize / nStripes * 2;
	float stripeWidth = dx / 2;
	for (int i = 0; i<nStripes; i++) {
		x2 = x1 + textureSize;
		vertices[nVertices++] = CCPointMake(x1, y1);
		vertices[nVertices++] = CCPointMake(x1 + stripeWidth, y1);
		vertices[nVertices++] = CCPointMake(x2, y2);
		vertices[nVertices++] = vertices[nVertices - 2];
		vertices[nVertices++] = vertices[nVertices - 2];
		vertices[nVertices++] = CCPointMake(x2 + stripeWidth, y2);
		x1 += dx;
	}

	glColor4f(c2.r, c2.g, c2.b, c2.a);
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_TRIANGLES, 0, (GLsizei)nVertices);

	// layer 2: gradient
	glEnableClientState(GL_COLOR_ARRAY);

	float gradientAlpha = 0.7;
	ccColor4F colors[4];
	nVertices = 0;

	vertices[nVertices] = CCPointMake(0, 0);
	colors[nVertices++] = ccc4f(0, 0, 0, 0);
	vertices[nVertices] = CCPointMake(textureSize, 0);
	colors[nVertices++] = ccc4f(0, 0, 0, 0);
	vertices[nVertices] = CCPointMake(0, textureSize);
	colors[nVertices++] = ccc4f(0, 0, 0, gradientAlpha);
	vertices[nVertices] = CCPointMake(textureSize, textureSize);
	colors[nVertices++] = ccc4f(0, 0, 0, gradientAlpha);

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);

	// layer 3: top highlight    
	float borderWidth = textureSize / 16;
	float borderAlpha = 0.3f;
	nVertices = 0;

	vertices[nVertices] = CCPointMake(0, 0);
	colors[nVertices++] = ccc4f(0, 0, 0, borderAlpha);
	vertices[nVertices] = CCPointMake(textureSize, 0);
	colors[nVertices++] = ccc4f(0, 0, 0, borderAlpha);

	vertices[nVertices] = CCPointMake(0, borderWidth);
	colors[nVertices++] = ccc4f(0, 0, 0, 0);
	vertices[nVertices] = CCPointMake(textureSize, borderWidth);
	colors[nVertices++] = ccc4f(0, 0, 0, 0);

	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glBlendFunc(GL_DST_COLOR, GL_ONE_MINUS_SRC_ALPHA);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, (GLsizei)nVertices);

	glEnableClientState(GL_COLOR_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);

	/*
	// Layer 2: Noise    
	CCSprite *noise = CCSprite::create("tw/Noise.png");
	noise->setBlendFunc(ccBlendFunc({ GL_DST_COLOR, GL_ZERO }));
	noise->setPosition(ccp(textureSize / 2, textureSize / 2));
	noise->visit();
	*/
	// 4: Call CCRenderTexture:end
	rt->end();

	delete[] vertices;

	// 5: Create a new Sprite from the texture
	return CCSprite::createWithTexture(rt->getSprite()->getTexture());
}

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

	_background = spriteWithColor(bgColor, 512);
	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	_background->setPosition(ccp(winSize.width / 2, winSize.height / 2));	
	this->addChild(_background,0);

	ccColor4F color3 = randomBrightColor();
	ccColor4F color4 = randomBrightColor();
	CCSprite *stripes = stripedSpriteWithColor1(color3, color4, 512, 4);
	stripes->retain();
	ccTexParams tp2 = { GL_LINEAR, GL_LINEAR, GL_REPEAT, GL_CLAMP_TO_EDGE };	
	stripes->getTexture()->setTexParameters(&tp2);	
	_terrain->setstripes(stripes);
}

void Sky::setupWorld()
{
	b2Vec2 gravity = b2Vec2(0.0f, -7.0f);
	_world = new b2World(gravity);
	_world->SetAllowSleeping(true);
}

void Sky::createTestBodyAtPostition(CCPoint position)
{
	b2BodyDef testBodyDef;
	testBodyDef.type = b2_dynamicBody;
	testBodyDef.position.Set(position.x / PTM_RATIO, position.y / PTM_RATIO);
	b2Body * testBody = _world->CreateBody(&testBodyDef);

	b2CircleShape testBodyShape;
	b2FixtureDef testFixtureDef;
	testBodyShape.m_radius = 25.0 / PTM_RATIO;
	testFixtureDef.shape = &testBodyShape;
	testFixtureDef.density = 1.0;
	testFixtureDef.friction = 0.2;
	testFixtureDef.restitution = 0.5;
	testBody->CreateFixture(&testFixtureDef);
}

bool Sky::init()
{
	_tapDown = false;

	setupWorld();
	setupDebugDraw();
	_terrain = Terrain::create();
	_terrain->initWithWorld(_world);
	this->addChild(_terrain);

	genBackground();
	setTouchEnabled(true);
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

		_world->Step(UPDATE_INTERVAL,
			velocityIterations, positionIterations);
		_world->ClearForces();

	}

	_hero->update();

	float offset = _hero->getPositionX();

	CCSize winSize = CCDirector::sharedDirector()->getWinSize();
	float scale = (winSize.height * 3 / 4) / _hero->getPositionY();
	if (scale > 1) scale = 1;
	_terrain->setScale(scale);

	CCSize textureSize = _background->getTextureRect().size;
	_background->setTextureRect(CCRectMake(offset*0.7, 0, textureSize.width, textureSize.height));
	_terrain->setOffsetX(offset);
}

void Sky::ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent)
{
	genBackground();
	_tapDown = true;
}

void Sky::ccTouchesEnded(CCSet *pTouches, CCEvent *pEvent)
{
	_tapDown = false;
}

void Sky::ccTouchesCancelled(CCSet *pTouches, CCEvent *pEvent)
{
	_tapDown = true;
}

CCScene* Sky::scene()
{
	CCScene *scene = CCScene::create();
	Sky *layer = Sky::create();	
	scene->addChild(layer);
	return scene;
}

void Sky::setupDebugDraw()
{
	_debugDraw = new GLESDebugDraw(PTM_RATIO*CCDirector::sharedDirector()->getContentScaleFactor());
	_world->SetDebugDraw(_debugDraw);
	_debugDraw->SetFlags(GLESDebugDraw::e_shapeBit);
}