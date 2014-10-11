package com.f1
{
    import com.f1.interfaces.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class BaseSprite extends Sprite implements IBaseSprite
    {
        protected var __w:uint;
        protected var __h:uint;
        private var attrs:Dictionary;
        private var _scale:Number;
        public var isFinalized:Boolean;

        public function BaseSprite()
        {
            return;
        }// end function

        public function get _h() : uint
        {
            if (this.__h > 0)
            {
                return this.__h;
            }
            return height;
        }// end function

        public function set _h(param1:uint) : void
        {
            this.__h = param1;
            return;
        }// end function

        public function get _w() : uint
        {
            if (this.__w > 0)
            {
                return this.__w;
            }
            return width;
        }// end function

        public function set _w(param1:uint) : void
        {
            this.__w = param1;
            return;
        }// end function

        public function setScale(param1:Number) : void
        {
            this._scale = param1;
            if (scaleX != param1)
            {
                scaleX = param1;
            }
            if (scaleY != param1)
            {
                scaleY = param1;
            }
            return;
        }// end function

        public function getScale() : Number
        {
            return this._scale;
        }// end function

        public function setWH(param1:uint, param2:uint) : void
        {
            this.__w = param1;
            this.__h = param2;
            return;
        }// end function

        public function setAttr(param1:String, param2) : void
        {
            if (this.attrs == null)
            {
                this.attrs = new Dictionary(true);
            }
            this.attrs[param1] = param2;
            return;
        }// end function

        public function getAttr(param1:String)
        {
            if (this.attrs != null)
            {
                return this.attrs[param1];
            }
            return null;
        }// end function

        public function removeAttr(param1) : void
        {
            this.attrs[param1] = null;
            delete this.attrs[param1];
            return;
        }// end function

        public function removeAllAttr() : void
        {
            this.attrs = null;
            return;
        }// end function

        public function setAlpha(param1:Number) : void
        {
            if (alpha != param1)
            {
                alpha = param1;
            }
            return;
        }// end function

        public function setWidth(param1:Number) : void
        {
            if (width != param1)
            {
                width = param1;
            }
            return;
        }// end function

        public function setHeight(param1:Number) : void
        {
            if (height != param1)
            {
                height = param1;
            }
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this.setWidth(param1);
            this.setHeight(param2);
            return;
        }// end function

        public function offset(param1:Number, param2:Number) : void
        {
            this.move(x + param1, y + param2);
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            if (!isNaN(param1))
            {
                if (x != param1)
                {
                    x = param1;
                }
            }
            if (!isNaN(param2))
            {
                if (y != param2)
                {
                    y = param2;
                }
            }
            return;
        }// end function

        public function locate2(param1:DisplayObject) : void
        {
            this.move(param1.x, param1.y);
            return;
        }// end function

        public function set _x(param1:Number) : void
        {
            if (x != param1)
            {
                x = param1;
            }
            return;
        }// end function

        public function set _y(param1:Number) : void
        {
            if (y != param1)
            {
                y = param1;
            }
            return;
        }// end function

        public function get _x() : Number
        {
            return x;
        }// end function

        public function get _y() : Number
        {
            return y;
        }// end function

        public function getSprite() : Sprite
        {
            return this;
        }// end function

        public function removeSprite(param1:DisplayObject) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            if (visible != param1)
            {
                visible = param1;
            }
            return;
        }// end function

        public function removeChildByName(param1:String) : void
        {
            var _loc_2:* = getChildByName(param1);
            if (_loc_2)
            {
                removeChild(_loc_2);
            }
            return;
        }// end function

        public function getParent() : DisplayObjectContainer
        {
            return this.parent;
        }// end function

        public function finalize() : void
        {
            ToolKit.clearMcChild(this, true);
            this.isFinalized = true;
            return;
        }// end function

        public function removeFromParent(param1:Boolean = false) : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            if (param1)
            {
                this.finalize();
            }
            return;
        }// end function

        public function setFilters(param1:Array) : void
        {
            this.filters = param1;
            return;
        }// end function

        public function resize() : void
        {
            return;
        }// end function

        public function layoutMC(param1:DisplayObject, param2:uint = 1, param3:int = 0, param4:int = 0, param5:Number = 0, param6:Number = NaN, param7:Number = NaN) : void
        {
            if (param1)
            {
                Layout.layoutMC(this, param1, param2, param3, param4, param5, param6, param7);
            }
            return;
        }// end function

        public function layoutGroup(param1:Array, param2:uint = 1, param3:int = 0, param4:int = 0, param5:Number = 0, param6:Number = NaN, param7:Number = NaN) : void
        {
            if (param1)
            {
                Layout.layoutGroup(this, param1, param2, param3, param4, param5, param6, param7);
            }
            return;
        }// end function

        public function addEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            if (param1)
            {
                addEventListener(param1, param2, param3, 0, param4);
            }
            return;
        }// end function

        public function addEvtListeners(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in param1)
            {
                
                this.addEvtListener(_loc_5, param2, param3, param4);
            }
            return;
        }// end function

        public function removeEvtListener(param1:String, param2:Function) : void
        {
            removeEventListener(param1, param2);
            return;
        }// end function

        public function getBaseEventDispatcher() : IBaseEventDispatcher
        {
            return this;
        }// end function

        public function dispatchEvt(event:Event) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

    }
}
