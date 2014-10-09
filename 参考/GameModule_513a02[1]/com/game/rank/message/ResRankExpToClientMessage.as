package com.game.rank.message
{
    import net.*;

    public class ResRankExpToClientMessage extends Message
    {
        private var _ranksum:int;
        private var _rankexp:int;
        private var _dayrankexp:int;

        public function ResRankExpToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._ranksum);
            writeInt(this._rankexp);
            writeInt(this._dayrankexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._ranksum = readInt();
            this._rankexp = readInt();
            this._dayrankexp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 117102;
        }// end function

        public function get ranksum() : int
        {
            return this._ranksum;
        }// end function

        public function set ranksum(param1:int) : void
        {
            this._ranksum = param1;
            return;
        }// end function

        public function get rankexp() : int
        {
            return this._rankexp;
        }// end function

        public function set rankexp(param1:int) : void
        {
            this._rankexp = param1;
            return;
        }// end function

        public function get dayrankexp() : int
        {
            return this._dayrankexp;
        }// end function

        public function set dayrankexp(param1:int) : void
        {
            this._dayrankexp = param1;
            return;
        }// end function

    }
}
