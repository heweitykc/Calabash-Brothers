package com.game.zones.message
{
    import com.game.utils.*;
    import net.*;

    public class ResZoneTeamNoticeSelectToClientMessage extends Message
    {
        private var _select:int;
        private var _memberid:long;
        private var _zoneid:int;

        public function ResZoneTeamNoticeSelectToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._select);
            writeLong(this._memberid);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._select = readByte();
            this._memberid = readLong();
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128118;
        }// end function

        public function get select() : int
        {
            return this._select;
        }// end function

        public function set select(param1:int) : void
        {
            this._select = param1;
            return;
        }// end function

        public function get memberid() : long
        {
            return this._memberid;
        }// end function

        public function set memberid(param1:long) : void
        {
            this._memberid = param1;
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

    }
}
