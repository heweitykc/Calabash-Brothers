package com.game.dataserver.message
{
    import com.game.utils.*;
    import net.*;

    public class ResChangeServerMessage extends Message
    {
        private var _serverId:int;
        private var _web:String;
        private var _userId:String;
        private var _dataServerPlayerId:long;

        public function ResChangeServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._serverId);
            writeString(this._web);
            writeString(this._userId);
            writeLong(this._dataServerPlayerId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._serverId = readInt();
            this._web = readString();
            this._userId = readString();
            this._dataServerPlayerId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 203101;
        }// end function

        public function get serverId() : int
        {
            return this._serverId;
        }// end function

        public function set serverId(param1:int) : void
        {
            this._serverId = param1;
            return;
        }// end function

        public function get web() : String
        {
            return this._web;
        }// end function

        public function set web(param1:String) : void
        {
            this._web = param1;
            return;
        }// end function

        public function get userId() : String
        {
            return this._userId;
        }// end function

        public function set userId(param1:String) : void
        {
            this._userId = param1;
            return;
        }// end function

        public function get dataServerPlayerId() : long
        {
            return this._dataServerPlayerId;
        }// end function

        public function set dataServerPlayerId(param1:long) : void
        {
            this._dataServerPlayerId = param1;
            return;
        }// end function

    }
}
