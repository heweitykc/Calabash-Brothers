package com.game.guard.message
{
    import net.*;

    public class ResOpenIconMessage extends Message
    {
        private var _residue:int;

        public function ResOpenIconMessage()
        {
            return;
        }// end function

        public function set residue(param1:int) : void
        {
            this._residue = param1;
            return;
        }// end function

        public function get residue() : int
        {
            return this._residue;
        }// end function

        override public function getId() : int
        {
            return 600015;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._residue);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._residue = readInt();
            return true;
        }// end function

    }
}
