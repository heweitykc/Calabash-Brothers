package com.game.login.message
{
    import com.game.utils.*;
    import net.*;

    public class ResDelPlayerStatusToClientMessage extends Message
    {
        private var _playerId:long;
        private var _userId:String;
        private var _createServer:int;
        private var _type:int;

        public function ResDelPlayerStatusToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeString(this._userId);
            writeInt(this._createServer);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._userId = readString();
            this._createServer = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100109;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
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

        public function get createServer() : int
        {
            return this._createServer;
        }// end function

        public function set createServer(param1:int) : void
        {
            this._createServer = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
