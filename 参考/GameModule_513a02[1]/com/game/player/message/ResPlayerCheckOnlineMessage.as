package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPlayerCheckOnlineMessage extends Message
    {
        private var _othersid:long;
        private var _othersname:String;
        private var _x:int;
        private var _y:int;
        private var _type:int;
        private var _isonline:int;

        public function ResPlayerCheckOnlineMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._othersid);
            writeString(this._othersname);
            writeShort(this._x);
            writeShort(this._y);
            writeByte(this._type);
            writeByte(this._isonline);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._othersid = readLong();
            this._othersname = readString();
            this._x = readShort();
            this._y = readShort();
            this._type = readByte();
            this._isonline = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103125;
        }// end function

        public function get othersid() : long
        {
            return this._othersid;
        }// end function

        public function set othersid(param1:long) : void
        {
            this._othersid = param1;
            return;
        }// end function

        public function get othersname() : String
        {
            return this._othersname;
        }// end function

        public function set othersname(param1:String) : void
        {
            this._othersname = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
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

        public function get isonline() : int
        {
            return this._isonline;
        }// end function

        public function set isonline(param1:int) : void
        {
            this._isonline = param1;
            return;
        }// end function

    }
}
