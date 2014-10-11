package com.game.magicbook.message
{
    import net.*;

    public class ResBookGainStateMessage extends Message
    {
        private var _gainState:int;

        public function ResBookGainStateMessage()
        {
            return;
        }// end function

        public function set gainState(param1:int) : void
        {
            this._gainState = param1;
            return;
        }// end function

        public function get gainState() : int
        {
            return this._gainState;
        }// end function

        override public function getId() : int
        {
            return 600036;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._gainState);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._gainState = readInt();
            return true;
        }// end function

    }
}
