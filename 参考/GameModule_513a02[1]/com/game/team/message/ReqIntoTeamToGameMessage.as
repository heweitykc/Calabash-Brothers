package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqIntoTeamToGameMessage extends Message
    {
        private var _othersid:long;

        public function ReqIntoTeamToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._othersid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._othersid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118216;
        }// end function

        public function get othersid() : long
        {
            return this._othersid;
        }// end function

        public function set othersid(param1:long) : void
        {
            this._othersid = param1;
            return;
        }// end function

    }
}
