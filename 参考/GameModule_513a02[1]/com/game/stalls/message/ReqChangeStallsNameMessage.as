package com.game.stalls.message
{
    import net.*;

    public class ReqChangeStallsNameMessage extends Message
    {
        private var _name:String;

        public function ReqChangeStallsNameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123211;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

    }
}
