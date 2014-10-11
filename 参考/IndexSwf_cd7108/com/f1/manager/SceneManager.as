package com.f1.manager
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.interfaces.manager.*;
    import com.f1.ui.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.utils.*;

    public class SceneManager extends Object implements ISceneManager
    {
        private var _container:DisplayObjectContainer;
        private var _currentScene:IBaseScene;
        private var progressBox:UILoadingBox;

        public function SceneManager(param1:DisplayObjectContainer)
        {
            this._container = param1;
            return;
        }// end function

        public function get container() : DisplayObjectContainer
        {
            return this._container;
        }// end function

        public function set container(param1:DisplayObjectContainer) : void
        {
            this._container = param1;
            return;
        }// end function

        public function get currentScene() : IBaseScene
        {
            return this._currentScene;
        }// end function

        public function set currentScene(param1:IBaseScene) : void
        {
            Log.log("强制设置当前场景为" + param1 + "，此时currentScene为" + this._currentScene);
            this._currentScene = param1;
            return;
        }// end function

        public function addScene() : void
        {
            return;
        }// end function

        public function getScene(param1:String) : IBaseScene
        {
            return null;
        }// end function

        public function removeScene(param1:IBaseScene, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (param1)
            {
                param1.cleanScene();
                _loc_3 = param1.getSprite();
                if (param1)
                {
                    this.removeSceneComplete(param1, param2);
                }
                if (this._currentScene == param1)
                {
                    this._currentScene = null;
                }
            }
            return;
        }// end function

        private function removeSceneComplete(param1:IBaseScene, param2:Boolean = false) : void
        {
            this._container.removeChild(param1.getSprite());
            if (param2)
            {
                param1.finalize();
            }
            return;
        }// end function

        public function enterScene(param1:IBaseScene) : void
        {
            if (param1)
            {
                if (param1 == this._currentScene)
                {
                    return;
                }
                if (this._currentScene)
                {
                    if (getQualifiedClassName(this._currentScene) != getQualifiedClassName(param1))
                    {
                        Log.log("进入场景", param1, "设置上一个场景是", this._currentScene);
                        param1.preScene = this._currentScene;
                    }
                }
                this.__loadScene(param1);
            }
            var _loc_2:* = 0;
            Log.log("print_scene_stack");
            var _loc_3:* = param1;
            while (param1)
            {
                
                Log.log(param1, _loc_3.preScene, _loc_3.nextScene);
                if (param1 && _loc_3.preScene && param1 == _loc_3.preScene.preScene)
                {
                    Log.log("Loop", _loc_3.preScene, _loc_3.preScene.preScene);
                    break;
                }
                if (_loc_2++ >= 7)
                {
                    Log.log("Error,loop,now break");
                    break;
                }
                param1 = _loc_3.preScene;
                if (param1 == _loc_3)
                {
                    Log.log("Warning,loop,now break");
                    break;
                }
            }
            return;
        }// end function

        private function showScene(param1:IBaseScene) : void
        {
            this.removeScene(this._currentScene);
            this._currentScene = param1;
            param1.initScene();
            this._container.addChildAt(param1.getSprite(), 0);
            FrameworkGlobal.stage.focus = param1.getSprite();
            return;
        }// end function

        private function __loadScene(param1:IBaseScene) : void
        {
            if (param1.UILoaded)
            {
                this.showScene(param1);
            }
            else
            {
                param1.addEvtListener(UIEvent.RES_LOAD_COMPLETE, this.__sceneUILoaded);
            }
            return;
        }// end function

        private function __sceneUILoaded(event:UIEvent) : void
        {
            if (this.progressBox)
            {
                this.progressBox.close();
                if (this.progressBox.parent)
                {
                    this.progressBox.parent.removeChild(this.progressBox);
                }
            }
            var _loc_2:* = event.currentTarget as IBaseScene;
            this.showScene(_loc_2);
            _loc_2.progressFun = null;
            _loc_2.removeEvtListener(UIEvent.RES_LOAD_COMPLETE, this.__sceneUILoaded);
            return;
        }// end function

        public function backToPreScene(param1:IBaseScene = null) : Boolean
        {
            if (param1 && !this.isInScene(param1))
            {
                Log.log("当前不是在这个场景，不执行回上一个场景。curSceneParams=" + param1 + ",_nowIn=" + this._currentScene);
                return true;
            }
            Log.log("===退回到上一个场景1");
            if (this._currentScene && this._currentScene.preScene)
            {
                this.enterScene(this._currentScene.preScene);
                return true;
            }
            Log.log("===退回场景失败");
            return false;
        }// end function

        public function isInScene(param1:IBaseScene) : Boolean
        {
            if (this._currentScene == param1)
            {
                return true;
            }
            return false;
        }// end function

        public function resize() : void
        {
            if (this.progressBox && this.progressBox.isOpen)
            {
                Layout.layoutMC(this._container, this.progressBox, Layout.CENTER);
            }
            if (this._currentScene)
            {
                this._currentScene.resize();
            }
            return;
        }// end function

    }
}
