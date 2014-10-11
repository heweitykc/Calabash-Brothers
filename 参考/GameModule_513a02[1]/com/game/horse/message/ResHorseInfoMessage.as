package com.game.horse.message
{
    import com.game.horse.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResHorseInfoMessage extends Message
    {
        private var _playerid:long;
        private var _horseinfo:CSHorseInfo;

        public function ResHorseInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerid);
            writeBean(this._horseinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerid = readLong();
            this._horseinfo = readBean(CSHorseInfo) as CSHorseInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 126101;
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

        public function get horseinfo() : CSHorseInfo
        {
            return this._horseinfo;
        }// end function

        public function set horseinfo(param1:CSHorseInfo) : void
        {
            this._horseinfo = param1;
            return;
        }// end function

    }
}
