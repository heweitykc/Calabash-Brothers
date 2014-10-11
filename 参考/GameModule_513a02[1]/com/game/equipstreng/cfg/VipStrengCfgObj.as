package com.game.equipstreng.cfg
{
    import com.f1.manager.*;

    public class VipStrengCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:VipStrengCfgObj;

        public function VipStrengCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_strenghten_vip");
            return;
        }// end function

        public function getVipStrengInfo(param1:int, param2:int) : Object
        {
            if (this._map)
            {
                return this._map[param1 + "_" + param2];
            }
            return null;
        }// end function

        public static function getInstance() : VipStrengCfgObj
        {
            if (instance == null)
            {
                instance = new VipStrengCfgObj;
            }
            return instance;
        }// end function

    }
}
