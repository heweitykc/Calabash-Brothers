package com.game.map.bean
{
    import __AS3__.vec.*;
    import com.game.buff.bean.*;
    import com.game.utils.*;
    import net.*;

    public class PetInfo extends Bean
    {
        private var _petId:long;
        private var _petModelId:int;
        private var _ownerId:long;
        private var _ownerName:String;
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
        private var _dir:int;
        private var _positions:Vector.<int>;
        private var _buffs:Vector.<CSBuffInfo>;
        private var _sxstate:int;

        public function PetInfo()
        {
            this._positions = new Vector.<int>;
            this._buffs = new Vector.<CSBuffInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._petId);
            writeInt(this._petModelId);
            writeLong(this._ownerId);
            writeString(this._ownerName);
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
            writeByte(this._sxstate);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._petId = readLong();
            this._petModelId = readInt();
            this._ownerId = readLong();
            this._ownerName = readString();
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
            this._sxstate = readByte();
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

        public function get ownerId() : long
        {
            return this._ownerId;
        }// end function

        public function set ownerId(param1:long) : void
        {
            this._ownerId = param1;
            return;
        }// end function

        public function get ownerName() : String
        {
            return this._ownerName;
        }// end function

        public function set ownerName(param1:String) : void
        {
            this._ownerName = param1;
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

        public function get sxstate() : int
        {
            return this._sxstate;
        }// end function

        public function set sxstate(param1:int) : void
        {
            this._sxstate = param1;
            return;
        }// end function

    }
}
