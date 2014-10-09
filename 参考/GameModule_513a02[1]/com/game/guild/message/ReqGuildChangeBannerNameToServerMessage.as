﻿package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildChangeBannerNameToServerMessage extends Message
    {
        private var _guildId:long;
        private var _bannerName:String;

        public function ReqGuildChangeBannerNameToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeString(this._bannerName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._bannerName = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121216;
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

        public function get bannerName() : String
        {
            return this._bannerName;
        }// end function

        public function set bannerName(param1:String) : void
        {
            this._bannerName = param1;
            return;
        }// end function

    }
}
