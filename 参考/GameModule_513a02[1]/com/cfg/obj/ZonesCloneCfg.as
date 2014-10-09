package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class ZonesCloneCfg extends Object
    {
        private var _vecCloneTable:Vector.<ZonesTableVo>;
        private var _mapBaseinfo:Object;
        private var _zonesDekaronAward:Object;
        private static var _instance:ZonesCloneCfg;

        public function ZonesCloneCfg()
        {
            this._vecCloneTable = new Vector.<ZonesTableVo>;
            this._mapBaseinfo = CfgManager.getInstance().getMap("q_clone_client");
            this._zonesDekaronAward = CfgManager.getInstance().getMap("q_pt_award");
            this.initTable();
            return;
        }// end function

        private function initTable() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._mapBaseinfo)
            {
                
                _loc_2 = new ZonesTableVo();
                _loc_2.parse(_loc_1);
                this._vecCloneTable.push(_loc_2);
            }
            return;
        }// end function

        public function getZonesInfoFromId(param1:int) : ZonesTableVo
        {
            var _loc_2:* = new ZonesTableVo();
            _loc_2.parse(this._mapBaseinfo[param1]);
            return _loc_2;
        }// end function

        public function getCurZones(param1:int, param2:int) : ZonesTableVo
        {
            var _loc_4:* = null;
            var _loc_3:* = this._vecCloneTable.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = this._vecCloneTable[_loc_5];
                if (_loc_4.type == param2 && _loc_4.min_lv <= param1 && _loc_4.max_lv >= param1)
                {
                    return _loc_4;
                }
                _loc_5++;
            }
            return null;
        }// end function

        public function getDekaronAwardInfo(param1:int) : Object
        {
            return this._zonesDekaronAward[param1];
        }// end function

        public static function getInstance() : ZonesCloneCfg
        {
            if (!_instance)
            {
                _instance = new ZonesCloneCfg;
            }
            return _instance;
        }// end function

    }
}
