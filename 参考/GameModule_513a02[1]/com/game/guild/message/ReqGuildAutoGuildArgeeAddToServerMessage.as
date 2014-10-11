package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildAutoGuildArgeeAddToServerMessage extends Message
    {
        private var _guildId:long;
        private var _autoGuildAgreeAdd:int;

        public function ReqGuildAutoGuildArgeeAddToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeByte(this._autoGuildAgreeAdd);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._autoGuildAgreeAdd = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121212;
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

        public function get autoGuildAgreeAdd() : int
        {
            return this._autoGuildAgreeAdd;
        }// end function

        public function set autoGuildAgreeAdd(param1:int) : void
        {
            this._autoGuildAgreeAdd = param1;
            return;
        }// end function

    }
}
