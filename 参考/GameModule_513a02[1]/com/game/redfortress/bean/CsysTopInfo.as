package com.game.redfortress.bean
{
    import com.game.utils.*;
    import net.*;

    public class CsysTopInfo extends Bean
    {
        private var _playername:String;
        private var _playerid:long;
        private var _kill:int;
        private var _death:int;
        private var _collectCount:int;
        private var _integral:int;
        private var _ranking:int;
        private var _exp:long;

        public function CsysTopInfo()
        {
            return;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set kill(param1:int) : void
        {
            this._kill = param1;
            return;
        }// end function

        public function get kill() : int
        {
            return this._kill;
        }// end function

        public function set death(param1:int) : void
        {
            this._death = param1;
            return;
        }// end function

        public function get death() : int
        {
            return this._death;
        }// end function

        public function set collectCount(param1:int) : void
        {
            this._collectCount = param1;
            return;
        }// end function

        public function get collectCount() : int
        {
            return this._collectCount;
        }// end function

        public function set integral(param1:int) : void
        {
            this._integral = param1;
            return;
        }// end function

        public function get integral() : int
        {
            return this._integral;
        }// end function

        public function set ranking(param1:int) : void
        {
            this._ranking = param1;
            return;
        }// end function

        public function get ranking() : int
        {
            return this._ranking;
        }// end function

        public function set exp(param1:long) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp() : long
        {
            return this._exp;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeLong(this._playerid);
            writeInt(this._kill);
            writeInt(this._death);
            writeInt(this._collectCount);
            writeInt(this._integral);
            writeInt(this._ranking);
            writeLong(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._playerid = readLong();
            this._kill = readInt();
            this._death = readInt();
            this._collectCount = readInt();
            this._integral = readInt();
            this._ranking = readInt();
            this._exp = readLong();
            return true;
        }// end function

    }
}
