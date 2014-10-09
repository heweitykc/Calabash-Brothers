package com.game.horse.bean
{
    import __AS3__.vec.*;
    import com.game.equip.bean.*;
    import net.*;

    public class OthersHorseInfo extends Bean
    {
        private var _layer:int;
        private var _curlayer:int;
        private var _status:int;
        private var _level:int;
        private var _skillinfolist:Vector.<CSHorseSkillInfo>;
        private var _horseequipinfo:Vector.<EquipInfo>;
        private var _potential:int;
        private var _mixingbone:int;

        public function OthersHorseInfo()
        {
            this._skillinfolist = new Vector.<CSHorseSkillInfo>;
            this._horseequipinfo = new Vector.<EquipInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._layer);
            writeShort(this._curlayer);
            writeByte(this._status);
            writeShort(this._level);
            writeShort(this._skillinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._skillinfolist.length)
            {
                
                writeBean(this._skillinfolist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._horseequipinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._horseequipinfo.length)
            {
                
                writeBean(this._horseequipinfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._potential);
            writeShort(this._mixingbone);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._layer = readShort();
            this._curlayer = readShort();
            this._status = readByte();
            this._level = readShort();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skillinfolist[_loc_2] = readBean(CSHorseSkillInfo) as CSHorseSkillInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._horseequipinfo[_loc_2] = readBean(EquipInfo) as EquipInfo;
                _loc_2++;
            }
            this._potential = readInt();
            this._mixingbone = readShort();
            return true;
        }// end function

        public function get layer() : int
        {
            return this._layer;
        }// end function

        public function set layer(param1:int) : void
        {
            this._layer = param1;
            return;
        }// end function

        public function get curlayer() : int
        {
            return this._curlayer;
        }// end function

        public function set curlayer(param1:int) : void
        {
            this._curlayer = param1;
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
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

        public function get skillinfolist() : Vector.<CSHorseSkillInfo>
        {
            return this._skillinfolist;
        }// end function

        public function set skillinfolist(param1:Vector.<CSHorseSkillInfo>) : void
        {
            this._skillinfolist = param1;
            return;
        }// end function

        public function get horseequipinfo() : Vector.<EquipInfo>
        {
            return this._horseequipinfo;
        }// end function

        public function set horseequipinfo(param1:Vector.<EquipInfo>) : void
        {
            this._horseequipinfo = param1;
            return;
        }// end function

        public function get potential() : int
        {
            return this._potential;
        }// end function

        public function set potential(param1:int) : void
        {
            this._potential = param1;
            return;
        }// end function

        public function get mixingbone() : int
        {
            return this._mixingbone;
        }// end function

        public function set mixingbone(param1:int) : void
        {
            this._mixingbone = param1;
            return;
        }// end function

    }
}
