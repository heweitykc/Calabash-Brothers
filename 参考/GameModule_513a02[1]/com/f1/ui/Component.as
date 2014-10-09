package com.f1.ui
{
    import com.f1.*;
    import com.f1.interfaces.ui.*;
    import com.f1.manager.resource.*;
    import com.f1.manager.sound.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class Component extends BaseSprite implements IComponent
    {
        protected var display:Object;
        protected var bgMc:Object;
        private var _mute:Boolean;
        private var _UILoaded:Boolean = true;
        private var _UIName:String = "";
        private var loader:VResLoader;
        protected var _progressFun:Function;

        public function Component(param1 = null, param2:String = null)
        {
            this.initComponentUI(param1, param2);
            return;
        }// end function

        public function get UIName() : String
        {
            return this._UIName;
        }// end function

        public function set UIName(param1:String) : void
        {
            this._UIName = param1;
            return;
        }// end function

        public function get UILoaded() : Boolean
        {
            return this._UILoaded;
        }// end function

        public function set UILoaded(param1:Boolean) : void
        {
            this._UILoaded = param1;
            return;
        }// end function

        override public function move(param1:Number, param2:Number) : void
        {
            param1 = int(param1);
            param2 = int(param2);
            super.move(param1, param2);
            return;
        }// end function

        protected function initComponentUI(param1, param2 = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (this.bgMc)
            {
                removeChild(this.bgMc);
                this.bgMc = null;
            }
            if (this.display)
            {
                removeChild(this.display);
                this.display = null;
            }
            if (param2)
            {
                if (param2 is String)
                {
                    this.bgMc = ToolKit.getNew(param2) as Sprite;
                }
                else if (param2 is DisplayObject)
                {
                    this.bgMc = param2;
                }
                this._UILoaded = true;
                addChild(this.bgMc);
            }
            if (param1)
            {
                if (param1 is String)
                {
                    this.display = ToolKit.getNew(param1);
                    if (this.display)
                    {
                        addChildAt(this.display, 0);
                    }
                    else
                    {
                        Log.error("Component initUI " + param1 + " == null");
                    }
                }
                else if (param1 is DisplayObject)
                {
                    this.display = param1;
                    _loc_3 = this.display.parent;
                    if (_loc_3 != null)
                    {
                        _loc_4 = _loc_3.getChildIndex(this.display);
                        _loc_3.removeChild(this.display);
                        this.x = this.display.x;
                        this.y = this.display.y;
                        _loc_3.addChildAt(this, _loc_4);
                    }
                    this.display.x = 0;
                    this.display.y = 0;
                    addChildAt(this.display, 0);
                }
                this.display.mouseEnabled = false;
                this._UILoaded = true;
            }
            if (this.display || this.bgMc)
            {
                if (__w == 0 && __h == 0)
                {
                    if (this.width > 0 && this.height > 0)
                    {
                        this.setWH(this.width, this.height);
                    }
                }
            }
            this.updateBgSize();
            return;
        }// end function

        public function getDisplayChildByName(param1:String)
        {
            if (this.display && param1)
            {
                return this.display.getChildByName(param1);
            }
            return null;
        }// end function

        public function getIndexByName(param1:String) : int
        {
            var _loc_2:* = this.getDisplayChildByName(param1);
            if (_loc_2)
            {
                return this.display.getChildIndex(_loc_2);
            }
            return -1;
        }// end function

        public function removeDisplayChild(param1:DisplayObject) : DisplayObject
        {
            return this.display.removeChild(param1);
        }// end function

        public function removeDisplayChildByName(param1:String) : void
        {
            var _loc_2:* = this.getDisplayChildByName(param1);
            if (_loc_2)
            {
                this.display.removeChild(_loc_2);
            }
            return;
        }// end function

        override public function setWH(param1:uint, param2:uint) : void
        {
            super.setWH(param1, param2);
            dispatchEvent(new UIEvent(UIEvent.RESIZE));
            return;
        }// end function

        public function updateBgSize() : void
        {
            if (this.bgMc != null)
            {
                this.bgMc.width = _w;
                this.bgMc.height = _h;
            }
            return;
        }// end function

        public function setBgWidth(param1:uint) : void
        {
            if (this.bgMc != null)
            {
                this.bgMc.width = param1;
            }
            return;
        }// end function

        public function setDisplay(param1) : void
        {
            if (this.display)
            {
                removeChild(this.display);
            }
            this.display = param1;
            if (this.display)
            {
                addChildAt(this.display, 0);
            }
            return;
        }// end function

        public function getDisplay()
        {
            return this.display;
        }// end function

        public function replaceChild(param1:String, param2:DisplayObject) : void
        {
            var _loc_3:* = this.getDisplayChildByName(param1);
            var _loc_4:* = new Rectangle(_loc_3.x, _loc_3.y, _loc_3.width, _loc_3.height);
            var _loc_5:* = this.display.getChildIndex(_loc_3);
            this.display.removeChild(_loc_3);
            this.display.addChildAt(param2, _loc_5);
            param2.x = _loc_4.x;
            param2.y = _loc_4.y;
            param2.width = _loc_4.width;
            param2.height = _loc_4.height;
            return;
        }// end function

        public function get mute() : Boolean
        {
            return this._mute;
        }// end function

        public function set mute(param1:Boolean) : void
        {
            this._mute = param1;
            return;
        }// end function

        protected function playSound(param1:String) : void
        {
            if (!this._mute)
            {
                SoundManager.play(param1, false);
            }
            return;
        }// end function

        protected function loadDisplay(param1, param2:Boolean = false, param3:Boolean = true) : void
        {
            var _loc_4:* = null;
            this.UILoaded = false;
            if (param1 is Array)
            {
                VResManager.loadGroup(param1, null, null, null, param3 ? (this.loadingProgress) : (null), this.loadDisplayComplete, null, false, false, true, 0, FrameworkGlobal.LOAD_PRELOAD_UI);
            }
            else
            {
                if (!this.loader)
                {
                    this.loader = new VResLoader(null);
                    this.loader.addEventListener(VResEvent.NOTIFY_LOAD_ONE_COMPLETE, this.onLoaderComplete);
                }
                if (this.loader.loadObj == null)
                {
                    _loc_4 = new VResLoadObj();
                    this.loader.loadObj = _loc_4;
                }
                else
                {
                    _loc_4 = this.loader.loadObj;
                }
                _loc_4.url = param1;
                _loc_4.ignoreMD5 = param2;
                _loc_4.completeFuns.push(this.loadDisplayComplete);
                _loc_4.callBackParams.push(null);
                _loc_4.errFuns.push(null);
                _loc_4.progressFuns.push(param3 ? (this.loadingProgress) : (null));
                _loc_4.preLoad = FrameworkGlobal.LOAD_PRELOAD_UI;
                this.loader.startLoad();
                trace("startLoaderUI:::" + param1);
            }
            this.onLoadingStart();
            return;
        }// end function

        protected function onLoaderComplete(event:Event) : void
        {
            this.loadDisplayComplete(this.loader.data);
            return;
        }// end function

        protected function onLoadingStart() : void
        {
            return;
        }// end function

        protected function loadDisplayComplete(param1 = null) : void
        {
            this.UILoaded = true;
            this.displayReady();
            return;
        }// end function

        public function set progressFun(param1:Function) : void
        {
            this._progressFun = param1;
            return;
        }// end function

        protected function loadingProgress(event:ProgressEvent, param2:VResLoadObj) : void
        {
            if (this._progressFun != null)
            {
                this._progressFun.call(null, event, param2);
            }
            return;
        }// end function

        protected function displayReady() : void
        {
            dispatchEvent(new UIEvent(UIEvent.RES_LOAD_COMPLETE));
            return;
        }// end function

        public function lock() : void
        {
            mouseChildren = false;
            return;
        }// end function

        public function unlock() : void
        {
            mouseChildren = true;
            return;
        }// end function

        override public function finalize() : void
        {
            this._progressFun = null;
            if (this.loader)
            {
                this.loader.finalize();
                this.loader = null;
            }
            super.finalize();
            return;
        }// end function

    }
}
