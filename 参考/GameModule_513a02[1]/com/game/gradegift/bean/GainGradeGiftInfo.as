package com.game.gradegift.bean
{
    import net.*;

    public class GainGradeGiftInfo extends Bean
    {
        private var _giftId:int;
        private var _isGain:int;

        public function GainGradeGiftInfo()
        {
            return;
        }// end function

        public function set giftId(param1:int) : void
        {
            this._giftId = param1;
            return;
        }// end function

        public function get giftId() : int
        {
            return this._giftId;
        }// end function

        public function set isGain(param1:int) : void
        {
            this._isGain = param1;
            return;
        }// end function

        public function get isGain() : int
        {
            return this._isGain;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._giftId);
            writeInt(this._isGain);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._giftId = readInt();
            this._isGain = readInt();
            return true;
        }// end function

    }
}
