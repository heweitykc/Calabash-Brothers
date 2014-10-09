package com.game.zones.message
{
    import net.*;

    public class ReqZoneImmediatelyMessage extends Message
    {
        private var _type:int;

        public function ReqZoneImmediatelyMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128205;
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
