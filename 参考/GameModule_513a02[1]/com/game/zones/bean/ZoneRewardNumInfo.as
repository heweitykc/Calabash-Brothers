package com.game.zones.bean
{
    import net.*;

    public class ZoneRewardNumInfo extends Bean
    {
        private var _zoneid:int;
        private var _num:int;

        public function ZoneRewardNumInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneid);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneid = readInt();
            this._num = readInt();
            return true;
        }// end function

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
