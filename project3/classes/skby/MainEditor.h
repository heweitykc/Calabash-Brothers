#ifndef __MAIN_EDITOR_H__
#define __MAIN_EDITOR_H__

#include "cocos2d.h"
#include "ui/CocosGUI.h"
#include "cocostudio/CocoStudio.h"

class MainEditor : public cocos2d::Layer
{
public:
	static cocos2d::Scene* createScene();	
	virtual bool init();	

	CREATE_FUNC(MainEditor);

	cocos2d::Layer *_touchGroup;
	cocos2d::ui::Layout *_layout0;
	cocos2d::ui::Button *_roleBtn;
	cocos2d::ui::Button *_weaponBtn;
	cocos2d::ui::Button *_playBtn;
	cocos2d::ui::Button *_closeBtn;
	cocos2d::ui::TextField *_idtxt;
	cocos2d::ui::TextField *_weaknumtxt;

	cocostudio::Armature *_hero;
	cocostudio::Armature *_weapon;

	void touchEvent(Ref *pSender, cocos2d::ui::Widget::TouchEventType type);
};


#endif