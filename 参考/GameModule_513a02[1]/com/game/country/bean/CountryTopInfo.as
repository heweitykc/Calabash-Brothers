package com.game.country.bean
{
    import com.game.utils.*;
    import net.*;

    public class CountryTopInfo extends Bean
    {
        private var _playername:String;
        private var _guildname:String;
        private var _playerid:long;
        private var _playerlevel:int;
        private var _kill:int;
        private var _death:int;
        private var _hurt:int;
        private var _beenhurt:int;
        private var _ranking:int;
        private var _job:int;
        private var _exp:int;
        private var _conKill:int;
        private var _maxConKill:int;

        public function CountryTopInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeString(this._guildname);
            writeLong(this._playerid);
            writeInt(this._playerlevel);
            writeInt(this._kill);
            writeInt(this._death);
            writeInt(this._hurt);
            writeInt(this._beenhurt);
            writeInt(this._ranking);
            writeByte(this._job);
            writeInt(this._exp);
            writeInt(this._conKill);
            writeInt(this._maxConKill);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._guildname = readString();
            this._playerid = readLong();
            this._playerlevel = readInt();
            this._kill = readInt();
            this._death = readInt();
            this._hurt = readInt();
            this._beenhurt = readInt();
            this._ranking = readInt();
            this._job = readByte();
            this._exp = readInt();
            this._conKill = readInt();
            this._maxConKill = readInt();
            return true;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get guildname() : String
        {
            return this._guildname;
        }// end function

        public function set guildname(param1:String) : void
        {
            this._guildname = param1;
            return;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
        }// end function

        public function get playerlevel() : int
        {
            return this._playerlevel;
        }// end function

        public function set playerlevel(param1:int) : void
        {
            this._playerlevel = param1;
            return;
        }// end function

        public function get kill() : int
        {
            return this._kill;
        }// end function

        public function set kill(param1:int) : void
        {
            this._kill = param1;
            return;
        }// end function

        public function get death() : int
        {
            return this._death;
        }// end function

        public function set death(param1:int) : void
        {
            this._death = param1;
            return;
        }// end function

        public function get hurt() : int
        {
            return this._hurt;
        }// end function

        public function set hurt(param1:int) : void
        {
            this._hurt = param1;
            return;
        }// end function

        public function get beenhurt() : int
        {
            return this._beenhurt;
        }// end function

        public function set beenhurt(param1:int) : void
        {
            this._beenhurt = param1;
            return;
        }// end function

        public function get ranking() : int
        {
            return this._ranking;
        }// end function

        public function set ranking(param1:int) : void
        {
            this._ranking = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get conKill() : int
        {
            return this._conKill;
        }// end function

        public function set conKill(param1:int) : void
        {
            this._conKill = param1;
            return;
        }// end function

        public function get maxConKill() : int
        {
            return this._maxConKill;
        }// end function

        public function set maxConKill(param1:int) : void
        {
            this._maxConKill = param1;
            return;
        }// end function

    }
}
