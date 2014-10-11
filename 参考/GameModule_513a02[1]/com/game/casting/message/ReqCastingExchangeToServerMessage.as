package com.game.casting.message
{
    import net.*;

    public class ReqCastingExchangeToServerMessage extends Message
    {
        private var _exchangeID:int;

        public function ReqCastingExchangeToServerMessage()
        {
            return;
        }// end function

        public function set exchangeID(param1:int) : void
        {
            this._exchangeID = param1;
            return;
        }// end function

        public function get exchangeID() : int
        {
            return this._exchangeID;
        }// end function

        override public function getId() : int
        {
            return 529206;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._exchangeID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._exchangeID = readInt();
            return true;
        }// end function

    }
}
