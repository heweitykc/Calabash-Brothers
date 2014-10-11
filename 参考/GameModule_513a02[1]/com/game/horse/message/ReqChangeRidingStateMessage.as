package com.game.horse.message
{
    import net.*;

    public class ReqChangeRidingStateMessage extends Message
    {
        private var _curlayer:int;
        private var _status:int;

        public function ReqChangeRidingStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._curlayer);
            writeByte(this._status);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._curlayer = readShort();
            this._status = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126202;
        }// end function

        public function get curlayer() : int
        {
            return this._curlayer;
        }// end function

        public function set curlayer(param1:int) : void
        {
            this._curlayer = param1;
            return;
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
