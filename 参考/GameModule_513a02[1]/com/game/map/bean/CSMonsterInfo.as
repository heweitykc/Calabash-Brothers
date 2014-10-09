package com.game.map.bean
{
    import __AS3__.vec.*;
    import com.game.buff.bean.*;
    import com.game.utils.*;
    import net.*;

    public class CSMonsterInfo extends Bean
    {
        private var _monsterId:long;
        private var _monsterModelId:int;
        private var _monsterName:String;
        private var _monsterRes:String;
        private var _monsterIcon:String;
        private var _friend:int;
        private var _friendPara:String;
        private var _level:int;
        private var _mapId:int;
        private var _x:int;
        private var _y:int;
        private var _hp:int;
        private var _maxHp:int;
        private var _mp:int;
        private var _maxMp:int;
        private var _sp:int;
        private var _maxSp:int;
        private var _speed:int;
        private var _morph:int;
        private var _dir:int;
        private var _positions:Vector.<int>;
        private var _buffs:Vector.<CSBuffInfo>;

        public function CSMonsterInfo()
        {
            this._positions = new Vector.<int>;
            this._buffs = new Vector.<CSBuffInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._monsterId);
            writeInt(this._monsterModelId);
            writeString(this._monsterName);
            writeString(this._monsterRes);
            writeString(this._monsterIcon);
            writeByte(this._friend);
            writeString(this._friendPara);
            writeInt(this._level);
            writeInt(this._mapId);
            writeShort(this._x);
            writeShort(this._y);
            writeInt(this._hp);
            writeInt(this._maxHp);
            writeInt(this._mp);
            writeInt(this._maxMp);
            writeInt(this._sp);
            writeInt(this._maxSp);
            writeInt(this._speed);
            writeInt(this._morph);
            writeByte(this._dir);
            writeShort(this._positions.length);
            _loc_1 = 0;
            while (_loc_1 < this._positions.length)
            {
                
                writeByte(this._positions[_loc_1]);
                _loc_1++;
            }
            writeShort(this._buffs.length);
            _loc_1 = 0;
            while (_loc_1 < this._buffs.length)
            {
                
                writeBean(this._buffs[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._monsterId = readLong();
            this._monsterModelId = readInt();
            this._monsterName = readString();
            this._monsterRes = readString();
            this._monsterIcon = readString();
            this._friend = readByte();
            this._friendPara = readString();
            this._level = readInt();
            this._mapId = readInt();
            this._x = readShort();
            this._y = readShort();
            this._hp = readInt();
            this._maxHp = readInt();
            this._mp = readInt();
            this._maxMp = readInt();
            this._sp = readInt();
            this._maxSp = readInt();
            this._speed = readInt();
            this._morph = readInt();
            this._dir = readByte();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._positions[_loc_2] = readByte();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._buffs[_loc_2] = readBean(CSBuffInfo) as CSBuffInfo;
                _loc_2++;
            }
            return true;
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

        public function get monsterModelId() : int
        {
            return this._monsterModelId;
        }// end function

        public function set monsterModelId(param1:int) : void
        {
            this._monsterModelId = param1;
            return;
        }// end function

        public function get monsterName() : String
        {
            return this._monsterName;
        }// end function

        public function set monsterName(param1:String) : void
        {
            this._monsterName = param1;
            return;
        }// end function

        public function get monsterRes() : String
        {
            return this._monsterRes;
        }// end function

        public function set monsterRes(param1:String) : void
        {
            this._monsterRes = param1;
            return;
        }// end function

        public function get monsterIcon() : String
        {
            return this._monsterIcon;
        }// end function

        public function set monsterIcon(param1:String) : void
        {
            this._monsterIcon = param1;
            return;
        }// end function

        public function get friend() : int
        {
            return this._friend;
        }// end function

        public function set friend(param1:int) : void
        {
            this._friend = param1;
            return;
        }// end function

        public function get friendPara() : String
        {
            return this._friendPara;
        }// end function

        public function set friendPara(param1:String) : void
        {
            this._friendPara = param1;
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

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
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

        public function get morph() : int
        {
            return this._morph;
        }// end function

        public function set morph(param1:int) : void
        {
            this._morph = param1;
            return;
        }// end function

        public function get dir() : int
        {
            return this._dir;
        }// end function

        public function set dir(param1:int) : void
        {
            this._dir = param1;
            return;
        }// end function

        public function get positions() : Vector.<int>
        {
            return this._positions;
        }// end function

        public function set positions(param1:Vector.<int>) : void
        {
            this._positions = param1;
            return;
        }// end function

        public function get buffs() : Vector.<CSBuffInfo>
        {
            return this._buffs;
        }// end function

        public function set buffs(param1:Vector.<CSBuffInfo>) : void
        {
            this._buffs = param1;
            return;
        }// end function

    }
}
