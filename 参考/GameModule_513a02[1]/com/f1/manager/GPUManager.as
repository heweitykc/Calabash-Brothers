package com.f1.manager
{
    import com.f1.*;
    import flash.display.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;

    public class GPUManager extends Object
    {
        private var _root:Sprite;
        private var mStarling:Starling;
        private var _initCallBack:Function;
        private static var instance:GPUManager;
        public static var GPUEnable:Boolean = false;

        public function GPUManager()
        {
            return;
        }// end function

        public function get root() : Sprite
        {
            return this._root;
        }// end function

        public function set root(param1:Sprite) : void
        {
            this._root = param1;
            return;
        }// end function

        public function clear() : void
        {
            if (this._root)
            {
                BaseGPUSprite.clearChild(this._root);
            }
            return;
        }// end function

        public function initGPU(param1:Function) : void
        {
            this._initCallBack = param1;
            var _loc_2:* = FrameworkGlobal.stage;
            if (_loc_2.stageWidth > 1 && _loc_2.stageHeight > 1)
            {
                this.init();
            }
            else
            {
                _loc_2.addEventListener("resize", this.onResize);
            }
            return;
        }// end function

        private function onResize(param1) : void
        {
            var _loc_2:* = FrameworkGlobal.stage;
            if (_loc_2.stageWidth > 1 && _loc_2.stageHeight > 1)
            {
                _loc_2.removeEventListener("resize", this.onResize);
                this.init();
            }
            return;
        }// end function

        private function init() : void
        {
            Starling.multitouchEnabled = false;
            Starling.handleLostContext = true;
            this.mStarling = new Starling(Sprite, FrameworkGlobal.stage, null, null, "auto", "baseline");
            this.mStarling.simulateMultitouch = false;
            this.mStarling.start();
            this.mStarling.addEventListener(Event.ROOT_CREATED, this.onRootCreated);
            return;
        }// end function

        public function resize() : void
        {
            if (FrameworkGlobal.stageW > 1 && FrameworkGlobal.stageH > 1)
            {
                this.mStarling.viewPort.width = FrameworkGlobal.stageW;
                this.mStarling.viewPort.height = FrameworkGlobal.stageH;
                this.mStarling.stage.stageWidth = FrameworkGlobal.stageW;
                this.mStarling.stage.stageHeight = FrameworkGlobal.stageH;
            }
            return;
        }// end function

        private function onRootCreated(event:Event, param2:Sprite) : void
        {
            if (this.mStarling.context.driverInfo.toLowerCase().indexOf("software") != -1)
            {
                GPUEnable = false;
                this.mStarling.nativeStage.frameRate = FrameworkGlobal.frameRate;
            }
            else
            {
                GPUEnable = true;
            }
            this._root = param2;
            if (this._initCallBack != null)
            {
                this._initCallBack.call();
                this._initCallBack = null;
            }
            return;
        }// end function

        public function add3DChild(param1:DisplayObject, param2:int = -1) : void
        {
            if (this.root)
            {
                if (param2 == -1)
                {
                    this.root.addChild(param1);
                }
                else
                {
                    this.root.addChildAt(param1, param2);
                }
            }
            return;
        }// end function

        public function remove3DChild(param1:DisplayObject) : void
        {
            if (this.root)
            {
                this.root.removeChild(param1);
            }
            return;
        }// end function

        public function enterframe() : void
        {
            if (this.mStarling)
            {
                this.mStarling.enterframe();
            }
            return;
        }// end function

        public static function getInstance() : GPUManager
        {
            if (instance == null)
            {
                instance = new GPUManager;
            }
            return instance;
        }// end function

    }
}
