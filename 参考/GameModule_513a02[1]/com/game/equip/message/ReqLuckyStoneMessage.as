package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqLuckyStoneMessage extends Message
    {
        private var _equipId:long;
        private var _useBind:int;

        public function ReqLuckyStoneMessage()
        {
            return;
        }// end function

        public function set equipId(param1:long) : void
        {
            this._equipId = param1;
            return;
        }// end function

        public function get equipId() : long
        {
            return this._equipId;
        }// end function

        public function set useBind(param1:int) : void
        {
            this._useBind = param1;
            return;
        }// end function

        public function get useBind() : int
        {
            return this._useBind;
        }// end function

        override public function getId() : int
        {
            return 504200;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._equipId);
            writeByte(this._useBind);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equipId = readLong();
            this._useBind = readByte();
            return true;
        }// end function

    }
}
