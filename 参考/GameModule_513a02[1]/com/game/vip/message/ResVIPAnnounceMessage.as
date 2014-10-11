package com.game.vip.message
{
    import net.*;

    public class ResVIPAnnounceMessage extends Message
    {
        private var _playername:String;
        private var _vipid:int;

        public function ResVIPAnnounceMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            writeInt(this._vipid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            this._vipid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 147103;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get vipid() : int
        {
            return this._vipid;
        }// end function

        public function set vipid(param1:int) : void
        {
            this._vipid = param1;
            return;
        }// end function

    }
}
