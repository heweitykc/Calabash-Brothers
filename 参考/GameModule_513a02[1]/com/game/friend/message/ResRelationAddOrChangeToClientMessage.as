package com.game.friend.message
{
    import com.game.friend.bean.*;
    import net.*;

    public class ResRelationAddOrChangeToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _relationAddInfo:RelationInfo;

        public function ResRelationAddOrChangeToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeBean(this._relationAddInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._relationAddInfo = readBean(RelationInfo) as RelationInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 119102;
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

        public function get relationAddInfo() : RelationInfo
        {
            return this._relationAddInfo;
        }// end function

        public function set relationAddInfo(param1:RelationInfo) : void
        {
            this._relationAddInfo = param1;
            return;
        }// end function

    }
}
