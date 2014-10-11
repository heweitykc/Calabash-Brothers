package com.game.player.message
{
    import net.*;

    public class ResIsActivateSuccese extends Message
    {
        private var _isSuccese:int;

        public function ResIsActivateSuccese()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._isSuccese);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._isSuccese = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 575003;
        }// end function

        public function get isSuccese() : int
        {
            return this._isSuccese;
        }// end function

        public function set isSuccese(param1:int) : void
        {
            this._isSuccese = param1;
            return;
        }// end function

    }
}
