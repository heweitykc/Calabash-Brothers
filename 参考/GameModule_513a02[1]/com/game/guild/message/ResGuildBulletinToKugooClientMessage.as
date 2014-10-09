package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGuildBulletinToKugooClientMessage extends Message
    {
        private var _guildId:long;
        private var _userId:long;
        private var _guildBulletin:String;

        public function ResGuildBulletinToKugooClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.guildId);
            writeLong(this.userId);
            writeString(this.guildBulletin);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.guildId = readLong();
            this.userId = readLong();
            this.guildBulletin = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529124;
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

        public function get userId() : long
        {
            return this._userId;
        }// end function

        public function set userId(param1:long) : void
        {
            this._userId = param1;
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
