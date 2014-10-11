package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;
    import flash.utils.*;

    public class NpcCfgObj extends Object
    {
        private var _map:Object;
        private var _mapNpcList:Dictionary;
        private static var _instance:NpcCfgObj;

        public function NpcCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("npc");
            this.prepareMapNpcCfg();
            return;
        }// end function

        private function prepareMapNpcCfg() : void
        {
            var _loc_1:* = null;
            this._mapNpcList = new Dictionary();
            for each (_loc_1 in this._map)
            {
                
                if (!this._mapNpcList[_loc_1.q_map])
                {
                    this._mapNpcList[_loc_1.q_map] = [];
                }
                this._mapNpcList[_loc_1.q_map].push(_loc_1.q_id);
            }
            return;
        }// end function

        public function getNpcByID(param1:String) : NpcCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new NpcCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public function getNpcIDListByMapID(param1:String) : Array
        {
            if (!this._mapNpcList[param1])
            {
                return [];
            }
            return this._mapNpcList[param1];
        }// end function

        public static function getInstance() : NpcCfgObj
        {
            if (_instance == null)
            {
                _instance = new NpcCfgObj;
            }
            return _instance;
        }// end function

    }
}
