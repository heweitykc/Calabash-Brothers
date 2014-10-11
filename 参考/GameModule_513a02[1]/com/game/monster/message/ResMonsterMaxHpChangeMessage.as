package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterMaxHpChangeMessage extends Message
    {
        private var _monsterId:long;
        private var _currentHp:int;
        private var _maxHp:int;

        public function ResMonsterMaxHpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeInt(this._currentHp);
            writeInt(this._maxHp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._currentHp = readInt();
            this._maxHp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114104;
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

        public function get currentHp() : int
        {
            return this._currentHp;
        }// end function

        public function set currentHp(param1:int) : void
        {
            this._currentHp = param1;
            return;
        }// end function

        public function get maxHp() : int
        {
            return this._maxHp;
        }// end function

        public function set maxHp(param1:int) : void
        {
            this._maxHp = param1;
            return;
        }// end function

    }
}
