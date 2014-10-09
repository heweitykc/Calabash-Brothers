package com.cfg.obj
{
    import com.f1.manager.*;

    public class BackpackOpenCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:BackpackOpenCfgObj;

        public function BackpackOpenCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_backpack_grid");
            return;
        }// end function

        public function getCost(param1:String) : Object
        {
            var _loc_2:* = this._map[param1];
            return _loc_2;
        }// end function

        public static function getInstance() : BackpackOpenCfgObj
        {
            if (instance == null)
            {
                instance = new BackpackOpenCfgObj;
            }
            return instance;
        }// end function

    }
}
