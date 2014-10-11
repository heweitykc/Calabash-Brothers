package com.game.bank.bean
{
    import net.*;

    public class BankLogInfo extends Bean
    {
        private var _playerName:String;
        private var _option:int;
        private var _count:int;

        public function BankLogInfo()
        {
            return;
        }// end function

        public function set playerName(param1:String) : void
        {
            this._playerName = param1;
            return;
        }// end function

        public function get playerName() : String
        {
            return this._playerName;
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

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._playerName);
            writeInt(this._option);
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerName = readString();
            this._option = readInt();
            this._count = readInt();
            return true;
        }// end function

    }
}
