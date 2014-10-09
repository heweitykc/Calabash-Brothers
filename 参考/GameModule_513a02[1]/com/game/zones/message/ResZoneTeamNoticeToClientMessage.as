package com.game.zones.message
{
    import com.game.utils.*;
    import net.*;

    public class ResZoneTeamNoticeToClientMessage extends Message
    {
        private var _leaderid:long;
        private var _leadername:String;
        private var _zoneid:int;
        private var _waittime:int;
        private var _entertime:int;

        public function ResZoneTeamNoticeToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._leaderid);
            writeString(this._leadername);
            writeInt(this._zoneid);
            writeInt(this._waittime);
            writeInt(this._entertime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._leaderid = readLong();
            this._leadername = readString();
            this._zoneid = readInt();
            this._waittime = readInt();
            this._entertime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128117;
        }// end function

        public function get leaderid() : long
        {
            return this._leaderid;
        }// end function

        public function set leaderid(param1:long) : void
        {
            this._leaderid = param1;
            return;
        }// end function

        public function get leadername() : String
        {
            return this._leadername;
        }// end function

        public function set leadername(param1:String) : void
        {
            this._leadername = param1;
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

        public function get waittime() : int
        {
            return this._waittime;
        }// end function

        public function set waittime(param1:int) : void
        {
            this._waittime = param1;
            return;
        }// end function

        public function get entertime() : int
        {
            return this._entertime;
        }// end function

        public function set entertime(param1:int) : void
        {
            this._entertime = param1;
            return;
        }// end function

    }
}
