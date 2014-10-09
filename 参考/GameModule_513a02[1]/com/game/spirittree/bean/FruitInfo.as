package com.game.spirittree.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class FruitInfo extends Bean
    {
        private var _fruitid:long;
        private var _type:int;
        private var _timeleft:int;
        private var _isarid:int;
        private var _groupidlist:Vector.<int>;
        private var _fruitrewardinfo:Vector.<FruitRewardinfo>;
        private var _yield:int;
        private var _hostid:long;
        private var _hostname:String;

        public function FruitInfo()
        {
            this._groupidlist = new Vector.<int>;
            this._fruitrewardinfo = new Vector.<FruitRewardinfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._fruitid);
            writeByte(this._type);
            writeInt(this._timeleft);
            writeByte(this._isarid);
            writeShort(this._groupidlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._groupidlist.length)
            {
                
                writeInt(this._groupidlist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._fruitrewardinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._fruitrewardinfo.length)
            {
                
                writeBean(this._fruitrewardinfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._yield);
            writeLong(this._hostid);
            writeString(this._hostname);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._fruitid = readLong();
            this._type = readByte();
            this._timeleft = readInt();
            this._isarid = readByte();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._groupidlist[_loc_2] = readInt();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._fruitrewardinfo[_loc_2] = readBean(FruitRewardinfo) as FruitRewardinfo;
                _loc_2++;
            }
            this._yield = readInt();
            this._hostid = readLong();
            this._hostname = readString();
            return true;
        }// end function

        public function get fruitid() : long
        {
            return this._fruitid;
        }// end function

        public function set fruitid(param1:long) : void
        {
            this._fruitid = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get timeleft() : int
        {
            return this._timeleft;
        }// end function

        public function set timeleft(param1:int) : void
        {
            this._timeleft = param1;
            return;
        }// end function

        public function get isarid() : int
        {
            return this._isarid;
        }// end function

        public function set isarid(param1:int) : void
        {
            this._isarid = param1;
            return;
        }// end function

        public function get groupidlist() : Vector.<int>
        {
            return this._groupidlist;
        }// end function

        public function set groupidlist(param1:Vector.<int>) : void
        {
            this._groupidlist = param1;
            return;
        }// end function

        public function get fruitrewardinfo() : Vector.<FruitRewardinfo>
        {
            return this._fruitrewardinfo;
        }// end function

        public function set fruitrewardinfo(param1:Vector.<FruitRewardinfo>) : void
        {
            this._fruitrewardinfo = param1;
            return;
        }// end function

        public function get yield() : int
        {
            return this._yield;
        }// end function

        public function set yield(param1:int) : void
        {
            this._yield = param1;
            return;
        }// end function

        public function get hostid() : long
        {
            return this._hostid;
        }// end function

        public function set hostid(param1:long) : void
        {
            this._hostid = param1;
            return;
        }// end function

        public function get hostname() : String
        {
            return this._hostname;
        }// end function

        public function set hostname(param1:String) : void
        {
            this._hostname = param1;
            return;
        }// end function

    }
}
