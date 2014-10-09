package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerMaxMpChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentMp:int;
        private var _maxMp:int;

        public function ResPlayerMaxMpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentMp);
            writeInt(this._maxMp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentMp = readInt();
            this._maxMp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103110;
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

        public function get currentMp() : int
        {
            return this._currentMp;
        }// end function

        public function set currentMp(param1:int) : void
        {
            this._currentMp = param1;
            return;
        }// end function

        public function get maxMp() : int
        {
            return this._maxMp;
        }// end function

        public function set maxMp(param1:int) : void
        {
            this._maxMp = param1;
            return;
        }// end function

    }
}
