package com.game.stalls.cfg
{
    import com.f1.manager.*;

    public class StallsSearchCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:StallsSearchCfgObj;

        public function StallsSearchCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("StallsSearchCfg");
            return;
        }// end function

        public function get map() : Object
        {
            return this._map;
        }// end function

        public static function getInstance() : StallsSearchCfgObj
        {
            if (instance == null)
            {
                instance = new StallsSearchCfgObj;
            }
            return instance;
        }// end function

    }
}
