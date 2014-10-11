package com.f1.ui.stripe
{
    import com.f1.ui.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class Stripe extends Component
    {
        private var _curVal:Number;
        private var _maxVal:Number;
        private var _maxWidth:uint;
        protected var _txt:TextField;
        private var _stripe:Sprite;
        private var _txtName:String;
        private var _stripeName:String;
        private var _stripeBack:Sprite;
        private var _isOnlyIncrease:Boolean = false;
        private var lastExp:Number;

        public function Stripe(param1 = "green_stripe1", param2:String = "txt", param3:String = "stripe")
        {
            mouseChildren = false;
            mouseEnabled = false;
            this._txtName = param2;
            this._stripeName = param3;
            super(param1);
            this.initUI();
            return;
        }// end function

        public function get isOnlyIncrease() : Boolean
        {
            return this._isOnlyIncrease;
        }// end function

        public function set isOnlyIncrease(param1:Boolean) : void
        {
            this._isOnlyIncrease = param1;
            return;
        }// end function

        public function get maxValue() : Number
        {
            return this._maxVal;
        }// end function

        public function set maxValue(param1:Number) : void
        {
            this._maxVal = param1;
            return;
        }// end function

        public function get curValue() : Number
        {
            return this._curVal;
        }// end function

        public function set curValue(param1:Number) : void
        {
            this._curVal = param1;
            return;
        }// end function

        public function get maxWidth() : uint
        {
            return this._maxWidth;
        }// end function

        public function set maxWidth(param1:uint) : void
        {
            var _loc_2:* = 0;
            this._maxWidth = param1;
            if (this._stripe)
            {
                _loc_2 = uint(this._curVal * this._maxWidth / this._maxVal);
                if (_loc_2 > this._maxWidth)
                {
                    _loc_2 = this._maxWidth;
                }
                this._stripe.width = _loc_2;
            }
            _w = _loc_2;
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName(this._txtName);
            this._stripe = getDisplayChildByName(this._stripeName);
            this._stripeBack = getDisplayChildByName(this._stripeName + "Back");
            this._maxWidth = this._stripe.width;
            this._stripe.width = 0;
            return;
        }// end function

        public function setText(param1:String) : void
        {
            if (this._txt)
            {
                this._txt.text = param1;
            }
            return;
        }// end function

        public function fillStripe(param1:Number, param2:Function) : void
        {
            var time1:* = param1;
            var updateFun:* = param2;
            TweenLite.killTweensOf(this._stripe);
            var fun1:* = function () : void
            {
                updateFun(uint(100 * _stripe.width / _maxWidth));
                return;
            }// end function
            ;
            TweenLite.to(this._stripe, time1, {width:this._maxWidth, onUpdate:fun1});
            return;
        }// end function

        public function setValue(param1:Number, param2:Number, param3:Boolean = false, param4:String = "", param5:Boolean = true, param6:Function = null, param7:Boolean = false) : void
        {
            var _loc_8:* = 0;
            this.lastExp = this._curVal;
            this._curVal = param1;
            this._maxVal = param2;
            if (this._stripe)
            {
                _loc_8 = uint(param1 * this._maxWidth / param2);
                if (_loc_8 > this._maxWidth)
                {
                    _loc_8 = this._maxWidth;
                }
                if (param3)
                {
                    if (this._stripeBack)
                    {
                        TweenLite.killTweensOf(this._stripe);
                        this._stripe.width = _loc_8;
                        TweenLite.to(this._stripeBack, 0.5, {width:_loc_8, onComplete:param6});
                    }
                    else
                    {
                        if (param7)
                        {
                            this._stripe.width = uint(this.lastExp * this._maxWidth / param2);
                        }
                        else if (this._isOnlyIncrease && this._stripe.width > _loc_8)
                        {
                            this._stripe.width = 0;
                        }
                        if (param6 != null)
                        {
                            TweenLite.to(this._stripe, 0.5, {width:_loc_8, onComplete:param6});
                        }
                        else
                        {
                            TweenLite.to(this._stripe, 0.5, {width:_loc_8});
                        }
                    }
                }
                else
                {
                    TweenLite.killTweensOf(this._stripe);
                    this._stripe.width = _loc_8;
                    if (this._stripeBack)
                    {
                        this._stripeBack.width = _loc_8;
                    }
                }
            }
            if (this._txt)
            {
                if (param5)
                {
                    this._txt.text = param4 + param1 + "/" + param2;
                }
                else
                {
                    this._txt.text = "";
                }
            }
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function getCurVal() : uint
        {
            return this._curVal;
        }// end function

        public function getMaxVal() : uint
        {
            return this._maxVal;
        }// end function

        public function get currentStripeWidth() : uint
        {
            return this._stripe.width;
        }// end function

        public function get stripe() : Sprite
        {
            return this._stripe;
        }// end function

    }
}
