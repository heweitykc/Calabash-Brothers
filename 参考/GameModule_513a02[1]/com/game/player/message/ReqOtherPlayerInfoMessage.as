package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqOtherPlayerInfoMessage extends Message
    {
        private var _personId:long;
        private var _type:int;

        public function ReqOtherPlayerInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103203;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
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

    }
}
