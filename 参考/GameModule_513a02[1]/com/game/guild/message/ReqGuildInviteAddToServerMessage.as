package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildInviteAddToServerMessage extends Message
    {
        private var _guildId:long;
        private var _userId:long;

        public function ReqGuildInviteAddToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeLong(this._userId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._userId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121205;
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

    }
}
