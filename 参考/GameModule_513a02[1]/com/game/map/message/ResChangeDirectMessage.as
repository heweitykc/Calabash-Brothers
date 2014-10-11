package com.game.map.message
{
    import com.game.utils.*;
    import net.*;

    public class ResChangeDirectMessage extends Message
    {
        private var _personId:long;
        private var _dir:int;

        public function ResChangeDirectMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._dir);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._dir = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 101127;
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

        public function get dir() : int
        {
            return this._dir;
        }// end function

        public function set dir(param1:int) : void
        {
            this._dir = param1;
            return;
        }// end function

    }
}
