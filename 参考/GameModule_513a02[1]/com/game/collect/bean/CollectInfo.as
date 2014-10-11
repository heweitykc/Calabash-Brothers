package com.game.collect.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class CollectInfo extends Bean
    {
        private var _modelid:int;
        private var _fragList:Vector.<FragInfo>;

        public function CollectInfo()
        {
            this._fragList = new Vector.<FragInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelid);
            writeShort(this._fragList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._fragList.length)
            {
                
                writeBean(this._fragList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelid = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._fragList[_loc_2] = readBean(FragInfo) as FragInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get modelid() : int
        {
            return this._modelid;
        }// end function

        public function set modelid(param1:int) : void
        {
            this._modelid = param1;
            return;
        }// end function

        public function get fragList() : Vector.<FragInfo>
        {
            return this._fragList;
        }// end function

        public function set fragList(param1:Vector.<FragInfo>) : void
        {
            this._fragList = param1;
            return;
        }// end function

    }
}
