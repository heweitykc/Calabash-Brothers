package com.game.friend.message
{
    import com.game.friend.bean.*;
    import net.*;

    public class ResRelationIconTipToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _btListType:int;
        private var _friendModeInfo:FriendModeInfo;

        public function ResRelationIconTipToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeByte(this._btListType);
            writeBean(this._friendModeInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._btListType = readByte();
            this._friendModeInfo = readBean(FriendModeInfo) as FriendModeInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 119104;
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

        public function get btListType() : int
        {
            return this._btListType;
        }// end function

        public function set btListType(param1:int) : void
        {
            this._btListType = param1;
            return;
        }// end function

        public function get friendModeInfo() : FriendModeInfo
        {
            return this._friendModeInfo;
        }// end function

        public function set friendModeInfo(param1:FriendModeInfo) : void
        {
            this._friendModeInfo = param1;
            return;
        }// end function

    }
}
