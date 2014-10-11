package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildImpeachToServerMessage extends Message
    {
        private var _guildId:long;

        public function ReqGuildImpeachToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529213;
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

    }
}
