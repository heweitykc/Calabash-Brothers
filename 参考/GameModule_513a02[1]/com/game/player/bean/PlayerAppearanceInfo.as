package com.game.player.bean
{
    import __AS3__.vec.*;
    import com.game.equip.bean.*;
    import net.*;

    public class PlayerAppearanceInfo extends Bean
    {
        private var _sex:int;
        private var _clothingmodid:int;
        private var _weaponmodid:int;
        private var _weaponStreng:int;
        private var _horsemodid:int;
        private var _horseweaponmodid:int;
        private var _avatarid:int;
        private var _arrowid:int;
        private var _hiddenweaponmodid:int;
        private var _equips:Vector.<EquipInfo>;

        public function PlayerAppearanceInfo()
        {
            this._equips = new Vector.<EquipInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._sex);
            writeInt(this._clothingmodid);
            writeInt(this._weaponmodid);
            writeByte(this._weaponStreng);
            writeInt(this._horsemodid);
            writeInt(this._horseweaponmodid);
            writeInt(this._avatarid);
            writeInt(this._arrowid);
            writeShort(this._equips.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._equips.length)
            {
                
                writeBean(this._equips[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._sex = readByte();
            this._clothingmodid = readInt();
            this._weaponmodid = readInt();
            this._weaponStreng = readByte();
            this._horsemodid = readInt();
            this._horseweaponmodid = readInt();
            this._avatarid = readInt();
            this._arrowid = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._equips[_loc_2] = readBean(EquipInfo) as EquipInfo;
                _loc_2++;
            }
            return true;
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

        public function get clothingmodid() : int
        {
            return this._clothingmodid;
        }// end function

        public function set clothingmodid(param1:int) : void
        {
            this._clothingmodid = param1;
            return;
        }// end function

        public function get weaponmodid() : int
        {
            return this._weaponmodid;
        }// end function

        public function set weaponmodid(param1:int) : void
        {
            this._weaponmodid = param1;
            return;
        }// end function

        public function get weaponStreng() : int
        {
            return this._weaponStreng;
        }// end function

        public function set weaponStreng(param1:int) : void
        {
            this._weaponStreng = param1;
            return;
        }// end function

        public function get horsemodid() : int
        {
            return this._horsemodid;
        }// end function

        public function set horsemodid(param1:int) : void
        {
            this._horsemodid = param1;
            return;
        }// end function

        public function get horseweaponmodid() : int
        {
            return this._horseweaponmodid;
        }// end function

        public function set horseweaponmodid(param1:int) : void
        {
            this._horseweaponmodid = param1;
            return;
        }// end function

        public function get avatarid() : int
        {
            return this._avatarid;
        }// end function

        public function set avatarid(param1:int) : void
        {
            this._avatarid = param1;
            return;
        }// end function

        public function get arrowid() : int
        {
            return this._arrowid;
        }// end function

        public function set arrowid(param1:int) : void
        {
            this._arrowid = param1;
            return;
        }// end function

        public function get hiddenweaponmodid() : int
        {
            return this._hiddenweaponmodid;
        }// end function

        public function set hiddenweaponmodid(param1:int) : void
        {
            this._hiddenweaponmodid = param1;
            return;
        }// end function

        public function get equips() : Vector.<EquipInfo>
        {
            return this._equips;
        }// end function

        public function set equips(param1:Vector.<EquipInfo>) : void
        {
            this._equips = param1;
            return;
        }// end function

    }
}
