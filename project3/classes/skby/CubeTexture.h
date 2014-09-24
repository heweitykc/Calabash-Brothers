#ifndef __CUBE_TEXTURE_H__
#define __CUBE_TEXTURE_H__

#include "cocos2d.h"

class CubeTexture : public cocos2d::Layer
{
public:
	static cocos2d::Scene* createScene();

	virtual bool init();
	virtual void draw(cocos2d::Renderer *renderer, const cocos2d::Mat4 &transform, uint32_t transformUpdated) override;
	void onDraw();
	CREATE_FUNC(CubeTexture);

private:
	cocos2d::Mat4 _modelViewMV;
	cocos2d::CustomCommand _customCommand;

	cocos2d::GLProgram *mShaderProgram;
	GLint _colorLocation;
	GLint _positionLocation;
	GLint _textureLocation;

	GLuint _textureUniform;

	GLuint _textureID;
	GLuint _textureID2;

	GLuint _vertexBuffer;
	GLuint _indexBuffer;

	GLuint _vertexBuffer2;
	GLuint _indexBuffer2;
};

#endif