package com.game.casting.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class CastingBoxInfo extends Bean
    {
        private var _castingGridInfoList:Vector.<CastingGridInfo>;

        public function CastingBoxInfo()
        {
            this._castingGridInfoList = new Vector.<CastingGridInfo>;
            return;
        }// end function

        public function set castingGridInfoList(param1:Vector.<CastingGridInfo>) : void
        {
            this._castingGridInfoList = param1;
            return;
        }// end function

        public function get castingGridInfoList() : Vector.<CastingGridInfo>
        {
            return this._castingGridInfoList;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._castingGridInfoList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._castingGridInfoList.length)
            {
                
                writeBean(this._castingGridInfoList[_loc_1]);
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
                
                this._castingGridInfoList[_loc_2] = readBean(CastingGridInfo) as CastingGridInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
