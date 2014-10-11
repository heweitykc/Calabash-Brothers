package com.game.team.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTeammateMoveToClientMessage extends Message
    {
        private var _memberid:long;
        private var _mx:int;
        private var _my:int;
        private var _type:int;

        public function ResTeammateMoveToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._memberid);
            writeShort(this._mx);
            writeShort(this._my);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._memberid = readLong();
            this._mx = readShort();
            this._my = readShort();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118112;
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

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
