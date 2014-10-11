package com.game.team.bean
{
    import com.game.player.bean.*;
    import com.game.utils.*;
    import net.*;

    public class TeamMemberInfo extends Bean
    {
        private var _memberid:long;
        private var _membername:String;
        private var _memberlevel:int;
        private var _membermapid:int;
        private var _memberline:int;
        private var _mx:int;
        private var _my:int;
        private var _membermaponlyid:long;
        private var _memberJob:int;
        private var _isonline:int;
        private var _appearanceInfo:PlayerAppearanceInfo;

        public function TeamMemberInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._memberid);
            writeString(this._membername);
            writeInt(this._memberlevel);
            writeInt(this._membermapid);
            writeInt(this._memberline);
            writeShort(this._mx);
            writeShort(this._my);
            writeLong(this._membermaponlyid);
            writeBean(this._appearanceInfo);
            writeByte(this._memberJob);
            writeByte(this._isonline);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._memberid = readLong();
            this._membername = readString();
            this._memberlevel = readInt();
            this._membermapid = readInt();
            this._memberline = readInt();
            this._mx = readShort();
            this._my = readShort();
            this._membermaponlyid = readLong();
            this._appearanceInfo = readBean(PlayerAppearanceInfo) as PlayerAppearanceInfo;
            this._memberJob = readByte();
            this._isonline = readByte();
            return true;
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

        public function get membername() : String
        {
            return this._membername;
        }// end function

        public function set membername(param1:String) : void
        {
            this._membername = param1;
            return;
        }// end function

        public function get memberlevel() : int
        {
            return this._memberlevel;
        }// end function

        public function set memberlevel(param1:int) : void
        {
            this._memberlevel = param1;
            return;
        }// end function

        public function get membermapid() : int
        {
            return this._membermapid;
        }// end function

        public function set membermapid(param1:int) : void
        {
            this._membermapid = param1;
            return;
        }// end function

        public function get memberline() : int
        {
            return this._memberline;
        }// end function

        public function set memberline(param1:int) : void
        {
            this._memberline = param1;
            return;
        }// end function

        public function get mx() : int
        {
            return this._mx;
        }// end function

        public function set mx(param1:int) : void
        {
            this._mx = param1;
            return;
        }// end function

        public function get my() : int
        {
            return this._my;
        }// end function

        public function set my(param1:int) : void
        {
            this._my = param1;
            return;
        }// end function

        public function get membermaponlyid() : long
        {
            return this._membermaponlyid;
        }// end function

        public function set membermaponlyid(param1:long) : void
        {
            this._membermaponlyid = param1;
            return;
        }// end function

        public function get appearanceInfo() : PlayerAppearanceInfo
        {
            return this._appearanceInfo;
        }// end function

        public function set appearanceInfo(param1:PlayerAppearanceInfo) : void
        {
            this._appearanceInfo = param1;
            return;
        }// end function

        public function get memberJob() : int
        {
            return this._memberJob;
        }// end function

        public function set memberJob(param1:int) : void
        {
            this._memberJob = param1;
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
