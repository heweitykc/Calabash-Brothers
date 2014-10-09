package com.game.friend.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRelationDeleteToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _btListType:int;
        private var _operateplayerId:long;

        public function ResRelationDeleteToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeByte(this._btListType);
            writeLong(this._operateplayerId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._btListType = readByte();
            this._operateplayerId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 119103;
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

        public function get operateplayerId() : long
        {
            return this._operateplayerId;
        }// end function

        public function set operateplayerId(param1:long) : void
        {
            this._operateplayerId = param1;
            return;
        }// end function

    }
}
