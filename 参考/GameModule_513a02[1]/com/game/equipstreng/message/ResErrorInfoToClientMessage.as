package com.game.equipstreng.message
{
    import net.*;

    public class ResErrorInfoToClientMessage extends Message
    {
        private var _type:int;
        private var _errint:int;
        private var _errstr:String;

        public function ResErrorInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._errint);
            writeString(this._errstr);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._errint = readInt();
            this._errstr = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 130103;
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

        public function get errint() : int
        {
            return this._errint;
        }// end function

        public function set errint(param1:int) : void
        {
            this._errint = param1;
            return;
        }// end function

        public function get errstr() : String
        {
            return this._errstr;
        }// end function

        public function set errstr(param1:String) : void
        {
            this._errstr = param1;
            return;
        }// end function

    }
}
