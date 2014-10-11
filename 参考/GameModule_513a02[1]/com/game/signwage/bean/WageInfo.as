package com.game.signwage.bean
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class WageInfo extends Bean
    {
        private var _svrstarttime:String;
        private var _curmonth:int;
        private var _daytime:int;
        private var _monthtime:int;
        private var _curstatus:int;
        private var _oldstatus:int;
        private var _curwage:int;
        private var _oldwage:int;
        private var _ernie:Vector.<int>;
        private var _fruitRewardinfo:Vector.<FruitRewardinfo>;

        public function WageInfo()
        {
            this._ernie = new Vector.<int>;
            this._fruitRewardinfo = new Vector.<FruitRewardinfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeString(this._svrstarttime);
            writeInt(this._curmonth);
            writeInt(this._daytime);
            writeInt(this._monthtime);
            writeByte(this._curstatus);
            writeByte(this._oldstatus);
            writeInt(this._curwage);
            writeInt(this._oldwage);
            writeShort(this._ernie.length);
            _loc_1 = 0;
            while (_loc_1 < this._ernie.length)
            {
                
                writeInt(this._ernie[_loc_1]);
                _loc_1++;
            }
            writeShort(this._fruitRewardinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._fruitRewardinfo.length)
            {
                
                writeBean(this._fruitRewardinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._svrstarttime = readString();
            this._curmonth = readInt();
            this._daytime = readInt();
            this._monthtime = readInt();
            this._curstatus = readByte();
            this._oldstatus = readByte();
            this._curwage = readInt();
            this._oldwage = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._ernie[_loc_2] = readInt();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._fruitRewardinfo[_loc_2] = readBean(FruitRewardinfo) as FruitRewardinfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get svrstarttime() : String
        {
            return this._svrstarttime;
        }// end function

        public function set svrstarttime(param1:String) : void
        {
            this._svrstarttime = param1;
            return;
        }// end function

        public function get curmonth() : int
        {
            return this._curmonth;
        }// end function

        public function set curmonth(param1:int) : void
        {
            this._curmonth = param1;
            return;
        }// end function

        public function get daytime() : int
        {
            return this._daytime;
        }// end function

        public function set daytime(param1:int) : void
        {
            this._daytime = param1;
            return;
        }// end function

        public function get monthtime() : int
        {
            return this._monthtime;
        }// end function

        public function set monthtime(param1:int) : void
        {
            this._monthtime = param1;
            return;
        }// end function

        public function get curstatus() : int
        {
            return this._curstatus;
        }// end function

        public function set curstatus(param1:int) : void
        {
            this._curstatus = param1;
            return;
        }// end function

        public function get oldstatus() : int
        {
            return this._oldstatus;
        }// end function

        public function set oldstatus(param1:int) : void
        {
            this._oldstatus = param1;
            return;
        }// end function

        public function get curwage() : int
        {
            return this._curwage;
        }// end function

        public function set curwage(param1:int) : void
        {
            this._curwage = param1;
            return;
        }// end function

        public function get oldwage() : int
        {
            return this._oldwage;
        }// end function

        public function set oldwage(param1:int) : void
        {
            this._oldwage = param1;
            return;
        }// end function

        public function get ernie() : Vector.<int>
        {
            return this._ernie;
        }// end function

        public function set ernie(param1:Vector.<int>) : void
        {
            this._ernie = param1;
            return;
        }// end function

        public function get fruitRewardinfo() : Vector.<FruitRewardinfo>
        {
            return this._fruitRewardinfo;
        }// end function

        public function set fruitRewardinfo(param1:Vector.<FruitRewardinfo>) : void
        {
            this._fruitRewardinfo = param1;
            return;
        }// end function

    }
}
