package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterSayMessage extends Message
    {
        private var _monsterId:long;
        private var _saycontent:String;

        public function ResMonsterSayMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeString(this._saycontent);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._saycontent = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114110;
        }// end function

        public function get monsterId() : long
        {
            return this._monsterId;
        }// end function

        public function set monsterId(param1:long) : void
        {
            this._monsterId = param1;
            return;
        }// end function

        public function get saycontent() : String
        {
            return this._saycontent;
        }// end function

        public function set saycontent(param1:String) : void
        {
            this._saycontent = param1;
            return;
        }// end function

    }
}
