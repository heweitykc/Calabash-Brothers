package com.game.zones.message
{
    import net.*;

    public class ReqZoneIntoMessage extends Message
    {
        private var _zoneid:int;
        private var _isauto:int;

        public function ReqZoneIntoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeByte(this._isauto);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._isauto = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128202;
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

        public function get isauto() : int
        {
            return this._isauto;
        }// end function

        public function set isauto(param1:int) : void
        {
            this._isauto = param1;
            return;
        }// end function

    }
}
