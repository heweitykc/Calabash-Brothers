package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqGuildSubmitItemToServerMessage extends Message
    {
        private var _guildId:long;
        private var _itemType:int;
        private var _itemNum:int;

        public function ReqGuildSubmitItemToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._guildId);
            writeByte(this._itemType);
            writeInt(this._itemNum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._guildId = readLong();
            this._itemType = readByte();
            this._itemNum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121214;
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

        public function get itemType() : int
        {
            return this._itemType;
        }// end function

        public function set itemType(param1:int) : void
        {
            this._itemType = param1;
            return;
        }// end function

        public function get itemNum() : int
        {
            return this._itemNum;
        }// end function

        public function set itemNum(param1:int) : void
        {
            this._itemNum = param1;
            return;
        }// end function

    }
}
