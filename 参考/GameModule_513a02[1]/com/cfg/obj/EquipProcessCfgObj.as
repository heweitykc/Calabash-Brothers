package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class EquipProcessCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:EquipProcessCfgObj;

        public function EquipProcessCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_item_add_attribute");
            return;
        }// end function

        public function getEquipProcessinfoByLev(param1:String) : EquipProcessCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new EquipProcessCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : EquipProcessCfgObj
        {
            if (instance == null)
            {
                instance = new EquipProcessCfgObj;
            }
            return instance;
        }// end function

    }
}
