package com.game.newactivity.popularPay.view
{
    import com.f1.ui.*;
    import flash.display.*;
    import flash.text.*;

    public class PopularPayCard extends Component
    {
        public var index:int;
        private var _position:int;
        private var _state:int = 0;
        private var _txt:TextField;
        private var _mcSign:MovieClip;
        private var _mcMask:MovieClip;

        public function PopularPayCard(param1 = null, param2:String = null)
        {
            initComponentUI(param1);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this.mouseChildren = false;
            this._txt = TextField(getDisplayChildByName("txt"));
            this._mcSign = MovieClip(getDisplayChildByName("mc_sign"));
            this._mcMask = MovieClip(getDisplayChildByName("card_mask"));
            return;
        }// end function

        public function get position() : int
        {
            return this._position;
        }// end function

        public function set position(param1:int) : void
        {
            this._position = param1;
            if (this._position == 0)
            {
                this._mcMask.visible = false;
            }
            else
            {
                this._mcMask.visible = true;
            }
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            if (this._state == 2)
            {
                this._mcSign.gotoAndStop(2);
            }
            else
            {
                this._mcSign.gotoAndStop(1);
            }
            return;
        }// end function

    }
}
