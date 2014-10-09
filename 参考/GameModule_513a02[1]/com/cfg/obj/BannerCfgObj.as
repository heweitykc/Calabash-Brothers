package com.cfg.obj
{
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class BannerCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:BannerCfgObj;

        public function BannerCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("bannerconfig");
            return;
        }// end function

        public function getGuildBannerinfoByLev(param1:int) : BannerCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new BannerCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : BannerCfgObj
        {
            if (instance == null)
            {
                instance = new BannerCfgObj;
            }
            return instance;
        }// end function

    }
}
