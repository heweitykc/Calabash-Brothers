package com.game.summonpet.bean
{
    import __AS3__.vec.*;
    import com.game.skill.bean.*;
    import com.game.utils.*;
    import net.*;

    public class SummonPetDetailInfo extends Bean
    {
        private var _petId:long;
        private var _petModelId:int;
        private var _level:int;
        private var _hp:int;
        private var _maxHp:int;
        private var _mp:int;
        private var _maxMp:int;
        private var _sp:int;
        private var _maxSp:int;
        private var _speed:int;
        private var _skillInfos:Vector.<CSSkillInfo>;

        public function SummonPetDetailInfo()
        {
            this._skillInfos = new Vector.<CSSkillInfo>;
            return;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petModelId(param1:int) : void
        {
            this._petModelId = param1;
            return;
        }// end function

        public function get petModelId() : int
        {
            return this._petModelId;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
            return;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set maxHp(param1:int) : void
        {
            this._maxHp = param1;
            return;
        }// end function

        public function get maxHp() : int
        {
            return this._maxHp;
        }// end function

        public function set mp(param1:int) : void
        {
            this._mp = param1;
            return;
        }// end function

        public function get mp() : int
        {
            return this._mp;
        }// end function

        public function set maxMp(param1:int) : void
        {
            this._maxMp = param1;
            return;
        }// end function

        public function get maxMp() : int
        {
            return this._maxMp;
        }// end function

        public function set sp(param1:int) : void
        {
            this._sp = param1;
            return;
        }// end function

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function set maxSp(param1:int) : void
        {
            this._maxSp = param1;
            return;
        }// end function

        public function get maxSp() : int
        {
            return this._maxSp;
        }// end function

        public function set speed(param1:int) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function set skillInfos(param1:Vector.<CSSkillInfo>) : void
        {
            this._skillInfos = param1;
            return;
        }// end function

        public function get skillInfos() : Vector.<CSSkillInfo>
        {
            return this._skillInfos;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeInt(this._petModelId);
            writeInt(this._level);
            writeInt(this._hp);
            writeInt(this._maxHp);
            writeInt(this._mp);
            writeInt(this._maxMp);
            writeInt(this._sp);
            writeInt(this._maxSp);
            writeInt(this._speed);
            writeShort(this._skillInfos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._skillInfos.length)
            {
                
                writeBean(this._skillInfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._petModelId = readInt();
            this._level = readInt();
            this._hp = readInt();
            this._maxHp = readInt();
            this._mp = readInt();
            this._maxMp = readInt();
            this._sp = readInt();
            this._maxSp = readInt();
            this._speed = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skillInfos[_loc_2] = readBean(CSSkillInfo) as CSSkillInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
