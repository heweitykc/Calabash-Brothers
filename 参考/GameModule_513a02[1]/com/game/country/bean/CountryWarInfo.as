package com.game.country.bean
{
    import com.game.utils.*;
    import net.*;

    public class CountryWarInfo extends Bean
    {
        private var _holderguildid:long;
        private var _holderid:long;
        private var _holdername:String;
        private var _mx:int;
        private var _my:int;
        private var _holdertime:int;
        private var _warendtime:int;
        private var _process:String;
        private var _blood:String;

        public function CountryWarInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._holderguildid);
            writeLong(this._holderid);
            writeString(this._holdername);
            writeShort(this._mx);
            writeShort(this._my);
            writeInt(this._holdertime);
            writeInt(this._warendtime);
            writeString(this._process);
            writeString(this._blood);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._holderguildid = readLong();
            this._holderid = readLong();
            this._holdername = readString();
            this._mx = readShort();
            this._my = readShort();
            this._holdertime = readInt();
            this._warendtime = readInt();
            this._process = readString();
            this._blood = readString();
            return true;
        }// end function

        public function get holderguildid() : long
        {
            return this._holderguildid;
        }// end function

        public function set holderguildid(param1:long) : void
        {
            this._holderguildid = param1;
            return;
        }// end function

        public function get holderid() : long
        {
            return this._holderid;
        }// end function

        public function set holderid(param1:long) : void
        {
            this._holderid = param1;
            return;
        }// end function

        public function get holdername() : String
        {
            return this._holdername;
        }// end function

        public function set holdername(param1:String) : void
        {
            this._holdername = param1;
            return;
        }// end function

        public function get mx() : int
        {
            return this._mx;
        }// end function

        public function set mx(param1:int) : void
        {
            this._mx = param1;
            return;
        }// end function

        public function get my() : int
        {
            return this._my;
        }// end function

        public function set my(param1:int) : void
        {
            this._my = param1;
            return;
        }// end function

        public function get holdertime() : int
        {
            return this._holdertime;
        }// end function

        public function set holdertime(param1:int) : void
        {
            this._holdertime = param1;
            return;
        }// end function

        public function get warendtime() : int
        {
            return this._warendtime;
        }// end function

        public function set warendtime(param1:int) : void
        {
            this._warendtime = param1;
            return;
        }// end function

        public function get process() : String
        {
            return this._process;
        }// end function

        public function set process(param1:String) : void
        {
            this._process = param1;
            return;
        }// end function

        public function get blood() : String
        {
            return this._blood;
        }// end function

        public function set blood(param1:String) : void
        {
            this._blood = param1;
            return;
        }// end function

    }
}
