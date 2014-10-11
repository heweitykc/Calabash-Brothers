package com.game.zones.message
{
    import net.*;

    public class ResZoneTeamOpenBullToClientMessage extends Message
    {
        private var _zonemodelid:int;

        public function ResZoneTeamOpenBullToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zonemodelid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zonemodelid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128119;
        }// end function

        public function get zonemodelid() : int
        {
            return this._zonemodelid;
        }// end function

        public function set zonemodelid(param1:int) : void
        {
            this._zonemodelid = param1;
            return;
        }// end function

    }
}
