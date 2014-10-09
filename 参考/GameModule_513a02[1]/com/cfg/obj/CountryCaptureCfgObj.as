package com.cfg.obj
{
    import com.f1.manager.*;

    public class CountryCaptureCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:CountryCaptureCfgObj;

        public function CountryCaptureCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_hold_reward");
            return;
        }// end function

        public function getCaptureInfo() : Object
        {
            return this._map;
        }// end function

        public function getCaptureDays(param1:int) : int
        {
            if (this._map && this._map[param1])
            {
                return this._map[param1].q_day;
            }
            return 0;
        }// end function

        public static function getInstance() : CountryCaptureCfgObj
        {
            if (instance == null)
            {
                instance = new CountryCaptureCfgObj;
            }
            return instance;
        }// end function

    }
}
