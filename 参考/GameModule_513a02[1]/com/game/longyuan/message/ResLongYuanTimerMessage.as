package com.game.longyuan.message
{
    import net.*;

    public class ResLongYuanTimerMessage extends Message
    {
        private var _status:int;

        public function ResLongYuanTimerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._status = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 115105;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
            return;
        }// end function

    }
}
