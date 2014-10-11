package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqInviteGameSelectMessage extends Message
    {
        private var _teamid:long;
        private var _captainid:long;
        private var _select:int;

        public function ReqInviteGameSelectMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._teamid);
            writeLong(this._captainid);
            writeByte(this._select);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._teamid = readLong();
            this._captainid = readLong();
            this._select = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118205;
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

        public function get captainid() : long
        {
            return this._captainid;
        }// end function

        public function set captainid(param1:long) : void
        {
            this._captainid = param1;
            return;
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

    }
}
