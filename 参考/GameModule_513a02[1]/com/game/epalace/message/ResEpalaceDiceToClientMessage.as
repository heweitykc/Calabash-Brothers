package com.game.epalace.message
{
    import net.*;

    public class ResEpalaceDiceToClientMessage extends Message
    {
        private var _num:int;
        private var _movenum:int;
        private var _time:int;

        public function ResEpalaceDiceToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._num);
            writeByte(this._movenum);
            writeInt(this._time);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readByte();
            this._movenum = readByte();
            this._time = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 143102;
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

        public function get movenum() : int
        {
            return this._movenum;
        }// end function

        public function set movenum(param1:int) : void
        {
            this._movenum = param1;
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

    }
}
