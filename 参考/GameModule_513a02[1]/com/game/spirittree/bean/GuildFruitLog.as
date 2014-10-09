package com.game.spirittree.bean
{
    import com.game.utils.*;
    import net.*;

    public class GuildFruitLog extends Bean
    {
        private var _time:int;
        private var _groupid:int;
        private var _type:int;
        private var _exp:int;
        private var _otherid:long;
        private var _othername:String;
        private var _isonline:int;
        private var _itemmodelid:int;
        private var _itemnum:int;

        public function GuildFruitLog()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._time);
            writeInt(this._groupid);
            writeByte(this._type);
            writeInt(this._exp);
            writeLong(this._otherid);
            writeString(this._othername);
            writeByte(this._isonline);
            writeInt(this._itemmodelid);
            writeInt(this._itemnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._time = readInt();
            this._groupid = readInt();
            this._type = readByte();
            this._exp = readInt();
            this._otherid = readLong();
            this._othername = readString();
            this._isonline = readByte();
            this._itemmodelid = readInt();
            this._itemnum = readInt();
            return true;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get groupid() : int
        {
            return this._groupid;
        }// end function

        public function set groupid(param1:int) : void
        {
            this._groupid = param1;
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

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get otherid() : long
        {
            return this._otherid;
        }// end function

        public function set otherid(param1:long) : void
        {
            this._otherid = param1;
            return;
        }// end function

        public function get othername() : String
        {
            return this._othername;
        }// end function

        public function set othername(param1:String) : void
        {
            this._othername = param1;
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

        public function get itemmodelid() : int
        {
            return this._itemmodelid;
        }// end function

        public function set itemmodelid(param1:int) : void
        {
            this._itemmodelid = param1;
            return;
        }// end function

        public function get itemnum() : int
        {
            return this._itemnum;
        }// end function

        public function set itemnum(param1:int) : void
        {
            this._itemnum = param1;
            return;
        }// end function

    }
}
