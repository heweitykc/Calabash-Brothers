package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqApplyGameMessage extends Message
    {
        private var _teamid:long;

        public function ReqApplyGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118202;
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

    }
}
