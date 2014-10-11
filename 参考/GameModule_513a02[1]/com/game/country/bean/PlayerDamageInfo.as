package com.game.country.bean
{
    import com.game.utils.*;
    import net.*;

    public class PlayerDamageInfo extends Bean
    {
        private var _personId:long;
        private var _name:String;
        private var _sex:int;
        private var _x:int;
        private var _y:int;
        private var _hp:int;
        private var _maxHp:int;
        private var _state:int;
        private var _weapon:int;
        private var _armor:int;
        private var _avatar:int;
        private var _dir:int;
        private var _guild:long;
        private var _horseid:int;
        private var _damage:int;

        public function PlayerDamageInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeString(this._name);
            writeByte(this._sex);
            writeShort(this._x);
            writeShort(this._y);
            writeInt(this._hp);
            writeInt(this._maxHp);
            writeInt(this._state);
            writeInt(this._weapon);
            writeInt(this._armor);
            writeInt(this._avatar);
            writeByte(this._dir);
            writeLong(this._guild);
            writeShort(this._horseid);
            writeInt(this._damage);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._name = readString();
            this._sex = readByte();
            this._x = readShort();
            this._y = readShort();
            this._hp = readInt();
            this._maxHp = readInt();
            this._state = readInt();
            this._weapon = readInt();
            this._armor = readInt();
            this._avatar = readInt();
            this._dir = readByte();
            this._guild = readLong();
            this._horseid = readShort();
            this._damage = readInt();
            return true;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get sex() : int
        {
            return this._sex;
        }// end function

        public function set sex(param1:int) : void
        {
            this._sex = param1;
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

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get weapon() : int
        {
            return this._weapon;
        }// end function

        public function set weapon(param1:int) : void
        {
            this._weapon = param1;
            return;
        }// end function

        public function get armor() : int
        {
            return this._armor;
        }// end function

        public function set armor(param1:int) : void
        {
            this._armor = param1;
            return;
        }// end function

        public function get avatar() : int
        {
            return this._avatar;
        }// end function

        public function set avatar(param1:int) : void
        {
            this._avatar = param1;
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

        public function get guild() : long
        {
            return this._guild;
        }// end function

        public function set guild(param1:long) : void
        {
            this._guild = param1;
            return;
        }// end function

        public function get horseid() : int
        {
            return this._horseid;
        }// end function

        public function set horseid(param1:int) : void
        {
            this._horseid = param1;
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

    }
}
