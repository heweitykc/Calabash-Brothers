package com.game.biwudao.message
{
    import net.*;

    public class ResBiWuDaoTotalGainToClientMessage extends Message
    {
        private var _totalexp:int;
        private var _totalzhenqi:int;
        private var _totalrank:int;
        private var _totalBox:int;

        public function ResBiWuDaoTotalGainToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._totalexp);
            writeInt(this._totalzhenqi);
            writeInt(this._totalrank);
            writeInt(this._totalBox);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._totalexp = readInt();
            this._totalzhenqi = readInt();
            this._totalrank = readInt();
            this._totalBox = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157103;
        }// end function

        public function get totalexp() : int
        {
            return this._totalexp;
        }// end function

        public function set totalexp(param1:int) : void
        {
            this._totalexp = param1;
            return;
        }// end function

        public function get totalzhenqi() : int
        {
            return this._totalzhenqi;
        }// end function

        public function set totalzhenqi(param1:int) : void
        {
            this._totalzhenqi = param1;
            return;
        }// end function

        public function get totalrank() : int
        {
            return this._totalrank;
        }// end function

        public function set totalrank(param1:int) : void
        {
            this._totalrank = param1;
            return;
        }// end function

        public function get totalBox() : int
        {
            return this._totalBox;
        }// end function

        public function set totalBox(param1:int) : void
        {
            this._totalBox = param1;
            return;
        }// end function

    }
}
