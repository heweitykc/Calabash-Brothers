package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.f1.manager.*;
    import com.f1.utils.path.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class MapCfgObj extends Object
    {
        private var _map:Object;
        private var _transfer:Object;
        private var _worldmap:Object;
        private var _mapControl:Array;
        private var _hangUp:Object;
        private var _clientMon:Object;
        private var _transferOfMap:Dictionary;
        private var _transforOfId:Dictionary;
        private var _vecHangUp:Vector.<MapHangInfo>;
        private var _allWorldMapInfoDic:Dictionary;
        private var _allTransforMapList:Array;
        private var _clientMonDic:Dictionary;
        private static var instance:MapCfgObj;

        public function MapCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_map");
            this._transfer = CfgManager.getInstance().getMap("q_transfer");
            this._worldmap = CfgManager.getInstance().getMap("q_smallmap");
            this._hangUp = CfgManager.getInstance().getMap("q_monster_coord");
            this._clientMon = CfgManager.getInstance().getMap("Q_scene_monsterClientBean");
            this.prepareTransfer();
            this.prepareAllMapList();
            this.prepareWorldMapList();
            this.perpareHangUpList();
            this.prepareMapControlList();
            return;
        }// end function

        private function prepareMapControlList() : void
        {
            var _loc_2:* = null;
            this._mapControl = [];
            var _loc_1:* = CfgManager.getInstance().getMap("q_map_control");
            for each (_loc_2 in _loc_1)
            {
                
                this._mapControl.push(_loc_2);
            }
            this._mapControl.sortOn("q_online_proportion", Array.NUMERIC);
            return;
        }// end function

        private function perpareHangUpList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._vecHangUp = new Vector.<MapHangInfo>;
            for each (_loc_2 in this._hangUp)
            {
                
                _loc_1 = new MapHangInfo(_loc_2);
                this._vecHangUp.push(_loc_1);
            }
            return;
        }// end function

        private function prepareWorldMapList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._allWorldMapInfoDic = new Dictionary();
            for each (_loc_2 in this._worldmap)
            {
                
                _loc_1 = new WorldMapInfo(_loc_2);
                this._allWorldMapInfoDic[_loc_2.q_mapid] = _loc_1;
            }
            return;
        }// end function

        private function prepareTransfer() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._transferOfMap = new Dictionary();
            this._transforOfId = new Dictionary();
            for each (_loc_8 in this._transfer)
            {
                
                if (_loc_8.q_tran_from_map)
                {
                    _loc_7 = new TransferInfo();
                    _loc_7.parse(_loc_8);
                    _loc_1 = _loc_7.q_tran_from_map;
                    if (!this._transferOfMap[_loc_1])
                    {
                        this._transferOfMap[_loc_1] = [];
                    }
                    _loc_7.q_tran_from_range = _loc_7.q_tran_from_range.slice(1, -1);
                    _loc_2 = _loc_7.q_tran_from_range.split("@");
                    if (_loc_2.length > 1)
                    {
                        _loc_7.level = _loc_2[1];
                    }
                    _loc_3 = _loc_2[0].split("#");
                    if (_loc_3.length > 1)
                    {
                        _loc_7.r = uint(_loc_3[1]) * MapUtils.GRID_BORDER;
                    }
                    _loc_4 = _loc_3[0].slice(1, -1);
                    _loc_5 = _loc_4.split(",");
                    _loc_6 = MapUtils.tile2Coo(_loc_5);
                    _loc_7.x = _loc_6[0];
                    _loc_7.y = _loc_6[1];
                    this._transferOfMap[_loc_1].push(_loc_7);
                    this._transforOfId[_loc_8.q_tran_id] = _loc_7;
                }
            }
            return;
        }// end function

        private function prepareAllMapList() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            this._allTransforMapList = [];
            var _loc_2:* = new Dictionary();
            var _loc_3:* = [];
            for (_loc_1 in this._map)
            {
                
                _loc_4 = _loc_8[_loc_1].q_worldmap_sort;
                if (_loc_4 != 0)
                {
                    if (!_loc_2[_loc_4])
                    {
                        _loc_3.push(_loc_4);
                        _loc_2[_loc_4] = [];
                    }
                    _loc_2[_loc_4].push(int(_loc_1));
                }
            }
            _loc_3.sort(Array.NUMERIC);
            _loc_5 = 0;
            _loc_6 = _loc_3.length;
            while (_loc_5 < _loc_6)
            {
                
                this._allTransforMapList = this._allTransforMapList.concat(_loc_2[_loc_3[_loc_5]]);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        private function initMonList() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._clientMonDic)
            {
                this._clientMonDic = new Dictionary();
                for each (_loc_2 in this._clientMon)
                {
                    
                    if (!this._clientMonDic[_loc_2.q_map_id])
                    {
                        this._clientMonDic[_loc_2.q_map_id] = [];
                    }
                    _loc_3 = new ClientMonsterInfo();
                    _loc_3.conByObj(_loc_2);
                    if (!this._clientMonDic[_loc_2.q_map_id][_loc_3.round])
                    {
                        this._clientMonDic[_loc_2.q_map_id][_loc_3.round] = [];
                    }
                    this._clientMonDic[_loc_2.q_map_id][_loc_3.round].push(_loc_3);
                }
            }
            return;
        }// end function

        public function getMap(param1:uint) : MapInfo
        {
            var _loc_2:* = new MapInfo(this._map[param1]);
            return _loc_2;
        }// end function

        public function getMapLineControl(param1:int, param2:int) : int
        {
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this._map[param1].q_line_control != 0)
            {
                _loc_3 = this._map[param1].q_max_online;
                _loc_4 = param2 / _loc_3;
                _loc_5 = this._mapControl.length;
                if (_loc_4 >= this._mapControl[(_loc_5 - 1)].q_online_proportion)
                {
                    return -1;
                }
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    if (_loc_4 < Number(this._mapControl[_loc_6].q_online_proportion))
                    {
                        return this._mapControl[_loc_6].q_line_number;
                    }
                    _loc_6++;
                }
                return -1;
            }
            else
            {
                return -1;
            }
        }// end function

        public function getTransferByMapId(param1:uint) : Array
        {
            return this._transferOfMap[param1];
        }// end function

        public function getTransferByTransferId(param1:uint) : TransferInfo
        {
            return this._transforOfId[param1];
        }// end function

        public function getTransferMap() : Dictionary
        {
            return this._transferOfMap;
        }// end function

        public function getAllWorldTransforMapList() : Array
        {
            return this._allTransforMapList.concat();
        }// end function

        public function getAllRecommandMonListByFormula() : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_2 = _loc_1.attack;
            _loc_3 = _loc_1.defense;
            _loc_4 = _loc_1.level;
            var _loc_6:* = _loc_1.q_reduce_damage / 10000;
            var _loc_8:* = [];
            var _loc_9:* = this._vecHangUp.length;
            var _loc_10:* = 0;
            while (_loc_10 < _loc_9)
            {
                
                _loc_5 = this._vecHangUp[_loc_10];
                _loc_7 = (_loc_5.q_monster_attack * Math.min(Math.max(_loc_5.q_monster_level - _loc_4 - 30, 0) / 30 + 1, 3) - _loc_3) * _loc_6;
                if (_loc_7 < _loc_5.q_parameter)
                {
                    _loc_11 = _loc_5.monInfoList;
                    _loc_12 = _loc_11.length;
                    _loc_13 = 0;
                    while (_loc_13 < _loc_12)
                    {
                        
                        if (_loc_11[_loc_13].level <= _loc_4)
                        {
                            _loc_8.push(_loc_11[_loc_13]);
                        }
                        _loc_13++;
                    }
                    if (_loc_8.length > 0)
                    {
                        return _loc_8;
                    }
                }
                _loc_10++;
            }
            return _loc_8;
        }// end function

        public function getAllRecommandMonListByMap(param1:int, param2:int) : Array
        {
            var _loc_3:* = [];
            var _loc_4:* = this._allWorldMapInfoDic[param2];
            if (this._allWorldMapInfoDic[param2] && param1 >= _loc_4.recMinLv && param1 <= _loc_4.recMaxLv)
            {
                return _loc_4.monInfoList;
            }
            return null;
        }// end function

        public function getAllRecommandMonListByMapWithoutLv(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this._allWorldMapInfoDic[param1];
            return _loc_3.monInfoList;
        }// end function

        public function getAllRecommandBossListByMapWithoutLv(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this._allWorldMapInfoDic[param1];
            return _loc_3.bossList;
        }// end function

        public function getAllRecommandCreamListByMapWithoutLv(param1:int) : Array
        {
            var _loc_2:* = [];
            var _loc_3:* = this._allWorldMapInfoDic[param1];
            return _loc_3.creamList;
        }// end function

        public function getWorldMap(param1:int) : WorldMapInfo
        {
            return this._allWorldMapInfoDic[param1];
        }// end function

        public function getClientMonsterByMapId(param1:int) : Array
        {
            if (!this._clientMonDic)
            {
                this.initMonList();
            }
            return this._clientMonDic[param1];
        }// end function

        public static function getInstance() : MapCfgObj
        {
            if (instance == null)
            {
                instance = new MapCfgObj;
            }
            return instance;
        }// end function

    }
}
