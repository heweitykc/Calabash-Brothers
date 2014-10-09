package com.game.activities.message
{
    import net.*;

    public class ResReceiveLiJinGiftResultMessage extends Message
    {
        private var _nextReceiveNeedTime:int;
        private var _result:int;

        public function ResReceiveLiJinGiftResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._nextReceiveNeedTime);
            writeByte(this._result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._nextReceiveNeedTime = readInt();
            this._result = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 138102;
        }// end function

        public function get nextReceiveNeedTime() : int
        {
            return this._nextReceiveNeedTime;
        }// end function

        public function set nextReceiveNeedTime(param1:int) : void
        {
            this._nextReceiveNeedTime = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

    }
}
