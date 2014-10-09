package com.game.magicbook.bean
{
    import com.game.utils.*;
    import net.*;

    public class MagicBeAttackInfo extends Bean
    {
        private var _targetId:long;
        private var _result:int;
        private var _hurt:int;
        private var _currentHp:int;

        public function MagicBeAttackInfo()
        {
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

        public function set targetId(param1:long) : void
        {
            this._targetId = param1;
            return;
        }// end function

        public function get targetId() : long
        {
            return this._targetId;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set hurt(param1:int) : void
        {
            this._hurt = param1;
            return;
        }// end function

        public function get hurt() : int
        {
            return this._hurt;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._targetId);
            writeInt(this._result);
            writeInt(this._hurt);
            writeInt(this._currentHp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._targetId = readLong();
            this._result = readInt();
            this._hurt = readInt();
            this._currentHp = readInt();
            return true;
        }// end function

    }
}
