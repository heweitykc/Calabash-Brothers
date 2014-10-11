package com.game.zones.message
{
    import net.*;

    public class ReqZoneCancelSignupToGameMessage extends Message
    {
        private var _type:int;
        private var _zoneid:int;

        public function ReqZoneCancelSignupToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._zoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._zoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128216;
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
