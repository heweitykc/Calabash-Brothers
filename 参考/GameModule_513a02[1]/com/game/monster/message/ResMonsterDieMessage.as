package com.game.monster.message
{
    import com.game.utils.*;
    import net.*;

    public class ResMonsterDieMessage extends Message
    {
        private var _monsterId:long;
        private var _die:int;
        private var _killer:long;
        private var _skillId:int;

        public function ResMonsterDieMessage()
        {
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeByte(this._die);
            writeLong(this._killer);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            this._die = readByte();
            this._killer = readLong();
            this._skillId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 114108;
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

        public function get die() : int
        {
            return this._die;
        }// end function

        public function set die(param1:int) : void
        {
            this._die = param1;
            return;
        }// end function

        public function get killer() : long
        {
            return this._killer;
        }// end function

        public function set killer(param1:long) : void
        {
            this._killer = param1;
            return;
        }// end function

    }
}
