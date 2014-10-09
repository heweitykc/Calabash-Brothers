package com.game.backpack.message
{
    import net.*;

    public class ResBindGoldChangeMessage extends Message
    {
        private var _bindgold:int;

        public function ResBindGoldChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._bindgold);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bindgold = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104111;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
            return;
        }// end function

    }
}
