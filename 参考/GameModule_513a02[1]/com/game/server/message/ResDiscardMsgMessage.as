package com.game.server.message
{
    import net.*;

    public class ResDiscardMsgMessage extends Message
    {
        private var _msgcont:String;
        private var _msgid:int;

        public function ResDiscardMsgMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._msgcont);
            writeInt(this._msgid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._msgcont = readString();
            this._msgid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 300102;
        }// end function

        public function get msgcont() : String
        {
            return this._msgcont;
        }// end function

        public function set msgcont(param1:String) : void
        {
            this._msgcont = param1;
            return;
        }// end function

        public function get msgid() : int
        {
            return this._msgid;
        }// end function

        public function set msgid(param1:int) : void
        {
            this._msgid = param1;
            return;
        }// end function

    }
}
