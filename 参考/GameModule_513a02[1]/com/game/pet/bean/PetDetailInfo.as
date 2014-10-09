package com.game.pet.bean
{
    import __AS3__.vec.*;
    import com.game.player.bean.*;
    import com.game.skill.bean.*;
    import com.game.utils.*;
    import net.*;

    public class PetDetailInfo extends Bean
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
        private var _showState:int;
        private var _dieTime:int;
        private var _htCount:int;
        private var _dayCount:int;
        private var _htCoolDownTime:int;
        private var _skillInfos:Vector.<CSSkillInfo>;
        private var _htAddition:Vector.<PlayerAttributeItem>;

        public function PetDetailInfo()
        {
            this._skillInfos = new Vector.<CSSkillInfo>;
            this._htAddition = new Vector.<PlayerAttributeItem>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
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
            writeByte(this._showState);
            writeInt(this._dieTime);
            writeInt(this._htCount);
            writeInt(this._dayCount);
            writeInt(this._htCoolDownTime);
            writeShort(this._skillInfos.length);
            _loc_1 = 0;
            while (_loc_1 < this._skillInfos.length)
            {
                
                writeBean(this._skillInfos[_loc_1]);
                _loc_1++;
            }
            writeShort(this._htAddition.length);
            _loc_1 = 0;
            while (_loc_1 < this._htAddition.length)
            {
                
                writeBean(this._htAddition[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
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
            this._showState = readByte();
            this._dieTime = readInt();
            this._htCount = readInt();
            this._dayCount = readInt();
            this._htCoolDownTime = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skillInfos[_loc_2] = readBean(CSSkillInfo) as CSSkillInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._htAddition[_loc_2] = readBean(PlayerAttributeItem) as PlayerAttributeItem;
                _loc_2++;
            }
            return true;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get petModelId() : int
        {
            return this._petModelId;
        }// end function

        public function set petModelId(param1:int) : void
        {
            this._petModelId = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get hp() : int
        {
            return this._hp;
        }// end function

        public function set hp(param1:int) : void
        {
            this._hp = param1;
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

        public function get mp() : int
        {
            return this._mp;
        }// end function

        public function set mp(param1:int) : void
        {
            this._mp = param1;
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

        public function get sp() : int
        {
            return this._sp;
        }// end function

        public function set sp(param1:int) : void
        {
            this._sp = param1;
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

        public function get speed() : int
        {
            return this._speed;
        }// end function

        public function set speed(param1:int) : void
        {
            this._speed = param1;
            return;
        }// end function

        public function get showState() : int
        {
            return this._showState;
        }// end function

        public function set showState(param1:int) : void
        {
            this._showState = param1;
            return;
        }// end function

        public function get dieTime() : int
        {
            return this._dieTime;
        }// end function

        public function set dieTime(param1:int) : void
        {
            this._dieTime = param1;
            return;
        }// end function

        public function get htCount() : int
        {
            return this._htCount;
        }// end function

        public function set htCount(param1:int) : void
        {
            this._htCount = param1;
            return;
        }// end function

        public function get dayCount() : int
        {
            return this._dayCount;
        }// end function

        public function set dayCount(param1:int) : void
        {
            this._dayCount = param1;
            return;
        }// end function

        public function get htCoolDownTime() : int
        {
            return this._htCoolDownTime;
        }// end function

        public function set htCoolDownTime(param1:int) : void
        {
            this._htCoolDownTime = param1;
            return;
        }// end function

        public function get skillInfos() : Vector.<CSSkillInfo>
        {
            return this._skillInfos;
        }// end function

        public function set skillInfos(param1:Vector.<CSSkillInfo>) : void
        {
            this._skillInfos = param1;
            return;
        }// end function

        public function get htAddition() : Vector.<PlayerAttributeItem>
        {
            return this._htAddition;
        }// end function

        public function set htAddition(param1:Vector.<PlayerAttributeItem>) : void
        {
            this._htAddition = param1;
            return;
        }// end function

    }
}
