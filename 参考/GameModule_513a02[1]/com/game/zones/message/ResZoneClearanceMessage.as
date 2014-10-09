package com.game.zones.message
{
    import net.*;

    public class ResZoneClearanceMessage extends Message
    {
        private var _zoneid:int;

        public function ResZoneClearanceMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128105;
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
