package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerGuildChangeMessage extends Message
    {
        private var _personId:long;
        private var _guildId:long;
        private var _guildName:String;

        public function ResPlayerGuildChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeLong(this._guildId);
            writeString(this._guildName);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._guildId = readLong();
            this._guildName = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121130;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
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
