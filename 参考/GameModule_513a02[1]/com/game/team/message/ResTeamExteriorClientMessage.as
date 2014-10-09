package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTeamExteriorClientMessage extends Message
    {
        private var _teamid:long;
        private var _playerid:long;

        public function ResTeamExteriorClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            writeLong(this._playerid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            this._playerid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118105;
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
