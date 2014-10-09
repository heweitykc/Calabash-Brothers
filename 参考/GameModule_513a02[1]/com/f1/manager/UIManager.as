package com.f1.manager
{
    import com.f1.*;
    import com.f1.interfaces.manager.*;
    import com.f1.ui.*;
    import com.f1.ui.events.*;
    import com.greensock.plugins.*;
    import flash.display.*;
    import flash.events.*;

    public class UIManager extends Object implements IUIManager
    {
        private var _UIContainer:BaseSprite;
        private var SHOW_HIDE_TIME:Number = 0.3;
        private var SCALE_NUM:Number = 1.5;
        private var UIList:Array;
        private var hidedGroup:int = -1;

        public function UIManager(param1:BaseSprite)
        {
            this.UIList = [];
            TweenPlugin.activate([AutoAlphaPlugin]);
            this._UIContainer = param1;
            this.resize();
            return;
        }// end function

        public function get UIContainer() : BaseSprite
        {
            return this._UIContainer;
        }// end function

        protected function updateWH() : void
        {
            this._UIContainer.setWH(FrameworkGlobal.stageW, FrameworkGlobal.stageH);
            return;
        }// end function

        public function resize() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.updateWH();
            var _loc_1:* = this._UIContainer.scaleX;
            if (_loc_1 != 1)
            {
                this._UIContainer.scaleX = 1;
                this._UIContainer.scaleY = 1;
            }
            var _loc_2:* = this._UIContainer.numChildren;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_3 = BaseSprite(this._UIContainer.getChildAt(_loc_5));
                if (!_loc_3)
                {
                }
                else
                {
                    _loc_4 = _loc_3.getAttr("layoutInfo");
                    if (_loc_4)
                    {
                        this._UIContainer.layoutMC(_loc_3, _loc_4.type, _loc_4.offsetX, _loc_4.offsetY);
                    }
                    _loc_3.resize();
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_1 != 1)
            {
                this._UIContainer.scaleX = _loc_1;
            }
            return;
        }// end function

        public function layoutUI(param1:BaseSprite) : void
        {
            var _loc_2:* = param1.getAttr("layoutInfo");
            if (_loc_2)
            {
                this._UIContainer.layoutMC(param1, _loc_2.type, _loc_2.offsetX, _loc_2.offsetY);
            }
            return;
        }// end function

        public function removeUI(param1:BaseSprite) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param1 && param1.parent == this._UIContainer)
            {
                this._UIContainer.removeChild(param1);
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                _loc_2 = this.UIList.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_3 = this.UIList[_loc_4];
                    if (_loc_3 == param1)
                    {
                        this.UIList.splice(_loc_4, 1);
                        break;
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            return;
        }// end function

        public function addUI(param1:BaseSprite, param2:LayoutInfo = null, param3:uint = 0, param4:Boolean = false) : void
        {
            if (!param1)
            {
                return;
            }
            if (this.UIList.indexOf(param1) == -1)
            {
                this.UIList.push(param1);
            }
            param1.setAttr("UIGroup", param3);
            if (param2)
            {
                param1.setAttr("layoutInfo", param2);
                this._UIContainer.layoutMC(param1, param2.type, param2.offsetX, param2.offsetY);
                if (param1 is Component)
                {
                    if (!Component(param1).UILoaded)
                    {
                        param1.addEvtListener(UIEvent.RESIZE, this.__UIResize);
                    }
                }
            }
            if (param4)
            {
                this._UIContainer.addChildAt(param1, 0);
            }
            else
            {
                this._UIContainer.addChild(param1);
            }
            if (this.hidedGroup == param3)
            {
                this.doHideUI(param1);
            }
            return;
        }// end function

        private function __UIResize(event:Event) : void
        {
            var _loc_2:* = BaseSprite(event.currentTarget);
            var _loc_3:* = _loc_2.getAttr("layoutInfo");
            if (_loc_3)
            {
                this._UIContainer.layoutMC(_loc_2, _loc_3.type, _loc_3.offsetX, _loc_3.offsetY);
            }
            return;
        }// end function

        public function getUIByName(param1:String) : DisplayObject
        {
            return this._UIContainer.getChildByName(param1);
        }// end function

        public function hideAllUI() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.UIList)
            {
                
                if (_loc_1)
                {
                    this.doHideUI(_loc_1);
                }
            }
            return;
        }// end function

        private function hideComplete() : void
        {
            return;
        }// end function

        public function showAllUI() : void
        {
            var _loc_1:* = null;
            this.hidedGroup = -1;
            for each (_loc_1 in this.UIList)
            {
                
                if (_loc_1)
                {
                    this.doShowUI(_loc_1);
                }
            }
            return;
        }// end function

        private function doHideUI(param1:BaseSprite) : void
        {
            if (param1.visible != false)
            {
                param1.visible = false;
            }
            return;
        }// end function

        private function doShowUI(param1:BaseSprite) : void
        {
            if (param1.visible != true)
            {
                param1.visible = true;
            }
            return;
        }// end function

        public function hideGroup(param1:uint) : void
        {
            var _loc_2:* = null;
            this.hidedGroup = param1;
            for each (_loc_2 in this.UIList)
            {
                
                if (_loc_2 && _loc_2.getAttr("UIGroup") == param1)
                {
                    this.doHideUI(_loc_2);
                }
            }
            return;
        }// end function

        public function showGroup(param1:uint) : void
        {
            var _loc_2:* = null;
            this.hidedGroup = -1;
            for each (_loc_2 in this.UIList)
            {
                
                if (_loc_2 && _loc_2.getAttr("UIGroup") == param1)
                {
                    this.doShowUI(_loc_2);
                }
            }
            return;
        }// end function

        private function showComplete() : void
        {
            this._UIContainer.mouseChildren = true;
            this._UIContainer.mouseEnabled = true;
            this.resize();
            return;
        }// end function

    }
}
