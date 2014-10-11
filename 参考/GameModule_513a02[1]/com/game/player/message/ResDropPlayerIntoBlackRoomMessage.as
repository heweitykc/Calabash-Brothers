package com.game.player.message
{
    import net.*;

    public class ResDropPlayerIntoBlackRoomMessage extends Message
    {
        private var _drop:int;

        public function ResDropPlayerIntoBlackRoomMessage()
        {
            return;
        }// end function

        public function set drop(param1:int) : void
        {
            this._drop = param1;
            return;
        }// end function

        public function get drop() : int
        {
            return this._drop;
        }// end function

        override public function getId() : int
        {
            return 505001;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._drop);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._drop = readByte();
            return true;
        }// end function

    }
}
