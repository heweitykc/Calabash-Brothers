package com.model.vo
{
    import com.f1.*;
    import flash.events.*;
    import flash.utils.*;

    public class TitleVO extends BaseEventDispatcher
    {
        public var titleid:int;
        public var rankQ:int;
        public var isModel:Boolean = false;
        private var _isGot:Boolean;
        private var _isUsing:Boolean;
        private var _lostTime:int;
        private var _timstp:int;

        public function TitleVO()
        {
            return;
        }// end function

        public function get lostTime() : int
        {
            return this._lostTime;
        }// end function

        public function get leftTime() : int
        {
            var _loc_1:* = (getTimer() - this._timstp) / 1000;
            return this._lostTime - _loc_1;
        }// end function

        public function get isOutofDate() : Boolean
        {
            if (this._lostTime == -1)
            {
                return false;
            }
            var _loc_1:* = (getTimer() - this._timstp) / 1000;
            return _loc_1 > this._lostTime;
        }// end function

        public function set lostTime(param1:int) : void
        {
            this._timstp = getTimer();
            this._lostTime = param1;
            this.fireChange();
            return;
        }// end function

        public function get isUsing() : Boolean
        {
            return this._isUsing;
        }// end function

        public function set isUsing(param1:Boolean) : void
        {
            if (this._isUsing != param1)
            {
                this._isUsing = param1;
                this.fireChange();
            }
            return;
        }// end function

        public function get isGot() : Boolean
        {
            return this._isGot;
        }// end function

        public function set isGot(param1:Boolean) : void
        {
            if (this._isGot != param1)
            {
                this._isGot = param1;
                this.fireChange();
            }
            return;
        }// end function

        public function openTitle(param1:int) : void
        {
            if (this.isGot == false)
            {
                this._isGot = true;
                this.lostTime = param1;
                this.fireChange();
            }
            return;
        }// end function

        public function reset() : void
        {
            this._isGot = false;
            return;
        }// end function

        public function fireChange() : void
        {
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

    }
}
