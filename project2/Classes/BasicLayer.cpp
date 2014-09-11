#include "BasicLayer.h"
#include "SimpleAudioEngine.h"


//  这个类 是一个辅助类， 里面申请了一些 共有变量， 那个类都能调用

int Game_Time;
int Value; 


// 音效  音乐
#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define ONE        "Sound/1.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define ONE        "Sound/1.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define TWO        "Sound/2.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define TWO        "Sound/2.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define THREE        "Sound/3.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define THREE        "Sound/3.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define FOUR        "Sound/4.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define FOUR        "Sound/4.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define FIVE        "Sound/5.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define FIVE        "Sound/5.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define SIX        "Sound/6.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define SIX        "Sound/6.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define SEVEN        "Sound/7.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define SEVEN        "Sound/7.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define EIGHT        "Sound/8.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define EIGHT        "Sound/8.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define NINE        "Sound/9.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define NINE        "Sound/9.mp3"
#endif 

#if (CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#define TEN        "Sound/10.mp3"
#elif( CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
#define TEN        "Sound/10.mp3"
#endif

////#define ONE        "Sound/1.mp3"
//#define         "Sound/2.mp3"
//#define         "Sound/3.mp3"
//#define         "Sound/4.mp3"
//#define         "Sound/5.mp3"
//#define         "Sound/6.mp3"
//#define         "Sound/7.mp3"
//#define         "Sound/8.mp3"
//#define         "Sound/9.mp3"
//#define         "Sound/10.mp3"


void BasicLayer::runNestSound( int nidx)
{
	switch(nidx)
	{
	case 1:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(ONE); // 播放1
		break;
	case 2:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(TWO); // 播放2
		break;
	case 3:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(THREE); // 播放3
		break;
	case 4:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(FOUR); // 播放4
		break;
	case 5:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(FIVE); // 播放5
		break;
	case 6:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(SIX); // 播放6
		break;
	case 7:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(SEVEN); // 播放7
		break;
	case 8:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(EIGHT); // 播放8
		break;
	case 9:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(NINE); // 播放9
		break;
	case 10:
		CocosDenshion::SimpleAudioEngine::sharedEngine()->playEffect(TEN); // 播放10
		break;
	}
}
