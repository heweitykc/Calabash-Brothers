package com.game.team.message
{
    import com.game.team.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResInviteClientMessage extends Message
    {
        private var _teamid:long;
        private var _captaininfo:TeamMemberInfo;

        public function ResInviteClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            writeBean(this._captaininfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            this._captaininfo = readBean(TeamMemberInfo) as TeamMemberInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 118103;
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

        public function get captaininfo() : TeamMemberInfo
        {
            return this._captaininfo;
        }// end function

        public function set captaininfo(param1:TeamMemberInfo) : void
        {
            this._captaininfo = param1;
            return;
        }// end function

    }
}
