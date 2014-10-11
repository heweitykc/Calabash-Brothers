package com.cfg.obj
{
    import com.f1.manager.*;

    public class EquipAppendCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:EquipAppendCfgObj;

        public function EquipAppendCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("equip_append");
            return;
        }// end function

        public function getEquipAppendById(param1:int) : EquipAppendCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new EquipAppendCfg();
            return _loc_2;
        }// end function

        public static function getInstance() : EquipAppendCfgObj
        {
            if (instance == null)
            {
                instance = new EquipAppendCfgObj;
            }
            return instance;
        }// end function

    }
}
