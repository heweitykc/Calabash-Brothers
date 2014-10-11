package com.game.gem.message
{
    import net.*;

    public class ResGemErrorInfoMessage extends Message
    {
        private var _type:int;
        private var _intnum:int;

        public function ResGemErrorInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._intnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._intnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 132105;
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

        public function get intnum() : int
        {
            return this._intnum;
        }// end function

        public function set intnum(param1:int) : void
        {
            this._intnum = param1;
            return;
        }// end function

    }
}
