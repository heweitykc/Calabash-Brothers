#ifndef _MENU_H_
#define _MENU_H_

#include "cocos2d.h"
USING_NS_CC;
#include "cocos-ext.h"

USING_NS_CC_EXT;
using namespace std;

class Menu:public CCLayer
{
public:

	Menu();
	~Menu();

	virtual bool init();  
	static CCScene* scene();
	CREATE_FUNC(Menu);

public: 
	void Init();

public: 
	void ggg(float dt);
	int a ;




};
#endif