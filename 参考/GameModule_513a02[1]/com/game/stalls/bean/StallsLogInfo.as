package com.game.stalls.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class StallsLogInfo extends Bean
    {
        private var _stallsloglist:Vector.<StallsSingleLogInfo>;

        public function StallsLogInfo()
        {
            this._stallsloglist = new Vector.<StallsSingleLogInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._stallsloglist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._stallsloglist.length)
            {
                
                writeBean(this._stallsloglist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._stallsloglist[_loc_2] = readBean(StallsSingleLogInfo) as StallsSingleLogInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get stallsloglist() : Vector.<StallsSingleLogInfo>
        {
            return this._stallsloglist;
        }// end function

        public function set stallsloglist(param1:Vector.<StallsSingleLogInfo>) : void
        {
            this._stallsloglist = param1;
            return;
        }// end function

    }
}
