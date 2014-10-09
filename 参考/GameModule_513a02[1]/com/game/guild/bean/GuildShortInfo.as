package com.game.guild.bean
{
    import com.game.utils.*;
    import net.*;

    public class GuildShortInfo extends Bean
    {
        private var _guildId:long;
        private var _guildName:String;

        public function GuildShortInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeString(this._guildName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._guildName = readString();
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

    }
}
