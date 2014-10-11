package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqToleaveGameMessage extends Message
    {
        private var _playerid:long;
        private var _type:int;

        public function ReqToleaveGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118206;
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
