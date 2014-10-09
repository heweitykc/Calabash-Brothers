package com.game.gift.message
{
    import net.*;

    public class ResGetPlatformGiftMessage extends Message
    {
        private var _giftid:int;
        private var _result:int;

        public function ResGetPlatformGiftMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._giftid);
            writeInt(this._result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._giftid = readInt();
            this._result = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 129104;
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
