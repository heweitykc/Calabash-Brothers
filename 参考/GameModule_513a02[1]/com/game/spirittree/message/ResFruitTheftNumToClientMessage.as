package com.game.spirittree.message
{
    import net.*;

    public class ResFruitTheftNumToClientMessage extends Message
    {
        private var _theftnum:int;

        public function ResFruitTheftNumToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._theftnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._theftnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133109;
        }// end function

        public function get theftnum() : int
        {
            return this._theftnum;
        }// end function

        public function set theftnum(param1:int) : void
        {
            this._theftnum = param1;
            return;
        }// end function

    }
}
