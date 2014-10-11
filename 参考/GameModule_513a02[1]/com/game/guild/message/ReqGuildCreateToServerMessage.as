package com.game.guild.message
{
    import net.*;

    public class ReqGuildCreateToServerMessage extends Message
    {
        private var _guildName:String;
        private var _guildBanner:String;
        private var _guildBannerIcon:int;

        public function ReqGuildCreateToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._guildName);
            writeString(this._guildBanner);
            writeInt(this._guildBannerIcon);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildName = readString();
            this._guildBanner = readString();
            this._guildBannerIcon = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121201;
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

        public function get guildBannerIcon() : int
        {
            return this._guildBannerIcon;
        }// end function

        public function set guildBannerIcon(param1:int) : void
        {
            this._guildBannerIcon = param1;
            return;
        }// end function

    }
}
