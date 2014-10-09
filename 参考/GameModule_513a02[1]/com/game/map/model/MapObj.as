package com.game.map.model
{
    import com.cfg.obj.*;
    import com.f1.utils.path.*;
    import com.game.map.control.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class MapObj extends Object
    {
        public var roofs:Array;
        private var _tw:int;
        private var _th:int;
        private var _changeMapReason:int;
        private var _tilesba:ByteArray;
        private var _mapID:int;
        private var _mapPreID:int;
        private var _pointsMap:Object;
        private static var instance:MapObj;

        public function MapObj()
        {
            this.roofs = [];
            return;
        }// end function

        public function get changeMapReason() : int
        {
            return this._changeMapReason;
        }// end function

        public function set changeMapReason(param1:int) : void
        {
            this._changeMapReason = param1;
            return;
        }// end function

        public function get mapID() : int
        {
            return this._mapID;
        }// end function

        public function set mapID(param1:int) : void
        {
            this._mapID = param1;
            return;
        }// end function

        public function get pointsMap() : Object
        {
            return this._pointsMap;
        }// end function

        public function setMapPoint(param1:Object) : void
        {
            var _loc_3:* = undefined;
            this._pointsMap = param1;
            var _loc_2:* = 0;
            for each (_loc_3 in this._pointsMap)
            {
                
                _loc_2++;
            }
            PointTable.create(param1);
            return;
        }// end function

        public function isZonesMap() : int
        {
            var _loc_1:* = 0;
            var _loc_2:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            return _loc_2.zones_type;
        }// end function

        public function isSafe(param1:int, param2:int) : Boolean
        {
            return (this.getStat(param1, param2) & 4) != 0;
        }// end function

        public function isSafeByXY(param1:Number, param2:Number) : Boolean
        {
            return this.isSafe(MapUtils.coo2Tile(param1), MapUtils.coo2Tile(param2));
        }// end function

        public function isAlpha(param1:int, param2:int) : Boolean
        {
            return (this.getStat(param1, param2) & 2) != 0;
        }// end function

        public function isObstacle(param1:int, param2:int) : Boolean
        {
            return (this.getStat(param1, param2) & 1) != 0;
        }// end function

        public function generateObstacle(param1:Array, param2:Boolean = true) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (!param1 || !this._tilesba)
            {
                return;
            }
            var _loc_3:* = param1.length;
            if (param2)
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_3)
                {
                    
                    _loc_4 = this._tw * param1[_loc_6].ty + param1[_loc_6].tx + 8;
                    if (this._tilesba.length > _loc_4)
                    {
                        this._tilesba.position = _loc_4;
                        _loc_5 = this._tilesba.readByte();
                        this._tilesba.position = _loc_4;
                        _loc_5 = _loc_5 | 1;
                        this._tilesba.writeByte(_loc_5);
                    }
                    _loc_6++;
                }
            }
            else
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_3)
                {
                    
                    _loc_4 = this._tw * param1[_loc_6].ty + param1[_loc_6].tx + 8;
                    if (this._tilesba.length > _loc_4)
                    {
                        this._tilesba.position = _loc_4;
                        _loc_5 = this._tilesba.readByte();
                        this._tilesba.position = _loc_4;
                        _loc_5 = _loc_5 & -2;
                        this._tilesba.writeByte(_loc_5);
                    }
                    _loc_6++;
                }
            }
            return;
        }// end function

        private function getStat(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            if (this._tilesba)
            {
                _loc_3 = this._tw * param2 + param1 + 8;
                if (this._tilesba.length > _loc_3)
                {
                    this._tilesba.position = _loc_3;
                    return this._tilesba.readByte();
                }
            }
            return -1;
        }// end function

        public function get tilesba() : ByteArray
        {
            return this._tilesba;
        }// end function

        public function set tilesba(param1:ByteArray) : void
        {
            this._tilesba = param1;
            if (this._tilesba)
            {
                this._tilesba.position = 0;
                this._tw = this._tilesba.readUnsignedInt();
                this._th = this._tilesba.readUnsignedInt();
            }
            return;
        }// end function

        public function get mapPreID() : int
        {
            return this._mapPreID;
        }// end function

        public function set mapPreID(param1:int) : void
        {
            this._mapPreID = param1;
            return;
        }// end function

        public static function getInstance() : MapObj
        {
            if (instance == null)
            {
                instance = new MapObj;
            }
            return instance;
        }// end function

    }
}
