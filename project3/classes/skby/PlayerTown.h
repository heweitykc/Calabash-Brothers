#ifndef __PLAYER_SCENE_H__
#define __PLAYER_SCENE_H__

#include "cocos2d.h"
#include "cocostudio/CocoStudio.h"
#include "CubeTexture.h"

class PlayerTown : public cocos2d::Layer
{
public:
	// there's no 'id' in cpp, so we recommend returning the class instance pointer
	static cocos2d::Scene* createScene();

	// Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
	virtual bool init();

	// a selector callback
	void menuCloseCallback(cocos2d::Ref* pSender);

	// implement the "static create()" method manually
	CREATE_FUNC(PlayerTown);

	cocos2d::LabelTTF *_msglb;
	cocostudio::Armature *_hero;
	cocostudio::Armature *_horse;

	CubeTexture *_cube;
	int _cc;
	int a;
	void move(float dt);
};

#endif