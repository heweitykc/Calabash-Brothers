package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildChangeBannerIconToServerMessage extends Message
    {
        private var _guildId:long;
        private var _bannerIcon:int;

        public function ReqGuildChangeBannerIconToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeInt(this._bannerIcon);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._bannerIcon = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121215;
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

        public function get bannerIcon() : int
        {
            return this._bannerIcon;
        }// end function

        public function set bannerIcon(param1:int) : void
        {
            this._bannerIcon = param1;
            return;
        }// end function

    }
}
