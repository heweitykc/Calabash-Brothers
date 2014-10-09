package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterMaxSpChangeMessage extends Message
    {
        private var _monsterId:long;
        private var _currentSp:int;
        private var _maxSp:int;

        public function ResMonsterMaxSpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeInt(this._currentSp);
            writeInt(this._maxSp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._currentSp = readInt();
            this._maxSp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114106;
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
