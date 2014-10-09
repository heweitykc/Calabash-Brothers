package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class CloudBuyCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:CloudBuyCfgObj;

        public function CloudBuyCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_cloudshop");
            return;
        }// end function

        public function getCloudBuyInfoById(param1:int) : CloudBuyCfg
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new CloudBuyCfg();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public static function getInstance() : CloudBuyCfgObj
        {
            if (instance == null)
            {
                instance = new CloudBuyCfgObj;
            }
            return instance;
        }// end function

    }
}
