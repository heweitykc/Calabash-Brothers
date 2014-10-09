package com.game.zones.message
{
    import com.game.utils.*;
    import net.*;

    public class ResZoneTeamErroMessage extends Message
    {
        private var _type:int;
        private var _memberid:long;
        private var _name:String;
        private var _zoneid:int;

        public function ResZoneTeamErroMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set memberid(param1:long) : void
        {
            this._memberid = param1;
            return;
        }// end function

        public function get memberid() : long
        {
            return this._memberid;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        override public function getId() : int
        {
            return 528118;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeLong(this._memberid);
            writeString(this._name);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._memberid = readLong();
            this._name = readString();
            this._zoneid = readInt();
            return true;
        }// end function

    }
}
