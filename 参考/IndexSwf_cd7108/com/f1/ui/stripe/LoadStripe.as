package com.f1.ui.stripe
{
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.text.*;

    public class LoadStripe extends Component
    {
        private var _curVal:uint;
        private var _maxVal:uint;
        private var _maxWidth:uint;
        protected var _txt:TextField;
        private var _stripe:Sprite;
        protected var _moveName:String = "";
        private var _moveSp:Sprite;
        private var _txtName:String;
        private var _stripeName:String;

        public function LoadStripe(param1:String = "load_move_sp", param2 = "green_stripe1", param3:String = "txt", param4:String = "stripe")
        {
            mouseChildren = false;
            mouseEnabled = false;
            this._moveName = param1;
            this._txtName = param3;
            this._stripeName = param4;
            super(param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._txt = getDisplayChildByName(this._txtName);
            this._stripe = getDisplayChildByName(this._stripeName);
            this._maxWidth = this._stripe.width;
            this._moveSp = getDisplayChildByName(this._moveName);
            if (!this._moveSp)
            {
                this._moveSp = ToolKit.getNew(this._moveName);
                if (this._moveSp)
                {
                    addChild(this._moveSp);
                }
            }
            return;
        }// end function

        public function setValue(param1:uint, param2:uint, param3:Boolean = false) : void
        {
            this._curVal = param1;
            this._maxVal = param2;
            var _loc_4:* = uint(param1 * this._maxWidth / param2);
            if (this._stripe)
            {
                if (_loc_4 > this._maxWidth)
                {
                    _loc_4 = this._maxWidth;
                }
                if (param3)
                {
                    TweenLite.to(this._stripe, 0.2, {width:_loc_4});
                }
                else
                {
                    this._stripe.width = _loc_4;
                }
            }
            if (this._moveSp)
            {
                if (param3)
                {
                    TweenLite.to(this._moveSp, 0.2, {x:_loc_4});
                }
                else
                {
                    this._moveSp.x = _loc_4;
                }
            }
            return;
        }// end function

        public function setTxt(param1:String) : void
        {
            this._txt.text = param1;
            return;
        }// end function

    }
}
