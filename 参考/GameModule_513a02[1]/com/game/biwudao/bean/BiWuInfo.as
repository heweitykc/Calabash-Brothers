package com.game.biwudao.bean
{
    import com.game.utils.*;
    import net.*;

    public class BiWuInfo extends Bean
    {
        private var _areadouble:int;
        private var _availableexp:int;
        private var _availablezhenqi:int;
        private var _guildname:String;
        private var _guildid:long;
        private var _totalexp:int;
        private var _totalzhenqi:int;
        private var _totalrank:int;
        private var _totalBox:int;
        private var _surplustime:int;
        private var _flagcooldown:int;

        public function BiWuInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._areadouble);
            writeInt(this._availableexp);
            writeInt(this._availablezhenqi);
            writeString(this._guildname);
            writeLong(this._guildid);
            writeInt(this._totalexp);
            writeInt(this._totalzhenqi);
            writeInt(this._totalrank);
            writeInt(this._totalBox);
            writeInt(this._surplustime);
            writeInt(this._flagcooldown);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._areadouble = readInt();
            this._availableexp = readInt();
            this._availablezhenqi = readInt();
            this._guildname = readString();
            this._guildid = readLong();
            this._totalexp = readInt();
            this._totalzhenqi = readInt();
            this._totalrank = readInt();
            this._totalBox = readInt();
            this._surplustime = readInt();
            this._flagcooldown = readInt();
            return true;
        }// end function

        public function get areadouble() : int
        {
            return this._areadouble;
        }// end function

        public function set areadouble(param1:int) : void
        {
            this._areadouble = param1;
            return;
        }// end function

        public function get availableexp() : int
        {
            return this._availableexp;
        }// end function

        public function set availableexp(param1:int) : void
        {
            this._availableexp = param1;
            return;
        }// end function

        public function get availablezhenqi() : int
        {
            return this._availablezhenqi;
        }// end function

        public function set availablezhenqi(param1:int) : void
        {
            this._availablezhenqi = param1;
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

        public function get guildid() : long
        {
            return this._guildid;
        }// end function

        public function set guildid(param1:long) : void
        {
            this._guildid = param1;
            return;
        }// end function

        public function get totalexp() : int
        {
            return this._totalexp;
        }// end function

        public function set totalexp(param1:int) : void
        {
            this._totalexp = param1;
            return;
        }// end function

        public function get totalzhenqi() : int
        {
            return this._totalzhenqi;
        }// end function

        public function set totalzhenqi(param1:int) : void
        {
            this._totalzhenqi = param1;
            return;
        }// end function

        public function get totalrank() : int
        {
            return this._totalrank;
        }// end function

        public function set totalrank(param1:int) : void
        {
            this._totalrank = param1;
            return;
        }// end function

        public function get totalBox() : int
        {
            return this._totalBox;
        }// end function

        public function set totalBox(param1:int) : void
        {
            this._totalBox = param1;
            return;
        }// end function

        public function get surplustime() : int
        {
            return this._surplustime;
        }// end function

        public function set surplustime(param1:int) : void
        {
            this._surplustime = param1;
            return;
        }// end function

        public function get flagcooldown() : int
        {
            return this._flagcooldown;
        }// end function

        public function set flagcooldown(param1:int) : void
        {
            this._flagcooldown = param1;
            return;
        }// end function

    }
}
