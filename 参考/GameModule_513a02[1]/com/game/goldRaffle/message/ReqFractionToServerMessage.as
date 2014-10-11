package com.game.goldRaffle.message
{
    import net.*;

    public class ReqFractionToServerMessage extends Message
    {
        private var _fractionId:int;

        public function ReqFractionToServerMessage()
        {
            return;
        }// end function

        public function set fractionId(param1:int) : void
        {
            this._fractionId = param1;
            return;
        }// end function

        public function get fractionId() : int
        {
            return this._fractionId;
        }// end function

        override public function getId() : int
        {
            return 528205;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fractionId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fractionId = readInt();
            return true;
        }// end function

    }
}
