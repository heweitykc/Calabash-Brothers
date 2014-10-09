package com.game.zones.message
{
    import net.*;

    public class ResZoneLifeTimeMessage extends Message
    {
        private var _surplustime:int;
        private var _zoneid:int;
        private var _phase:int;
        private var _playercount:int;

        public function ResZoneLifeTimeMessage()
        {
            return;
        }// end function

        public function get playercount() : int
        {
            return this._playercount;
        }// end function

        public function set playercount(param1:int) : void
        {
            this._playercount = param1;
            return;
        }// end function

        public function get phase() : int
        {
            return this._phase;
        }// end function

        public function set phase(param1:int) : void
        {
            this._phase = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._surplustime);
            writeInt(this._zoneid);
            writeInt(this._phase);
            writeInt(this._playercount);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._surplustime = readInt();
            this._zoneid = readInt();
            this._phase = readInt();
            this._playercount = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128110;
        }// end function

        public function get surplustime() : int
        {
            return this._surplustime;
        }// end function

        public function set surplustime(param1:int) : void
        {
            this._surplustime = param1;
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
