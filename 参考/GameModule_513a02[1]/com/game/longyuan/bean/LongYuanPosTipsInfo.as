package com.game.longyuan.bean
{
    import net.*;

    public class LongYuanPosTipsInfo extends Bean
    {
        private var _longyuanactlv:int;
        private var _longyuanactnum:int;
        private var _successrate:int;
        private var _longyuanexpshare:int;
        private var _longyuanshareexpsum:int;
        private var _isachieve:int;

        public function LongYuanPosTipsInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._longyuanactlv);
            writeByte(this._longyuanactnum);
            writeInt(this._successrate);
            writeShort(this._longyuanexpshare);
            writeInt(this._longyuanshareexpsum);
            writeByte(this._isachieve);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._longyuanactlv = readByte();
            this._longyuanactnum = readByte();
            this._successrate = readInt();
            this._longyuanexpshare = readShort();
            this._longyuanshareexpsum = readInt();
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

        public function get longyuanactnum() : int
        {
            return this._longyuanactnum;
        }// end function

        public function set longyuanactnum(param1:int) : void
        {
            this._longyuanactnum = param1;
            return;
        }// end function

        public function get successrate() : int
        {
            return this._successrate;
        }// end function

        public function set successrate(param1:int) : void
        {
            this._successrate = param1;
            return;
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

        public function get longyuanshareexpsum() : int
        {
            return this._longyuanshareexpsum;
        }// end function

        public function set longyuanshareexpsum(param1:int) : void
        {
            this._longyuanshareexpsum = param1;
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
