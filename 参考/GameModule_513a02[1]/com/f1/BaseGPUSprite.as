package com.f1
{
    import starling.display.*;

    public class BaseGPUSprite extends Sprite
    {
        protected var __w:uint;
        protected var __h:uint;

        public function BaseGPUSprite()
        {
            return;
        }// end function

        public function get _h() : uint
        {
            return this.__h;
        }// end function

        public function set _h(param1:uint) : void
        {
            this.__h = param1;
            return;
        }// end function

        public function get _w() : uint
        {
            return this.__w;
        }// end function

        public function set _w(param1:uint) : void
        {
            this.__w = param1;
            return;
        }// end function

        public function setScale(param1:Number) : void
        {
            var _loc_2:* = param1;
            scaleY = param1;
            scaleX = _loc_2;
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            x = param1 * scaleX;
            y = param2 * scaleY;
            return;
        }// end function

        public function setFilters(param1:Array) : void
        {
            return;
        }// end function

        public function resize() : void
        {
            return;
        }// end function

        public function clearChild(param1:Boolean = false) : void
        {
            BaseGPUSprite.clearChild(this, param1);
            return;
        }// end function

        public function addEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            addEventListener(param1, param2);
            return;
        }// end function

        public function addEvtListeners(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in param1)
            {
                
                this.addEvtListener(_loc_5, param2);
            }
            return;
        }// end function

        public function removeEvtListener(param1:String, param2:Function) : void
        {
            removeEventListener(param1, param2);
            return;
        }// end function

        public function finalize() : void
        {
            this.clearChild();
            dispose();
            return;
        }// end function

        public static function clearChild(param1:Sprite, param2:Boolean = false) : void
        {
            var _loc_3:* = undefined;
            while (param1.numChildren > 0)
            {
                
                _loc_3 = param1.getChildAt(0);
                _loc_3.dispose();
                if (param2)
                {
                    if (_loc_3 is Image)
                    {
                        Image(_loc_3).texture.dispose();
                    }
                }
                param1.removeChild(_loc_3);
            }
            return;
        }// end function

    }
}
