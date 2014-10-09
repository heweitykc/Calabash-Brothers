package com.game.guildflag.bean
{
    import com.game.utils.*;
    import net.*;

    public class GuildFlagInfo extends Bean
    {
        private var _guildid:long;
        private var _guildname:String;
        private var _guildflaglevel:int;
        private var _mapmodelid:int;
        private var _hppercentage:int;
        private var _guildflagid:int;
        private var _guildheadid:long;
        private var _guildheadname:String;

        public function GuildFlagInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildid);
            writeString(this._guildname);
            writeInt(this._guildflaglevel);
            writeInt(this._mapmodelid);
            writeInt(this._hppercentage);
            writeInt(this._guildflagid);
            writeLong(this._guildheadid);
            writeString(this._guildheadname);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildid = readLong();
            this._guildname = readString();
            this._guildflaglevel = readInt();
            this._mapmodelid = readInt();
            this._hppercentage = readInt();
            this._guildflagid = readInt();
            this._guildheadid = readLong();
            this._guildheadname = readString();
            return true;
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

        public function get guildname() : String
        {
            return this._guildname;
        }// end function

        public function set guildname(param1:String) : void
        {
            this._guildname = param1;
            return;
        }// end function

        public function get guildflaglevel() : int
        {
            return this._guildflaglevel;
        }// end function

        public function set guildflaglevel(param1:int) : void
        {
            this._guildflaglevel = param1;
            return;
        }// end function

        public function get mapmodelid() : int
        {
            return this._mapmodelid;
        }// end function

        public function set mapmodelid(param1:int) : void
        {
            this._mapmodelid = param1;
            return;
        }// end function

        public function get hppercentage() : int
        {
            return this._hppercentage;
        }// end function

        public function set hppercentage(param1:int) : void
        {
            this._hppercentage = param1;
            return;
        }// end function

        public function get guildflagid() : int
        {
            return this._guildflagid;
        }// end function

        public function set guildflagid(param1:int) : void
        {
            this._guildflagid = param1;
            return;
        }// end function

        public function get guildheadid() : long
        {
            return this._guildheadid;
        }// end function

        public function set guildheadid(param1:long) : void
        {
            this._guildheadid = param1;
            return;
        }// end function

        public function get guildheadname() : String
        {
            return this._guildheadname;
        }// end function

        public function set guildheadname(param1:String) : void
        {
            this._guildheadname = param1;
            return;
        }// end function

    }
}
