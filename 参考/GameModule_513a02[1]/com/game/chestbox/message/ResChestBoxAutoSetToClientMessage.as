package com.game.chestbox.message
{
    import net.*;

    public class ResChestBoxAutoSetToClientMessage extends Message
    {
        private var _autoset:int;

        public function ResChestBoxAutoSetToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._autoset);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._autoset = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 156104;
        }// end function

        public function get autoset() : int
        {
            return this._autoset;
        }// end function

        public function set autoset(param1:int) : void
        {
            this._autoset = param1;
            return;
        }// end function

    }
}
