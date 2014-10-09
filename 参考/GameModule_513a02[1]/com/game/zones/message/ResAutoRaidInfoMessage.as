package com.game.zones.message
{
    import net.*;

    public class ResAutoRaidInfoMessage extends Message
    {
        private var _surplustime:int;
        private var _zoneid:int;

        public function ResAutoRaidInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._surplustime);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._surplustime = readInt();
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128107;
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
