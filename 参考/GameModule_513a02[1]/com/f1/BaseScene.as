package com.f1
{
    import com.f1.interfaces.*;
    import com.f1.ui.*;
    import flash.display.*;

    public class BaseScene extends Component implements IBaseScene
    {
        protected var layers:Array;
        protected var _preScene:IBaseScene;
        protected var _nextScene:IBaseScene;

        public function BaseScene()
        {
            mouseEnabled = false;
            this.layers = [];
            return;
        }// end function

        public function get preScene() : IBaseScene
        {
            return this._preScene;
        }// end function

        public function set preScene(param1:IBaseScene) : void
        {
            if (this._nextScene != null && this._nextScene == param1)
            {
                return;
            }
            this._preScene = param1;
            if (this._preScene)
            {
                this._preScene.nextScene = this;
            }
            return;
        }// end function

        public function get nextScene() : IBaseScene
        {
            return this._nextScene;
        }// end function

        public function set nextScene(param1:IBaseScene) : void
        {
            this._nextScene = param1;
            return;
        }// end function

        public function createLayer(param1:String = null) : BaseSprite
        {
            var _loc_2:* = new BaseSprite();
            _loc_2.setWH(_w, _h);
            _loc_2.mouseEnabled = false;
            if (param1)
            {
                _loc_2.name = param1;
            }
            addChild(_loc_2);
            return _loc_2;
        }// end function

        public function getLayerByName(param1:String) : BaseSprite
        {
            var _loc_2:* = getChildByName(param1) as BaseSprite;
            return _loc_2;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this.layers)
            {
                
                if (_loc_3)
                {
                    if (_loc_3 is BaseSprite)
                    {
                        BaseSprite(_loc_3).setWH(param1, param2);
                    }
                }
            }
            super.setWH(param1, param2);
            return;
        }// end function

        protected function updateWH() : void
        {
            if (stage)
            {
                this.setWH(stage.stageWidth, stage.stageHeight);
            }
            else
            {
                this.setWH(FrameworkGlobal.stageW, FrameworkGlobal.stageH);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            if (this._preScene && this._preScene.nextScene == this)
            {
                this._preScene.nextScene = this.nextScene;
            }
            if (this._nextScene && this._nextScene.preScene == this)
            {
                this._nextScene.preScene = this.preScene;
            }
            this.layers = null;
            this._preScene = null;
            this._nextScene = null;
            super.finalize();
            return;
        }// end function

        override public function resize() : void
        {
            this.updateWH();
            return;
        }// end function

        public function initScene() : void
        {
            return;
        }// end function

        public function cleanScene() : void
        {
            return;
        }// end function

    }
}
