package com.game.goldRaffle.message
{
    import net.*;

    public class ResFractionToClientMessage extends Message
    {
        private var _fractionId:int;
        private var _itemID:int;

        public function ResFractionToClientMessage()
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

        public function set itemID(param1:int) : void
        {
            this._itemID = param1;
            return;
        }// end function

        public function get itemID() : int
        {
            return this._itemID;
        }// end function

        override public function getId() : int
        {
            return 528106;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fractionId);
            writeInt(this._itemID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fractionId = readInt();
            this._itemID = readInt();
            return true;
        }// end function

    }
}
