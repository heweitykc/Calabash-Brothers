package com.game.gradegift.bean
{
    import net.*;

    public class GradeGiftInfo extends Bean
    {
        private var _giftId:int;
        private var _reamain:int;

        public function GradeGiftInfo()
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

        public function set reamain(param1:int) : void
        {
            this._reamain = param1;
            return;
        }// end function

        public function get reamain() : int
        {
            return this._reamain;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._giftId);
            writeInt(this._reamain);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._giftId = readInt();
            this._reamain = readInt();
            return true;
        }// end function

    }
}
