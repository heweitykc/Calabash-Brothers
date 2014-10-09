package com.model.vo
{
    import com.cfg.obj.*;

    public class WorldMapInfo extends Object
    {
        public var mapId:uint;
        private var _mapWorldName:String;
        private var _mapName:String;
        public var monInfoList:Array;
        public var mapDrop:Array;
        public var bossList:Array;
        public var creamList:Array;
        public var recMinLv:uint;
        public var recMaxLv:uint;
        public var mapWidth:int;
        public var mapHeight:int;
        private var _mapLimitMinLv:int;
        private var _mapLimitMaxLv:int;
        private var isInitMapInfo:Boolean;

        public function WorldMapInfo(param1:Object)
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            this.mapId = param1.q_mapid;
            var _loc_2:* = param1.q_monster_coord.split(";");
            var _loc_3:* = param1.q_monster_drop.split(";");
            var _loc_4:* = param1.q_boss_coord.split(";");
            var _loc_5:* = param1.q_cream_coord.split(";");
            var _loc_6:* = 0;
            var _loc_7:* = _loc_2.length;
            this.monInfoList = [];
            if (param1.q_monster_coord != "")
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_8 = new WorldMapMonInfo();
                    _loc_8.conByWorldMapMonObjStr(_loc_2[_loc_6], param1.q_mapid);
                    this.monInfoList.push(_loc_8);
                    _loc_6++;
                }
            }
            this.mapDrop = [];
            if (param1.q_monster_drop != "")
            {
                _loc_6 = 0;
                _loc_7 = _loc_3.length;
                while (_loc_6 < _loc_7)
                {
                    
                    if (_loc_3[_loc_6] == "")
                    {
                        break;
                    }
                    _loc_9 = new WorldMapDropInfo();
                    _loc_9.conByWorldMapDropStr(_loc_3[_loc_6]);
                    this.mapDrop.push(_loc_9);
                    _loc_6++;
                }
            }
            this.bossList = [];
            if (param1.q_boss_coord != "")
            {
                _loc_6 = 0;
                _loc_7 = _loc_4.length;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_8 = new WorldMapMonInfo();
                    _loc_8.conByWorldMapMonObjStr(_loc_4[_loc_6], param1.q_mapid);
                    this.bossList.push(_loc_8);
                    _loc_6++;
                }
            }
            this.creamList = [];
            if (param1.q_cream_coord != "")
            {
                _loc_6 = 0;
                _loc_7 = _loc_5.length;
                while (_loc_6 < _loc_7)
                {
                    
                    _loc_8 = new WorldMapMonInfo();
                    _loc_8.conByWorldMapMonObjStr(_loc_5[_loc_6], param1.q_mapid);
                    this.creamList.push(_loc_8);
                    _loc_6++;
                }
            }
            this.recMinLv = param1.q_min_lv;
            this.recMaxLv = param1.q_max_lv;
            this.mapWidth = param1.q_map_width;
            this.mapHeight = param1.q_map_height;
            this._mapWorldName = param1.q_map_name;
            return;
        }// end function

        public function get mapWorldName() : String
        {
            if (!this.isInitMapInfo)
            {
                this.initMapInfo();
            }
            return this._mapWorldName;
        }// end function

        private function initMapInfo() : void
        {
            var _loc_1:* = MapCfgObj.getInstance().getMap(this.mapId);
            this._mapName = _loc_1.mapName;
            this._mapLimitMinLv = _loc_1.mapLimitMinLv;
            this._mapLimitMaxLv = _loc_1.mapLimitMaxLv;
            this.isInitMapInfo = true;
            return;
        }// end function

        public function get mapName() : String
        {
            if (!this.isInitMapInfo)
            {
                this.initMapInfo();
            }
            return this._mapName;
        }// end function

        public function set mapName(param1:String) : void
        {
            this._mapName = param1;
            return;
        }// end function

        public function get mapLimitMinLv() : int
        {
            if (!this.isInitMapInfo)
            {
                this.initMapInfo();
            }
            return this._mapLimitMinLv;
        }// end function

        public function set mapLimitMinLv(param1:int) : void
        {
            this._mapLimitMinLv = param1;
            return;
        }// end function

        public function get mapLimitMaxLv() : int
        {
            if (!this.isInitMapInfo)
            {
                this.initMapInfo();
            }
            return this._mapLimitMaxLv;
        }// end function

        public function set mapLimitMaxLv(param1:int) : void
        {
            this._mapLimitMaxLv = param1;
            return;
        }// end function

    }
}
