package com.game.zones.message
{
    import net.*;

    public class ReqZoneTeamSelectToGameMessage extends Message
    {
        private var _select:int;
        private var _zoneid:int;

        public function ReqZoneTeamSelectToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._select);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._select = readByte();
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128212;
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
