package com.game.horse.bean
{
    import __AS3__.vec.*;
    import com.game.equip.bean.*;
    import net.*;

    public class CSHorseInfo extends Bean
    {
        private var _layer:int;
        private var _curlayer:int;
        private var _status:int;
        private var _skillinfolist:Vector.<CSHorseSkillInfo>;
        private var _horseequipinfo:Vector.<EquipInfo>;
        private var _dayblessvalue:int;
        private var _hisblessvalue:int;
        private var _dayupnum:int;
        private var _hisupnum:int;
        private var _boxnum:int;
        private var _boxcdtime:int;
        private var _cdtimeyuanbao:int;
        private var _potential:int;
        private var _mixingbone:int;
        private var _horseexp:int;

        public function CSHorseInfo()
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
            writeInt(this._dayblessvalue);
            writeInt(this._hisblessvalue);
            writeShort(this._dayupnum);
            writeShort(this._hisupnum);
            writeByte(this._boxnum);
            writeInt(this._boxcdtime);
            writeInt(this._cdtimeyuanbao);
            writeInt(this._potential);
            writeShort(this._mixingbone);
            writeInt(this._horseexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._layer = readShort();
            this._curlayer = readShort();
            this._status = readByte();
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
            this._dayblessvalue = readInt();
            this._hisblessvalue = readInt();
            this._dayupnum = readShort();
            this._hisupnum = readShort();
            this._boxnum = readByte();
            this._boxcdtime = readInt();
            this._cdtimeyuanbao = readInt();
            this._potential = readInt();
            this._mixingbone = readShort();
            this._horseexp = readInt();
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

        public function get dayblessvalue() : int
        {
            return this._dayblessvalue;
        }// end function

        public function set dayblessvalue(param1:int) : void
        {
            this._dayblessvalue = param1;
            return;
        }// end function

        public function get hisblessvalue() : int
        {
            return this._hisblessvalue;
        }// end function

        public function set hisblessvalue(param1:int) : void
        {
            this._hisblessvalue = param1;
            return;
        }// end function

        public function get dayupnum() : int
        {
            return this._dayupnum;
        }// end function

        public function set dayupnum(param1:int) : void
        {
            this._dayupnum = param1;
            return;
        }// end function

        public function get hisupnum() : int
        {
            return this._hisupnum;
        }// end function

        public function set hisupnum(param1:int) : void
        {
            this._hisupnum = param1;
            return;
        }// end function

        public function get boxnum() : int
        {
            return this._boxnum;
        }// end function

        public function set boxnum(param1:int) : void
        {
            this._boxnum = param1;
            return;
        }// end function

        public function get boxcdtime() : int
        {
            return this._boxcdtime;
        }// end function

        public function set boxcdtime(param1:int) : void
        {
            this._boxcdtime = param1;
            return;
        }// end function

        public function get cdtimeyuanbao() : int
        {
            return this._cdtimeyuanbao;
        }// end function

        public function set cdtimeyuanbao(param1:int) : void
        {
            this._cdtimeyuanbao = param1;
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

        public function get horseexp() : int
        {
            return this._horseexp;
        }// end function

        public function set horseexp(param1:int) : void
        {
            this._horseexp = param1;
            return;
        }// end function

    }
}
