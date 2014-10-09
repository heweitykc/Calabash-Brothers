package com.game.login.message
{
    import net.*;

    public class ResCreateUserMessage extends Message
    {
        private var _userId:String;

        public function ResCreateUserMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._userId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._userId = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 100110;
        }// end function

        public function get userId() : String
        {
            return this._userId;
        }// end function

        public function set userId(param1:String) : void
        {
            this._userId = param1;
            return;
        }// end function

    }
}
