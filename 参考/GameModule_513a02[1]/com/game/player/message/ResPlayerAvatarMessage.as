package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerAvatarMessage extends Message
    {
        private var _playerid:long;
        private var _avatarid:int;

        public function ResPlayerAvatarMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._avatarid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._avatarid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103124;
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

        public function get avatarid() : int
        {
            return this._avatarid;
        }// end function

        public function set avatarid(param1:int) : void
        {
            this._avatarid = param1;
            return;
        }// end function

    }
}
