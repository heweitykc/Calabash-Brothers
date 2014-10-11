package com.game.signwage.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class SignInfo extends Bean
    {
        private var _year:int;
        private var _month:int;
        private var _day:int;
        private var _freshDate:int;
        private var _daylist:Vector.<int>;
        private var _award:Vector.<int>;

        public function SignInfo()
        {
            this._daylist = new Vector.<int>;
            this._award = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._year);
            writeInt(this._month);
            writeInt(this._day);
            writeInt(this._freshDate);
            writeShort(this._daylist.length);
            _loc_1 = 0;
            while (_loc_1 < this._daylist.length)
            {
                
                writeInt(this._daylist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._award.length);
            _loc_1 = 0;
            while (_loc_1 < this._award.length)
            {
                
                writeInt(this._award[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._year = readInt();
            this._month = readInt();
            this._day = readInt();
            this._freshDate = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._daylist[_loc_2] = readInt();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._award[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

        public function get year() : int
        {
            return this._year;
        }// end function

        public function set year(param1:int) : void
        {
            this._year = param1;
            return;
        }// end function

        public function get month() : int
        {
            return this._month;
        }// end function

        public function set month(param1:int) : void
        {
            this._month = param1;
            return;
        }// end function

        public function get day() : int
        {
            return this._day;
        }// end function

        public function set day(param1:int) : void
        {
            this._day = param1;
            return;
        }// end function

        public function get daylist() : Vector.<int>
        {
            return this._daylist;
        }// end function

        public function set daylist(param1:Vector.<int>) : void
        {
            this._daylist = param1;
            return;
        }// end function

        public function get award() : Vector.<int>
        {
            return this._award;
        }// end function

        public function set award(param1:Vector.<int>) : void
        {
            this._award = param1;
            return;
        }// end function

        public function get freshDate() : int
        {
            return this._freshDate;
        }// end function

        public function set freshDate(param1:int) : void
        {
            this._freshDate = param1;
            return;
        }// end function

    }
}
