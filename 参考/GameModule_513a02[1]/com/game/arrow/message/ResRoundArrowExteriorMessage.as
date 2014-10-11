package com.game.arrow.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRoundArrowExteriorMessage extends Message
    {
        private var _playerid:long;
        private var _arrowid:int;

        public function ResRoundArrowExteriorMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeInt(this._arrowid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._arrowid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 151106;
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

        public function get arrowid() : int
        {
            return this._arrowid;
        }// end function

        public function set arrowid(param1:int) : void
        {
            this._arrowid = param1;
            return;
        }// end function

    }
}
