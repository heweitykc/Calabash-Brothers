package com.game.bank.message
{
    import net.*;

    public class ReqQueryBankLogMessage extends Message
    {
        private var _option:int;
        private var _indexlittle:int;
        private var _indexLarge:int;

        public function ReqQueryBankLogMessage()
        {
            return;
        }// end function

        public function set option(param1:int) : void
        {
            this._option = param1;
            return;
        }// end function

        public function get option() : int
        {
            return this._option;
        }// end function

        public function set indexlittle(param1:int) : void
        {
            this._indexlittle = param1;
            return;
        }// end function

        public function get indexlittle() : int
        {
            return this._indexlittle;
        }// end function

        public function set indexLarge(param1:int) : void
        {
            this._indexLarge = param1;
            return;
        }// end function

        public function get indexLarge() : int
        {
            return this._indexLarge;
        }// end function

        override public function getId() : int
        {
            return 510205;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._option);
            writeInt(this._indexlittle);
            writeInt(this._indexLarge);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._option = readInt();
            this._indexlittle = readInt();
            this._indexLarge = readInt();
            return true;
        }// end function

    }
}
