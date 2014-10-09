package com.game.guild.message
{
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildAloneGuildInfoToClientMessage extends Message
    {
        private var _notifyType:int;
        private var _guildInfo:GuildInfo;

        public function ResGuildAloneGuildInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._notifyType);
            writeBean(this._guildInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifyType = readByte();
            this._guildInfo = readBean(GuildInfo) as GuildInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 121390;
        }// end function

        public function get notifyType() : int
        {
            return this._notifyType;
        }// end function

        public function set notifyType(param1:int) : void
        {
            this._notifyType = param1;
            return;
        }// end function

        public function get guildInfo() : GuildInfo
        {
            return this._guildInfo;
        }// end function

        public function set guildInfo(param1:GuildInfo) : void
        {
            this._guildInfo = param1;
            return;
        }// end function

    }
}
