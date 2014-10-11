package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterMaxMpChangeMessage extends Message
    {
        private var _monsterId:long;
        private var _currentMp:int;
        private var _maxMp:int;

        public function ResMonsterMaxMpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeInt(this._currentMp);
            writeInt(this._maxMp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._currentMp = readInt();
            this._maxMp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114105;
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
