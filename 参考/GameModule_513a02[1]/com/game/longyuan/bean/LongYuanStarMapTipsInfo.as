package com.game.longyuan.bean
{
    import net.*;

    public class LongYuanStarMapTipsInfo extends Bean
    {
        private var _longyuanactlv:int;
        private var _isachieve:int;

        public function LongYuanStarMapTipsInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._longyuanactlv);
            writeByte(this._isachieve);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._longyuanactlv = readByte();
            this._isachieve = readByte();
            return true;
        }// end function

        public function get longyuanactlv() : int
        {
            return this._longyuanactlv;
        }// end function

        public function set longyuanactlv(param1:int) : void
        {
            this._longyuanactlv = param1;
            return;
        }// end function

        public function get isachieve() : int
        {
            return this._isachieve;
        }// end function

        public function set isachieve(param1:int) : void
        {
            this._isachieve = param1;
            return;
        }// end function

    }
}
