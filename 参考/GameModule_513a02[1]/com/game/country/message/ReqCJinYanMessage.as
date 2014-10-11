package com.game.country.message
{
    import net.*;

    public class ReqCJinYanMessage extends Message
    {
        private var _playername:String;

        public function ReqCJinYanMessage()
        {
            return;
        }// end function

        public function set playername(param1:String) : void
        {
            this._playername = param1;
            return;
        }// end function

        public function get playername() : String
        {
            return this._playername;
        }// end function

        override public function getId() : int
        {
            return 550122;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playername);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playername = readString();
            return true;
        }// end function

    }
}
