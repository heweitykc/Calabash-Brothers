package com.game.rank.bean
{
    import net.*;

    public class Rankinfo extends Bean
    {
        private var _ranklevel:int;
        private var _rankexp:int;

        public function Rankinfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._ranklevel);
            writeInt(this._rankexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._ranklevel = readInt();
            this._rankexp = readInt();
            return true;
        }// end function

        public function get ranklevel() : int
        {
            return this._ranklevel;
        }// end function

        public function set ranklevel(param1:int) : void
        {
            this._ranklevel = param1;
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

    }
}
