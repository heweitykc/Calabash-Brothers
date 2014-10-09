package com.game.zones.bean
{
    import net.*;

    public class ZoneMonstrInfo extends Bean
    {
        private var _monstrmodid:int;
        private var _monstrnum:int;

        public function ZoneMonstrInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._monstrmodid);
            writeInt(this._monstrnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monstrmodid = readInt();
            this._monstrnum = readInt();
            return true;
        }// end function

        public function get monstrmodid() : int
        {
            return this._monstrmodid;
        }// end function

        public function set monstrmodid(param1:int) : void
        {
            this._monstrmodid = param1;
            return;
        }// end function

        public function get monstrnum() : int
        {
            return this._monstrnum;
        }// end function

        public function set monstrnum(param1:int) : void
        {
            this._monstrnum = param1;
            return;
        }// end function

    }
}
