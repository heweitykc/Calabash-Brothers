package com.f1.view.mapeditor
{
    import com.f1.manager.resource.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class BgDrawManager extends Object
    {
        public static const GRID_WIDTH:uint = 50;
        public static const GRID_HEIGHT:uint = 25;
        private static var bmds:Dictionary = new Dictionary();
        public static var buildsSetData:Dictionary = new Dictionary();
        public static const MAP_BUILDING_SET_PATH:String = BgView.MAP_MAPRES_PATH + "set.bin";

        public function BgDrawManager()
        {
            return;
        }// end function

        public static function getBuildingSet(param1:Function = null) : void
        {
            VResManager.load(MAP_BUILDING_SET_PATH, getBuildingSetComplete);
            if (param1 != null)
            {
                VResManager.load(MAP_BUILDING_SET_PATH, param1);
            }
            return;
        }// end function

        private static function getBuildingSetComplete(param1:ByteArray) : void
        {
            param1.uncompress();
            buildsSetData = param1.readObject();
            return;
        }// end function

        public static function getBmd(param1:String, param2:Function) : void
        {
            if (!param1)
            {
                param2.call(null, null);
                return;
            }
            if (bmds[param1])
            {
                param2.call(null, bmds[param1]);
                return;
            }
            getBmdByPath(param1, param2);
            return;
        }// end function

        private static function getBmdByPath(param1:String, param2:Function) : void
        {
            var _loc_3:* = BgView.MAP_MAPRES_PATH + param1;
            VResManager.load(_loc_3, getBmdByPathComplete, [param1, param2]);
            return;
        }// end function

        private static function getBmdByPathComplete(param1, param2:String, param3:Function) : void
        {
            bmds[param2] = param1;
            param3.call(null, param1);
            return;
        }// end function

        public static function getImgSplit(param1:BitmapData, param2:uint) : BitmapData
        {
            if (!param1)
            {
                return null;
            }
            var _loc_3:* = 4;
            var _loc_4:* = new BitmapData(GRID_WIDTH, GRID_HEIGHT);
            var _loc_5:* = param2 % _loc_3;
            var _loc_6:* = int(param2 / _loc_3) * GRID_WIDTH;
            var _loc_7:* = param2 % _loc_3 * GRID_HEIGHT;
            _loc_4.copyPixels(param1, new Rectangle(_loc_6, _loc_7, GRID_WIDTH, GRID_HEIGHT), new Point(0, 0));
            return _loc_4;
        }// end function

    }
}
