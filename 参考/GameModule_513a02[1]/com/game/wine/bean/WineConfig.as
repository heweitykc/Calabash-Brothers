package com.game.wine.bean
{
    import net.*;

    public class WineConfig extends Bean
    {
        private var _maxTimes:int;
        private var _maxMoneyTimes:int;
        private var _money:int;
        private var _gold:int;

        public function WineConfig()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._maxTimes);
            writeByte(this._maxMoneyTimes);
            writeInt(this._money);
            writeInt(this._gold);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._maxTimes = readByte();
            this._maxMoneyTimes = readByte();
            this._money = readInt();
            this._gold = readInt();
            return true;
        }// end function

        public function get maxTimes() : int
        {
            return this._maxTimes;
        }// end function

        public function set maxTimes(param1:int) : void
        {
            this._maxTimes = param1;
            return;
        }// end function

        public function get maxMoneyTimes() : int
        {
            return this._maxMoneyTimes;
        }// end function

        public function set maxMoneyTimes(param1:int) : void
        {
            this._maxMoneyTimes = param1;
            return;
        }// end function

        public function get money() : int
        {
            return this._money;
        }// end function

        public function set money(param1:int) : void
        {
            this._money = param1;
            return;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

    }
}
