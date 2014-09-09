#ifndef _TERRAIN_H_
#define _TERRAIN_H_

#include "cocos2d.h"
#include "Box2D\Box2D.h"
#include "GLES-Render.h"

USING_NS_CC;

#define kMaxHillKeyPoints 1000
#define kHillSegmentWidth 5
#define kMaxHillVertices 4000
#define kMaxBorderVertices 800

class Terrain : public CCNode
{
public:
	CREATE_FUNC(Terrain);
	int _offsetX;
	CCPoint _hillKeyPoints[kMaxHillKeyPoints];
	CCSprite *_stripes;

	int _fromKeyPointI;
	int _toKeyPointI;

	int _nHillVertices;
	CCPoint _hillVertices[kMaxHillVertices];
	CCPoint _hillTexCoords[kMaxHillVertices];
	int _nBorderVertices;
	CCPoint _borderVertices[kMaxBorderVertices];

	b2World *_world;
	b2Body *_body;
	GLESDebugDraw * _debugDraw;

	CCSpriteBatchNode * _batchNode;

	void setstripes(CCSprite *stripes);
	CCSprite *getstripes();

	void setbatchNode(CCSpriteBatchNode *batchNode);
	CCSpriteBatchNode *getbatchNode();

	void setOffsetX(float newOffsetX);
	void initWithWorld(b2World *world);

	void resetBox2DBody();
	void generateHills();
	void resetHillVertices();
	void setupDebugDraw();	

	virtual void draw();	
};

#endif