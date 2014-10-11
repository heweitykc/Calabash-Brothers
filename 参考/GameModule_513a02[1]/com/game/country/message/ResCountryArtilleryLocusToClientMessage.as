package com.game.country.message
{
    import com.game.utils.*;
    import net.*;

    public class ResCountryArtilleryLocusToClientMessage extends Message
    {
        private var _type:int;
        private var _endx:int;
        private var _endy:int;
        private var _playerid:long;

        public function ResCountryArtilleryLocusToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._endx);
            writeInt(this._endy);
            writeLong(this._playerid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._endx = readInt();
            this._endy = readInt();
            this._playerid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 146106;
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

        public function get endx() : int
        {
            return this._endx;
        }// end function

        public function set endx(param1:int) : void
        {
            this._endx = param1;
            return;
        }// end function

        public function get endy() : int
        {
            return this._endy;
        }// end function

        public function set endy(param1:int) : void
        {
            this._endy = param1;
            return;
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

    }
}
