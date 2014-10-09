package com.game.zones.message
{
    import com.game.utils.*;
    import net.*;

    public class ResZoneTimeRecordNoticeMessage extends Message
    {
        private var _fulltime:int;
        private var _fullname:String;
        private var _zoneid:int;
        private var _playerid:long;

        public function ResZoneTimeRecordNoticeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._fulltime);
            writeString(this._fullname);
            writeInt(this._zoneid);
            writeLong(this._playerid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fulltime = readInt();
            this._fullname = readString();
            this._zoneid = readInt();
            this._playerid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128112;
        }// end function

        public function get fulltime() : int
        {
            return this._fulltime;
        }// end function

        public function set fulltime(param1:int) : void
        {
            this._fulltime = param1;
            return;
        }// end function

        public function get fullname() : String
        {
            return this._fullname;
        }// end function

        public function set fullname(param1:String) : void
        {
            this._fullname = param1;
            return;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
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
