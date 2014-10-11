package com.game.chestbox.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class ChestBoxInfo extends Bean
    {
        private var _opennum:int;
        private var _autoopen:int;
        private var _inchooseidx:int;
        private var _outchooseidx:int;
        private var _ingridlist:Vector.<ChestGridInfo>;
        private var _outgridlist:Vector.<ChestGridInfo>;

        public function ChestBoxInfo()
        {
            this._ingridlist = new Vector.<ChestGridInfo>;
            this._outgridlist = new Vector.<ChestGridInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._opennum);
            writeInt(this._autoopen);
            writeInt(this._inchooseidx);
            writeInt(this._outchooseidx);
            writeShort(this._ingridlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._ingridlist.length)
            {
                
                writeBean(this._ingridlist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._outgridlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._outgridlist.length)
            {
                
                writeBean(this._outgridlist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._opennum = readInt();
            this._autoopen = readInt();
            this._inchooseidx = readInt();
            this._outchooseidx = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._ingridlist[_loc_2] = readBean(ChestGridInfo) as ChestGridInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._outgridlist[_loc_2] = readBean(ChestGridInfo) as ChestGridInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get opennum() : int
        {
            return this._opennum;
        }// end function

        public function set opennum(param1:int) : void
        {
            this._opennum = param1;
            return;
        }// end function

        public function get autoopen() : int
        {
            return this._autoopen;
        }// end function

        public function set autoopen(param1:int) : void
        {
            this._autoopen = param1;
            return;
        }// end function

        public function get inchooseidx() : int
        {
            return this._inchooseidx;
        }// end function

        public function set inchooseidx(param1:int) : void
        {
            this._inchooseidx = param1;
            return;
        }// end function

        public function get outchooseidx() : int
        {
            return this._outchooseidx;
        }// end function

        public function set outchooseidx(param1:int) : void
        {
            this._outchooseidx = param1;
            return;
        }// end function

        public function get ingridlist() : Vector.<ChestGridInfo>
        {
            return this._ingridlist;
        }// end function

        public function set ingridlist(param1:Vector.<ChestGridInfo>) : void
        {
            this._ingridlist = param1;
            return;
        }// end function

        public function get outgridlist() : Vector.<ChestGridInfo>
        {
            return this._outgridlist;
        }// end function

        public function set outgridlist(param1:Vector.<ChestGridInfo>) : void
        {
            this._outgridlist = param1;
            return;
        }// end function

    }
}
