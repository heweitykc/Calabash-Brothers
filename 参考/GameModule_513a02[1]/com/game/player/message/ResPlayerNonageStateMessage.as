package com.game.player.message
{
    import net.*;

    public class ResPlayerNonageStateMessage extends Message
    {
        private var _nonage:int;

        public function ResPlayerNonageStateMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._nonage);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._nonage = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103121;
        }// end function

        public function get nonage() : int
        {
            return this._nonage;
        }// end function

        public function set nonage(param1:int) : void
        {
            this._nonage = param1;
            return;
        }// end function

    }
}
