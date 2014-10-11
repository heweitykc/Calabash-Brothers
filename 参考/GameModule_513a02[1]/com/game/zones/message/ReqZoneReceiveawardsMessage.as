package com.game.zones.message
{
    import net.*;

    public class ReqZoneReceiveawardsMessage extends Message
    {
        private var _type:int;
        private var _zid:int;

        public function ReqZoneReceiveawardsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._zid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._zid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128207;
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

        public function get zid() : int
        {
            return this._zid;
        }// end function

        public function set zid(param1:int) : void
        {
            this._zid = param1;
            return;
        }// end function

    }
}
