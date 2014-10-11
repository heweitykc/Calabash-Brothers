package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildChangeBulletinToServerMessage extends Message
    {
        private var _guildId:long;
        private var _guildBulletin:String;

        public function ReqGuildChangeBulletinToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeString(this._guildBulletin);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._guildBulletin = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121213;
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

        public function get guildBulletin() : String
        {
            return this._guildBulletin;
        }// end function

        public function set guildBulletin(param1:String) : void
        {
            this._guildBulletin = param1;
            return;
        }// end function

    }
}
