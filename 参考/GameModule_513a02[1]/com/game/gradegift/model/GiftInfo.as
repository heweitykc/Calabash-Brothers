package com.game.gradegift.model
{

    public class GiftInfo extends Object
    {
        private var _giftId:int;
        private var _remain:int;
        private var _isGain:int;

        public function GiftInfo()
        {
            return;
        }// end function

        public function get giftId() : int
        {
            return this._giftId;
        }// end function

        public function set giftId(param1:int) : void
        {
            this._giftId = param1;
            return;
        }// end function

        public function get remain() : int
        {
            return this._remain;
        }// end function

        public function set remain(param1:int) : void
        {
            this._remain = param1;
            return;
        }// end function

        public function get isGain() : int
        {
            return this._isGain;
        }// end function

        public function set isGain(param1:int) : void
        {
            this._isGain = param1;
            return;
        }// end function

    }
}
