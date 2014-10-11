package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerMpChangeMessage extends Message
    {
        private var _personId:long;
        private var _currentMp:int;

        public function ResPlayerMpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._currentMp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._currentMp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103105;
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

    }
}
