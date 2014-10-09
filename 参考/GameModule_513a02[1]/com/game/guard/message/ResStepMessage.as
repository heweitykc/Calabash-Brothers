package com.game.guard.message
{
    import net.*;

    public class ResStepMessage extends Message
    {
        private var _step:int;

        public function ResStepMessage()
        {
            return;
        }// end function

        public function set step(param1:int) : void
        {
            this._step = param1;
            return;
        }// end function

        public function get step() : int
        {
            return this._step;
        }// end function

        override public function getId() : int
        {
            return 600020;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._step);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._step = readInt();
            return true;
        }// end function

    }
}
