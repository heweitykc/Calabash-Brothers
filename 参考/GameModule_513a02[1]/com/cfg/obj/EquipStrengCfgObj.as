package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class EquipStrengCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:EquipStrengCfgObj;

        public function EquipStrengCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_item_strength");
            return;
        }// end function

        public function getEquipStrenginfoByLev(param1:String) : EquipStrengCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new EquipStrengCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : EquipStrengCfgObj
        {
            if (instance == null)
            {
                instance = new EquipStrengCfgObj;
            }
            return instance;
        }// end function

    }
}
