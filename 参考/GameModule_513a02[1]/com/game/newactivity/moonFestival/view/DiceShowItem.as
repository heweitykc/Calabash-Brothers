package com.game.newactivity.moonFestival.view
{
    import com.f1.ui.*;
    import com.game.newactivity.moonFestival.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class DiceShowItem extends Component
    {
        private var _isFour:Boolean;
        private var _num:int;
        private var _lastTime:int;
        private var _willBeFour:Boolean;
        private var _locked:Boolean;

        public function DiceShowItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            (display as MovieClip).gotoAndStop(1);
            this._num = 1;
            return;
        }// end function

        public function get locked() : Boolean
        {
            return this._locked;
        }// end function

        public function set locked(param1:Boolean) : void
        {
            this._locked = param1;
            return;
        }// end function

        public function get willBeFour() : Boolean
        {
            return this._willBeFour;
        }// end function

        public function set willBeFour(param1:Boolean) : void
        {
            this._willBeFour = param1;
            return;
        }// end function

        public function startScroll() : void
        {
            this._lastTime = getTimer();
            addEvtListener(Event.ENTER_FRAME, this.__enterframe);
            return;
        }// end function

        private function __enterframe(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._lastTime > 200)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._num + 1;
                _loc_3._num = _loc_4;
                if (this._num > MoonDiceModel.DICE_COUNT)
                {
                    this._num = 1;
                }
                (display as MovieClip).gotoAndStop(this._num);
            }
            return;
        }// end function

        public function reset() : void
        {
            this._isFour = false;
            this._willBeFour = false;
            return;
        }// end function

        public function get isFour() : Boolean
        {
            return this._isFour;
        }// end function

        public function stopScroll(param1:int) : void
        {
            removeEvtListener(Event.ENTER_FRAME, this.__enterframe);
            (display as MovieClip).gotoAndStop(param1);
            this._num = param1;
            this._isFour = param1 == MoonDiceModel.DICE_COUNT;
            return;
        }// end function

    }
}
