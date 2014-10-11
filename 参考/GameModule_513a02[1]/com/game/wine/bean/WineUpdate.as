package com.game.wine.bean
{
    import net.*;

    public class WineUpdate extends Bean
    {
        private var _times:int;
        private var _moneyTimes:int;
        private var _nowWine:int;
        private var _wine:int;
        private var _detail:int;
        private var _zhenqi:int;
        private var _exp:int;

        public function WineUpdate()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._times);
            writeByte(this._moneyTimes);
            writeByte(this._nowWine);
            writeByte(this._wine);
            writeInt(this._detail);
            writeInt(this._zhenqi);
            writeInt(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._times = readByte();
            this._moneyTimes = readByte();
            this._nowWine = readByte();
            this._wine = readByte();
            this._detail = readInt();
            this._zhenqi = readInt();
            this._exp = readInt();
            return true;
        }// end function

        public function get times() : int
        {
            return this._times;
        }// end function

        public function set times(param1:int) : void
        {
            this._times = param1;
            return;
        }// end function

        public function get moneyTimes() : int
        {
            return this._moneyTimes;
        }// end function

        public function set moneyTimes(param1:int) : void
        {
            this._moneyTimes = param1;
            return;
        }// end function

        public function get nowWine() : int
        {
            return this._nowWine;
        }// end function

        public function set nowWine(param1:int) : void
        {
            this._nowWine = param1;
            return;
        }// end function

        public function get wine() : int
        {
            return this._wine;
        }// end function

        public function set wine(param1:int) : void
        {
            this._wine = param1;
            return;
        }// end function

        public function get detail() : int
        {
            return this._detail;
        }// end function

        public function set detail(param1:int) : void
        {
            this._detail = param1;
            return;
        }// end function

        public function get zhenqi() : int
        {
            return this._zhenqi;
        }// end function

        public function set zhenqi(param1:int) : void
        {
            this._zhenqi = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

    }
}
