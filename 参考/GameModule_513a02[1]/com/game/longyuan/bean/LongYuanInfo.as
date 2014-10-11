package com.game.longyuan.bean
{
    import net.*;

    public class LongYuanInfo extends Bean
    {
        private var _longyuanexpshare:int;
        private var _longyuanlv:int;
        private var _longyuannum:int;

        public function LongYuanInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._longyuanexpshare);
            writeByte(this._longyuanlv);
            writeByte(this._longyuannum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._longyuanexpshare = readShort();
            this._longyuanlv = readByte();
            this._longyuannum = readByte();
            return true;
        }// end function

        public function get longyuanexpshare() : int
        {
            return this._longyuanexpshare;
        }// end function

        public function set longyuanexpshare(param1:int) : void
        {
            this._longyuanexpshare = param1;
            return;
        }// end function

        public function get longyuanlv() : int
        {
            return this._longyuanlv;
        }// end function

        public function set longyuanlv(param1:int) : void
        {
            this._longyuanlv = param1;
            return;
        }// end function

        public function get longyuannum() : int
        {
            return this._longyuannum;
        }// end function

        public function set longyuannum(param1:int) : void
        {
            this._longyuannum = param1;
            return;
        }// end function

    }
}
