package com.game.login.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRolesCreateReportToGateMessage extends Message
    {
        private var _serverId:int;
        private var _createServerId:int;
        private var _userId:String;
        private var _playerId:long;
        private var _mapId:int;
        private var _playername:String;

        public function ResRolesCreateReportToGateMessage()
        {
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get mapId() : int
        {
            return this._mapId;
        }// end function

        public function set mapId(param1:int) : void
        {
            this._mapId = param1;
            return;
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

        public function get createServerId() : int
        {
            return this._createServerId;
        }// end function

        public function set createServerId(param1:int) : void
        {
            this._createServerId = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.serverId);
            writeInt(this.createServerId);
            writeString(this.userId);
            writeLong(this.playerId);
            writeInt(this.mapId);
            writeString(this.playername);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.serverId = readInt();
            this.createServerId = readInt();
            this.userId = readString();
            this.playerId = readLong();
            this.mapId = readInt();
            this.playername = readString();
            return true;
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

        override public function getId() : int
        {
            return 100314;
        }// end function

    }
}
