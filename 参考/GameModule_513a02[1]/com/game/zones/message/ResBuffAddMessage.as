package com.game.zones.message
{
    import net.*;

    public class ResBuffAddMessage extends Message
    {
        private var _num:int;
        private var _buffId:int;

        public function ResBuffAddMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._num);
            writeInt(this._buffId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readByte();
            this._buffId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 528317;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get buffId() : int
        {
            return this._buffId;
        }// end function

        public function set buffId(param1:int) : void
        {
            this._buffId = param1;
            return;
        }// end function

    }
}
