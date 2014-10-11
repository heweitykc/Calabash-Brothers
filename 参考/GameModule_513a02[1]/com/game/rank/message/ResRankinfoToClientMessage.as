package com.game.rank.message
{
    import com.game.rank.bean.*;
    import net.*;

    public class ResRankinfoToClientMessage extends Message
    {
        private var _rankinfo:Rankinfo;
        private var _dayrankexp:int;

        public function ResRankinfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._rankinfo);
            writeInt(this._dayrankexp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._rankinfo = readBean(Rankinfo) as Rankinfo;
            this._dayrankexp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 117101;
        }// end function

        public function get rankinfo() : Rankinfo
        {
            return this._rankinfo;
        }// end function

        public function set rankinfo(param1:Rankinfo) : void
        {
            this._rankinfo = param1;
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
