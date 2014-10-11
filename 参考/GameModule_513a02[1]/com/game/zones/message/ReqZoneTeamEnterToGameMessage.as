package com.game.zones.message
{
    import net.*;

    public class ReqZoneTeamEnterToGameMessage extends Message
    {
        private var _entertype:int;
        private var _zoneid:int;

        public function ReqZoneTeamEnterToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._entertype);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._entertype = readByte();
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128211;
        }// end function

        public function get entertype() : int
        {
            return this._entertype;
        }// end function

        public function set entertype(param1:int) : void
        {
            this._entertype = param1;
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
