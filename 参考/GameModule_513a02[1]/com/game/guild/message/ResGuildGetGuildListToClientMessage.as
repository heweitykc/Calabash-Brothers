package com.game.guild.message
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildGetGuildListToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _totalPage:int;
        private var _guildList:Vector.<GuildInfo>;

        public function ResGuildGetGuildListToClientMessage()
        {
            this._guildList = new Vector.<GuildInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._btErrorCode);
            writeByte(this._totalPage);
            writeShort(this._guildList.length);
            _loc_1 = 0;
            while (_loc_1 < this._guildList.length)
            {
                
                writeBean(this._guildList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._btErrorCode = readByte();
            this._totalPage = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._guildList[_loc_1] = readBean(GuildInfo) as GuildInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 121103;
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

        public function get totalPage() : int
        {
            return this._totalPage;
        }// end function

        public function set totalPage(param1:int) : void
        {
            this._totalPage = param1;
            return;
        }// end function

        public function get guildList() : Vector.<GuildInfo>
        {
            return this._guildList;
        }// end function

        public function set guildList(param1:Vector.<GuildInfo>) : void
        {
            this._guildList = param1;
            return;
        }// end function

    }
}
