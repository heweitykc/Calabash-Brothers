package com.game.team.message
{
    import com.game.team.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResApplyClientMessage extends Message
    {
        private var _teamid:long;
        private var _newmemberinfo:TeamMemberInfo;

        public function ResApplyClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            writeBean(this._newmemberinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            this._newmemberinfo = readBean(TeamMemberInfo) as TeamMemberInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 118102;
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

        public function get newmemberinfo() : TeamMemberInfo
        {
            return this._newmemberinfo;
        }// end function

        public function set newmemberinfo(param1:TeamMemberInfo) : void
        {
            this._newmemberinfo = param1;
            return;
        }// end function

    }
}
