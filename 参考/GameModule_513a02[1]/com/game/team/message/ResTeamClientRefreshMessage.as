package com.game.team.message
{
    import __AS3__.vec.*;
    import com.game.team.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResTeamClientRefreshMessage extends Message
    {
        private var _teamid:long;
        private var _memberinfo:Vector.<TeamMemberInfo>;

        public function ResTeamClientRefreshMessage()
        {
            this._memberinfo = new Vector.<TeamMemberInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._teamid);
            writeShort(this._memberinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._memberinfo.length)
            {
                
                writeBean(this._memberinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._teamid = readLong();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._memberinfo[_loc_1] = readBean(TeamMemberInfo) as TeamMemberInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 118101;
        }// end function

        public function get teamid() : long
        {
            return this._teamid;
        }// end function

        public function set teamid(param1:long) : void
        {
            this._teamid = param1;
            return;
        }// end function

        public function get memberinfo() : Vector.<TeamMemberInfo>
        {
            return this._memberinfo;
        }// end function

        public function set memberinfo(param1:Vector.<TeamMemberInfo>) : void
        {
            this._memberinfo = param1;
            return;
        }// end function

    }
}
