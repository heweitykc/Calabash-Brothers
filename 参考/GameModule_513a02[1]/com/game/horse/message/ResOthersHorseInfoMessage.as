package com.game.horse.message
{
    import com.game.horse.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResOthersHorseInfoMessage extends Message
    {
        private var _playerid:long;
        private var _info:OthersHorseInfo;

        public function ResOthersHorseInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeBean(this._info);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._info = readBean(OthersHorseInfo) as OthersHorseInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 126112;
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

        public function get info() : OthersHorseInfo
        {
            return this._info;
        }// end function

        public function set info(param1:OthersHorseInfo) : void
        {
            this._info = param1;
            return;
        }// end function

    }
}
