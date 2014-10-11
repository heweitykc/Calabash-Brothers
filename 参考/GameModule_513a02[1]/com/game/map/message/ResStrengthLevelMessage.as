package com.game.map.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStrengthLevelMessage extends Message
    {
        private var _personId:long;
        private var _strengthLevel:int;

        public function ResStrengthLevelMessage()
        {
            return;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set strengthLevel(param1:int) : void
        {
            this._strengthLevel = param1;
            return;
        }// end function

        public function get strengthLevel() : int
        {
            return this._strengthLevel;
        }// end function

        override public function getId() : int
        {
            return 542103;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._strengthLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._strengthLevel = readByte();
            return true;
        }// end function

    }
}
