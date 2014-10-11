package com.game.country.bean
{
    import net.*;

    public class WarRewardInfo extends Bean
    {
        private var _zhenqi:int;
        private var _exp:int;
        private var _remaintime:int;

        public function WarRewardInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zhenqi);
            writeInt(this._exp);
            writeInt(this._remaintime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zhenqi = readInt();
            this._exp = readInt();
            this._remaintime = readInt();
            return true;
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

        public function get remaintime() : int
        {
            return this._remaintime;
        }// end function

        public function set remaintime(param1:int) : void
        {
            this._remaintime = param1;
            return;
        }// end function

    }
}
