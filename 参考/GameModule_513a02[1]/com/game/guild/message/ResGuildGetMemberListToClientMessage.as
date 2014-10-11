package com.game.guild.message
{
    import __AS3__.vec.*;
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildGetMemberListToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _memberList:Vector.<MemberInfo>;

        public function ResGuildGetMemberListToClientMessage()
        {
            this._memberList = new Vector.<MemberInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._btErrorCode);
            writeShort(this._memberList.length);
            _loc_1 = 0;
            while (_loc_1 < this._memberList.length)
            {
                
                writeBean(this._memberList[_loc_1]);
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
                
                this._memberList[_loc_1] = readBean(MemberInfo) as MemberInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 121106;
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

        public function get memberList() : Vector.<MemberInfo>
        {
            return this._memberList;
        }// end function

        public function set memberList(param1:Vector.<MemberInfo>) : void
        {
            this._memberList = param1;
            return;
        }// end function

    }
}
