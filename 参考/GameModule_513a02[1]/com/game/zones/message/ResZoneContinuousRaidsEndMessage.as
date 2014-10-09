package com.game.zones.message
{
    import net.*;

    public class ResZoneContinuousRaidsEndMessage extends Message
    {
        private var _zoneid:int;
        private var _type:int;

        public function ResZoneContinuousRaidsEndMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128115;
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
