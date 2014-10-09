package com.game.country.message
{
    import com.game.utils.*;
    import net.*;

    public class ResCountrySiegeUpYuxiToClientMessage extends Message
    {
        private var _playerid:long;
        private var _playername:String;

        public function ResCountrySiegeUpYuxiToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeString(this._playername);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._playername = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146102;
        }// end function

        public function get playerid() : long
        {
            return this._playerid;
        }// end function

        public function set playerid(param1:long) : void
        {
            this._playerid = param1;
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

    }
}
