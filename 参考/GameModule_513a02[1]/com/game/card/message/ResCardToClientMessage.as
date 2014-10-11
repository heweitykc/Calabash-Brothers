package com.game.card.message
{
    import net.*;

    public class ResCardToClientMessage extends Message
    {
        private var _errorcode:int;
        private var _agid:int;
        private var _type:int;
        private var _giftid:int;

        public function ResCardToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._errorcode);
            writeInt(this._agid);
            writeInt(this._type);
            writeInt(this._giftid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._errorcode = readByte();
            this._agid = readInt();
            this._type = readInt();
            this._giftid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 137151;
        }// end function

        public function get errorcode() : int
        {
            return this._errorcode;
        }// end function

        public function set errorcode(param1:int) : void
        {
            this._errorcode = param1;
            return;
        }// end function

        public function get agid() : int
        {
            return this._agid;
        }// end function

        public function set agid(param1:int) : void
        {
            this._agid = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get giftid() : int
        {
            return this._giftid;
        }// end function

        public function set giftid(param1:int) : void
        {
            this._giftid = param1;
            return;
        }// end function

    }
}
