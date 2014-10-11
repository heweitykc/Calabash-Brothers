package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class BannerInfo extends Bean
    {
        private var _guildId:long;
        private var _guildName:String;
        private var _guildBanner:String;
        private var _bangZhuName:String;
        private var _bannerIcon:int;
        private var _bannerLevel:int;
        private var _createTime:int;

        public function BannerInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeString(this._guildName);
            writeString(this._guildBanner);
            writeString(this._bangZhuName);
            writeInt(this._bannerIcon);
            writeByte(this._bannerLevel);
            writeInt(this._createTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._guildName = readString();
            this._guildBanner = readString();
            this._bangZhuName = readString();
            this._bannerIcon = readInt();
            this._bannerLevel = readByte();
            this._createTime = readInt();
            return true;
        }// end function

        public function get guildId() : long
        {
            return this._guildId;
        }// end function

        public function set guildId(param1:long) : void
        {
            this._guildId = param1;
            return;
        }// end function

        public function get guildName() : String
        {
            return this._guildName;
        }// end function

        public function set guildName(param1:String) : void
        {
            this._guildName = param1;
            return;
        }// end function

        public function get guildBanner() : String
        {
            return this._guildBanner;
        }// end function

        public function set guildBanner(param1:String) : void
        {
            this._guildBanner = param1;
            return;
        }// end function

        public function get bangZhuName() : String
        {
            return this._bangZhuName;
        }// end function

        public function set bangZhuName(param1:String) : void
        {
            this._bangZhuName = param1;
            return;
        }// end function

        public function get bannerIcon() : int
        {
            return this._bannerIcon;
        }// end function

        public function set bannerIcon(param1:int) : void
        {
            this._bannerIcon = param1;
            return;
        }// end function

        public function get bannerLevel() : int
        {
            return this._bannerLevel;
        }// end function

        public function set bannerLevel(param1:int) : void
        {
            this._bannerLevel = param1;
            return;
        }// end function

        public function get createTime() : int
        {
            return this._createTime;
        }// end function

        public function set createTime(param1:int) : void
        {
            this._createTime = param1;
            return;
        }// end function

    }
}
