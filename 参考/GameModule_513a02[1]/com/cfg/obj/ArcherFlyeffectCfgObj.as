package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class ArcherFlyeffectCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:ArcherFlyeffectCfgObj;

        public function ArcherFlyeffectCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("Archer_flyeffect");
            return;
        }// end function

        public function getArcherFlyeffectByWeaponId(param1:uint) : ArcherFlyeffect
        {
            var _loc_2:* = new ArcherFlyeffect();
            if (this._map[param1])
            {
                _loc_2.parse(this._map[param1]);
            }
            else
            {
                _loc_2.parse(this._map[1]);
            }
            return _loc_2;
        }// end function

        public static function getInstance() : ArcherFlyeffectCfgObj
        {
            if (_instance == null)
            {
                _instance = new ArcherFlyeffectCfgObj;
            }
            return _instance;
        }// end function

    }
}
