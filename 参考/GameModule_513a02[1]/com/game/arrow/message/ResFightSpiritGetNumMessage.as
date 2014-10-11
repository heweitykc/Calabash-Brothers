package com.game.arrow.message
{
    import net.*;

    public class ResFightSpiritGetNumMessage extends Message
    {
        private var _num:int;
        private var _zoneid:int;
        private var _first:int;

        public function ResFightSpiritGetNumMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._num);
            writeInt(this._zoneid);
            writeInt(this._first);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readInt();
            this._zoneid = readInt();
            this._first = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 151105;
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

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get first() : int
        {
            return this._first;
        }// end function

        public function set first(param1:int) : void
        {
            this._first = param1;
            return;
        }// end function

    }
}
