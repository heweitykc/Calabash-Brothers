package com.game.login.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRolesCreateReportToClientMessage extends Message
    {
        private var _playername:String;
        private var _playerId:long;

        public function ResRolesCreateReportToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeLong(this._playerId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._playerId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100111;
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

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

    }
}
