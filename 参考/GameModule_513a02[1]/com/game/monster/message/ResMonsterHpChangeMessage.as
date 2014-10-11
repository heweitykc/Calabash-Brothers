package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterHpChangeMessage extends Message
    {
        private var _monsterId:long;
        private var _currentHp:int;

        public function ResMonsterHpChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeInt(this._currentHp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._currentHp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114101;
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

    }
}
