package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGuildDeleteInfoRoundToClientMessage extends Message
    {
        private var _playerid:long;
        private var _guildid:long;

        public function ResGuildDeleteInfoRoundToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeLong(this._guildid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._guildid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121392;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
            return;
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

    }
}
