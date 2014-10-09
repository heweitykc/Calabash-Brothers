package com.game.gm.message
{
    import net.*;

    public class GmCommandMessage extends Message
    {
        private var _command:String;

        public function GmCommandMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._command);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._command = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 200201;
        }// end function

        public function get command() : String
        {
            return this._command;
        }// end function

        public function set command(param1:String) : void
        {
            this._command = param1;
            return;
        }// end function

    }
}
