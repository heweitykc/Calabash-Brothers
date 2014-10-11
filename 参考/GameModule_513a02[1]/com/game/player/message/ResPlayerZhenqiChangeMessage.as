package com.game.player.message
{
    import net.*;

    public class ResPlayerZhenqiChangeMessage extends Message
    {
        private var _currentZhenqi:int;

        public function ResPlayerZhenqiChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._currentZhenqi);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._currentZhenqi = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103113;
        }// end function

        public function get currentZhenqi() : int
        {
            return this._currentZhenqi;
        }// end function

        public function set currentZhenqi(param1:int) : void
        {
            this._currentZhenqi = param1;
            return;
        }// end function

    }
}
