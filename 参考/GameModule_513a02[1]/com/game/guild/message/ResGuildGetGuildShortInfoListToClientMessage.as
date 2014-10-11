package com.game.guild.message
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildGetGuildShortInfoListToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _guildShortInfoList:Vector.<GuildShortInfo>;

        public function ResGuildGetGuildShortInfoListToClientMessage()
        {
            this._guildShortInfoList = new Vector.<GuildShortInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._btErrorCode);
            writeShort(this._guildShortInfoList.length);
            _loc_1 = 0;
            while (_loc_1 < this._guildShortInfoList.length)
            {
                
                writeBean(this._guildShortInfoList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._btErrorCode = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._guildShortInfoList[_loc_1] = readBean(GuildShortInfo) as GuildShortInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 121122;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get guildShortInfoList() : Vector.<GuildShortInfo>
        {
            return this._guildShortInfoList;
        }// end function

        public function set guildShortInfoList(param1:Vector.<GuildShortInfo>) : void
        {
            this._guildShortInfoList = param1;
            return;
        }// end function

    }
}
