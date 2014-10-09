package com.model.vo
{

    public class WorldMapDropInfo extends Object
    {
        public var itemModelId:int;
        public var intensify:uint;

        public function WorldMapDropInfo()
        {
            return;
        }// end function

        public function conByWorldMapDropStr(param1:String) : void
        {
            var _loc_2:* = null;
            _loc_2 = param1.split("_");
            if (_loc_2 && _loc_2.length)
            {
                this.itemModelId = _loc_2[0];
                this.intensify = _loc_2[1];
            }
            return;
        }// end function

    }
}
