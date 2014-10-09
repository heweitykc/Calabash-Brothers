package com.game.biwudao.message
{
    import net.*;

    public class ResBiWuDaoSurplusTimeToClientMessage extends Message
    {
        private var _surplustime:int;

        public function ResBiWuDaoSurplusTimeToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._surplustime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._surplustime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157106;
        }// end function

        public function get surplustime() : int
        {
            return this._surplustime;
        }// end function

        public function set surplustime(param1:int) : void
        {
            this._surplustime = param1;
            return;
        }// end function

    }
}
