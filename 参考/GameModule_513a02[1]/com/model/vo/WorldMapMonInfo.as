package com.model.vo
{

    public class WorldMapMonInfo extends Object
    {
        public var monName:String;
        public var monX:int;
        public var monY:int;
        public var monMapId:int;
        public var isRecommend:Boolean;
        public var level:int;

        public function WorldMapMonInfo()
        {
            return;
        }// end function

        public function conByWorldMapMonObjStr(param1:String, param2:int) : void
        {
            var _loc_3:* = null;
            _loc_3 = param1.split("_");
            if (_loc_3 && _loc_3.length)
            {
                this.monName = _loc_3[0];
                this.monX = _loc_3[1];
                this.monY = _loc_3[2];
                this.monMapId = param2;
            }
            return;
        }// end function

        public function conByHangUpMapMonObjStr(param1:String) : void
        {
            var _loc_2:* = null;
            _loc_2 = param1.split("_");
            if (_loc_2 && _loc_2.length)
            {
                this.monName = _loc_2[0];
                this.monMapId = _loc_2[1];
                this.monX = _loc_2[2];
                this.monY = _loc_2[3];
                this.level = _loc_2[4];
            }
            return;
        }// end function

    }
}
