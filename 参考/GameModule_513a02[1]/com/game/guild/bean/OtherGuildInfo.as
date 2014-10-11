package com.game.guild.bean
{
    import net.*;

    public class OtherGuildInfo extends Bean
    {
        private var _guildBanner:BannerInfo;
        private var _guildPowerLevel:int;

        public function OtherGuildInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._guildBanner);
            writeByte(this._guildPowerLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildBanner = readBean(BannerInfo) as BannerInfo;
            this._guildPowerLevel = readByte();
            return true;
        }// end function

        public function get guildBanner() : BannerInfo
        {
            return this._guildBanner;
        }// end function

        public function set guildBanner(param1:BannerInfo) : void
        {
            this._guildBanner = param1;
            return;
        }// end function

        public function get guildPowerLevel() : int
        {
            return this._guildPowerLevel;
        }// end function

        public function set guildPowerLevel(param1:int) : void
        {
            this._guildPowerLevel = param1;
            return;
        }// end function

    }
}
