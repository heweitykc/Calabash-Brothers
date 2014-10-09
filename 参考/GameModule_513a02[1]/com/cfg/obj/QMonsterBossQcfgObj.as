package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class QMonsterBossQcfgObj extends Object
    {
        private var _map:Object;
        private var bossDic:Dictionary;
        private var _bossList1:Array;
        private var _bossList2:Array;
        private static var _instance:QMonsterBossQcfgObj;

        public function QMonsterBossQcfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_monsterBossQcfg");
            this.bossDic = new Dictionary();
            return;
        }// end function

        public function getMonsterBossListPage1() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this._bossList1)
            {
                return this._bossList1;
            }
            this._bossList1 = new Array();
            for (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3);
                if (_loc_2 != 0)
                {
                    _loc_1 = new QMonsterBossQcfg();
                    _loc_1.parse(_loc_5[_loc_2]);
                    if (_loc_1.q_page == 1)
                    {
                        this._bossList1.push(_loc_1);
                    }
                }
            }
            this._bossList1.sortOn("q_id", Array.NUMERIC);
            return this._bossList1;
        }// end function

        public function getMonsterBossListPage() : Array
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._bossList2)
            {
                return this._bossList2;
            }
            this._bossList2 = new Array();
            for (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3);
                if (_loc_2 != 0)
                {
                    _loc_1 = new QMonsterBossQcfg();
                    _loc_1.parse(_loc_6[_loc_2]);
                    if (_loc_1.q_page == 2 || _loc_1.q_page == 3 || _loc_1.q_page == 4)
                    {
                        _loc_4 = QSceneMonsterAreaBeanCfgObj.getInstance().getMonsterByModelIdAndMapId(_loc_1.q_monsterid, _loc_1.q_map);
                        _loc_1.q_map_x = _loc_4.q_center_x;
                        _loc_1.q_map_y = _loc_4.q_center_y;
                        _loc_1.q_lv_limit = _loc_4.q_relive;
                        this._bossList2.push(_loc_1);
                    }
                }
            }
            this._bossList2.sortOn("q_id", Array.NUMERIC);
            return this._bossList2;
        }// end function

        public function getMonsterBossCfgByMonsterId(param1:int) : QMonsterBossQcfg
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this.bossDic[param1];
            if (!_loc_2)
            {
                for each (_loc_3 in this._map)
                {
                    
                    if (_loc_3.q_monsterid == param1)
                    {
                        _loc_2 = new QMonsterBossQcfg();
                        _loc_2.parse(_loc_3);
                        _loc_4 = QSceneMonsterAreaBeanCfgObj.getInstance().getMonsterByModelIdAndMapId(_loc_2.q_monsterid, _loc_2.q_map);
                        _loc_2.q_map_x = _loc_4.q_center_x;
                        _loc_2.q_map_y = _loc_4.q_center_y;
                        this.bossDic[param1] = _loc_2;
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : QMonsterBossQcfgObj
        {
            if (!_instance)
            {
                _instance = new QMonsterBossQcfgObj;
            }
            return _instance;
        }// end function

    }
}
