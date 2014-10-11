package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class EquipComposeCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:EquipComposeCfgObj;

        public function EquipComposeCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_equip_compose");
            return;
        }// end function

        public function getEquipComposeinfoByLev(param1:String) : EquipComposeCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new EquipComposeCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public function getMapByType(param1:int) : Object
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_2:* = new Object();
            for each (_loc_3 in this._map)
            {
                
                if (_loc_3.tabs_type == param1)
                {
                    _loc_4 = _loc_3.item_type;
                    _loc_2[_loc_4] = _loc_3;
                }
            }
            return _loc_2;
        }// end function

        public function getTypeByName(param1:String) : int
        {
            var _loc_2:* = undefined;
            for each (_loc_2 in this._map)
            {
                
                if (_loc_2.item_name == param1)
                {
                    return _loc_2.tabs_type;
                }
            }
            return 0;
        }// end function

        public static function getInstance() : EquipComposeCfgObj
        {
            if (instance == null)
            {
                instance = new EquipComposeCfgObj;
            }
            return instance;
        }// end function

    }
}
