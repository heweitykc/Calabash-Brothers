package com.game.goldRaffle.view.component
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;

    public class NumberMc extends BaseSprite
    {
        private var _num:int = 0;
        private var _mcUrl:String;
        private var _interX:Number = 0;

        public function NumberMc(param1:String = "goldRaffles_num1")
        {
            this._mcUrl = param1;
            return;
        }// end function

        public function setNumber(param1:int, param2:Boolean = false) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_7:* = 0;
            this._num = param1;
            ToolKit.clearMcChild(this);
            var _loc_3:* = param1.toString();
            var _loc_6:* = _loc_3.length;
            if (param2)
            {
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    param1 = int(_loc_3.charAt(_loc_7));
                    _loc_5 = ToolKit.getNew(this._mcUrl);
                    _loc_5.gotoAndPlay(Math.ceil(Math.random() * 10));
                    _loc_5.x = this.width + this._interX * (_loc_7 == 0 ? (0) : (1));
                    addChild(_loc_5);
                    _loc_7++;
                }
                TweenLite.delayedCall(0.5, this.setNumber, [this._num]);
            }
            else
            {
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    param1 = int(_loc_3.charAt(_loc_7));
                    _loc_5 = ToolKit.getNew(this._mcUrl);
                    _loc_5.gotoAndStop((param1 + 1));
                    _loc_5.x = this.width + this._interX * (_loc_7 == 0 ? (0) : (1));
                    addChild(_loc_5);
                    _loc_7++;
                }
            }
            return;
        }// end function

        public function get interX() : Number
        {
            return this._interX;
        }// end function

        public function set interX(param1:Number) : void
        {
            this._interX = param1;
            this.setNumber(param1);
            return;
        }// end function

    }
}
