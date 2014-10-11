package com.game.guild.message
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResGuildMemberListToKugooClientMessage extends Message
    {
        private var _guildId:long;
        private var _guildName:String;
        private var _guildBulletin:String;
        private var _memberList:Vector.<MemberInfoKugoo>;

        public function ResGuildMemberListToKugooClientMessage()
        {
            this._memberList = new Vector.<MemberInfoKugoo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.guildId);
            writeString(this.guildName);
            writeString(this.guildBulletin);
            writeShort(this.memberList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this.memberList.length)
            {
                
                writeBean(this.memberList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.guildId = readLong();
            this.guildName = readString();
            this.guildBulletin = readString();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.memberList[_loc_2] = readBean(MemberInfoKugoo) as MemberInfoKugoo;
                _loc_2++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 529122;
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

        public function get guildBulletin() : String
        {
            return this._guildBulletin;
        }// end function

        public function set guildBulletin(param1:String) : void
        {
            this._guildBulletin = param1;
            return;
        }// end function

        public function get memberList() : Vector.<MemberInfoKugoo>
        {
            return this._memberList;
        }// end function

        public function set memberList(param1:Vector.<MemberInfoKugoo>) : void
        {
            this._memberList = param1;
            return;
        }// end function

    }
}
