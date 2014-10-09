package com.game.gradegift.message
{
    import net.*;

    public class ReqGainGradeGiftMessage extends Message
    {
        private var _giftId:int;

        public function ReqGainGradeGiftMessage()
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

        override public function getId() : int
        {
            return 600204;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._giftId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._giftId = readInt();
            return true;
        }// end function

    }
}
