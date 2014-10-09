package com.game.guild.message
{
    import com.game.guild.bean.*;
    import net.*;

    public class ResGuildAloneMemberInfoToClientMessage extends Message
    {
        private var _notifyType:int;
        private var _memberInfo:MemberInfo;

        public function ResGuildAloneMemberInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._notifyType);
            writeBean(this._memberInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._notifyType = readByte();
            this._memberInfo = readBean(MemberInfo) as MemberInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 121391;
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

        public function get memberInfo() : MemberInfo
        {
            return this._memberInfo;
        }// end function

        public function set memberInfo(param1:MemberInfo) : void
        {
            this._memberInfo = param1;
            return;
        }// end function

    }
}
