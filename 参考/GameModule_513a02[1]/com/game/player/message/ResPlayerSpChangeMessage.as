package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerSpChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentSp:int;

        public function ResPlayerSpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentSp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentSp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103106;
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

        public function get currentSp() : int
        {
            return this._currentSp;
        }// end function

        public function set currentSp(param1:int) : void
        {
            this._currentSp = param1;
            return;
        }// end function

    }
}
