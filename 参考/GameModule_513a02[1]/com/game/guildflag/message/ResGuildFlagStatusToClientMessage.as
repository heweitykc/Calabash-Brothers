package com.game.guildflag.message
{
    import net.*;

    public class ResGuildFlagStatusToClientMessage extends Message
    {
        private var _time:int;

        public function ResGuildFlagStatusToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._time);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._time = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 149102;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

    }
}
