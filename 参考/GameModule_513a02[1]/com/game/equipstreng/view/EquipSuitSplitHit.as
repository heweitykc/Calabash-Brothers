package com.game.equipstreng.view
{
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import flash.events.*;
    import flash.utils.*;

    public class EquipSuitSplitHit extends BaseBox
    {
        private var btnCancel:BaseButton;
        private var stripeHit:Stripe;
        private var _time:Timer;
        public var callBack:Function;

        public function EquipSuitSplitHit(param1 = null, param2:String = null)
        {
            initComponentUI("suit_split_hit");
            _peaceBox = ["*"];
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnCancel = new BaseButton(getDisplayChildByName("btn_cancel"));
            this.stripeHit = new Stripe(getDisplayChildByName("stripe_hit"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.btnCancel.addEventListener(MouseEvent.CLICK, this.mouseClick);
            return;
        }// end function

        protected function mouseClick(event:MouseEvent) : void
        {
            if (this._time && this._time.running)
            {
                this._time.reset();
            }
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.startHit();
            return;
        }// end function

        private function startHit() : void
        {
            if (this._time)
            {
                this._time.reset();
            }
            else
            {
                this._time = new Timer(20, 50);
                this._time.addEventListener(TimerEvent.TIMER, this.onTime);
                this._time.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeComplete);
            }
            this._time.start();
            return;
        }// end function

        protected function onTime(event:TimerEvent) : void
        {
            this.stripeHit.setValue(this._time.currentCount, 50);
            return;
        }// end function

        protected function onTimeComplete(event:TimerEvent) : void
        {
            if (this.callBack != null)
            {
                this.callBack();
            }
            this.close();
            return;
        }// end function

    }
}
