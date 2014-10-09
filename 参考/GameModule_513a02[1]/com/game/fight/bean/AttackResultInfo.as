package com.game.fight.bean
{
    import com.game.utils.*;
    import net.*;

    public class AttackResultInfo extends Bean
    {
        private var _entityId:long;
        private var _sourceId:long;
        private var _skillId:int;
        private var _skillLevel:int;
        private var _fightResult:int;
        private var _damage:int;
        private var _hit:int;
        private var _back:int;
        private var _currentHP:int;
        private var _fightSpecialRes:int;

        public function AttackResultInfo()
        {
            return;
        }// end function

        public function get currentHP() : int
        {
            return this._currentHP;
        }// end function

        public function set currentHP(param1:int) : void
        {
            this._currentHP = param1;
            return;
        }// end function

        public function get fightSpecialRes() : int
        {
            return this._fightSpecialRes;
        }// end function

        public function set fightSpecialRes(param1:int) : void
        {
            this._fightSpecialRes = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._entityId);
            writeLong(this._sourceId);
            writeInt(this._skillId);
            writeInt(this._skillLevel);
            writeInt(this._fightResult);
            writeInt(this._damage);
            writeInt(this._hit);
            writeInt(this._back);
            writeInt(this._currentHP);
            writeInt(this._fightSpecialRes);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._entityId = readLong();
            this._sourceId = readLong();
            this._skillId = readInt();
            this._skillLevel = readInt();
            this._fightResult = readInt();
            this._damage = readInt();
            this._hit = readInt();
            this._back = readInt();
            this._currentHP = readInt();
            this._fightSpecialRes = readInt();
            return true;
        }// end function

        public function get entityId() : long
        {
            return this._entityId;
        }// end function

        public function set entityId(param1:long) : void
        {
            this._entityId = param1;
            return;
        }// end function

        public function get sourceId() : long
        {
            return this._sourceId;
        }// end function

        public function set sourceId(param1:long) : void
        {
            this._sourceId = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get skillLevel() : int
        {
            return this._skillLevel;
        }// end function

        public function set skillLevel(param1:int) : void
        {
            this._skillLevel = param1;
            return;
        }// end function

        public function get fightResult() : int
        {
            return this._fightResult;
        }// end function

        public function set fightResult(param1:int) : void
        {
            this._fightResult = param1;
            return;
        }// end function

        public function get damage() : int
        {
            return this._damage;
        }// end function

        public function set damage(param1:int) : void
        {
            this._damage = param1;
            return;
        }// end function

        public function get hit() : int
        {
            return this._hit;
        }// end function

        public function set hit(param1:int) : void
        {
            this._hit = param1;
            return;
        }// end function

        public function get back() : int
        {
            return this._back;
        }// end function

        public function set back(param1:int) : void
        {
            this._back = param1;
            return;
        }// end function

    }
}
