package com.game.guard.message
{
    import net.*;

    public class ResSpecialMessage extends Message
    {
        private var _residue:int;
        private var _buffId:int;

        public function ResSpecialMessage()
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

        public function set buffId(param1:int) : void
        {
            this._buffId = param1;
            return;
        }// end function

        public function get buffId() : int
        {
            return this._buffId;
        }// end function

        override public function getId() : int
        {
            return 600018;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._residue);
            writeInt(this._buffId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._residue = readInt();
            this._buffId = readInt();
            return true;
        }// end function

    }
}
