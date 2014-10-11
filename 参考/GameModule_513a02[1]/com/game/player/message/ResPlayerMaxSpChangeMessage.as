package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerMaxSpChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentSp:int;
        private var _maxSp:int;

        public function ResPlayerMaxSpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentSp);
            writeInt(this._maxSp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentSp = readInt();
            this._maxSp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103111;
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

        public function get maxSp() : int
        {
            return this._maxSp;
        }// end function

        public function set maxSp(param1:int) : void
        {
            this._maxSp = param1;
            return;
        }// end function

    }
}
