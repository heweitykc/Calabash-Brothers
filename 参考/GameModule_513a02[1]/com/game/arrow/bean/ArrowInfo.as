package com.game.arrow.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class ArrowInfo extends Bean
    {
        private var _arrowlv:int;
        private var _starinfo:StarInfo;
        private var _bowinfo:BowInfo;
        private var _fightspiritList:Vector.<FightSpiritInfo>;

        public function ArrowInfo()
        {
            this._fightspiritList = new Vector.<FightSpiritInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._arrowlv);
            writeBean(this._starinfo);
            writeBean(this._bowinfo);
            writeShort(this._fightspiritList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._fightspiritList.length)
            {
                
                writeBean(this._fightspiritList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._arrowlv = readInt();
            this._starinfo = readBean(StarInfo) as StarInfo;
            this._bowinfo = readBean(BowInfo) as BowInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._fightspiritList[_loc_2] = readBean(FightSpiritInfo) as FightSpiritInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get arrowlv() : int
        {
            return this._arrowlv;
        }// end function

        public function set arrowlv(param1:int) : void
        {
            this._arrowlv = param1;
            return;
        }// end function

        public function get starinfo() : StarInfo
        {
            return this._starinfo;
        }// end function

        public function set starinfo(param1:StarInfo) : void
        {
            this._starinfo = param1;
            return;
        }// end function

        public function get bowinfo() : BowInfo
        {
            return this._bowinfo;
        }// end function

        public function set bowinfo(param1:BowInfo) : void
        {
            this._bowinfo = param1;
            return;
        }// end function

        public function get fightspiritList() : Vector.<FightSpiritInfo>
        {
            return this._fightspiritList;
        }// end function

        public function set fightspiritList(param1:Vector.<FightSpiritInfo>) : void
        {
            this._fightspiritList = param1;
            return;
        }// end function

    }
}
