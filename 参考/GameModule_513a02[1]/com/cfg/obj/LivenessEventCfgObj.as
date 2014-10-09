package com.cfg.obj
{
    import com.f1.manager.*;

    public class LivenessEventCfgObj extends Object
    {
        private var _map:Object;
        private static var _inst:LivenessEventCfgObj;

        public function LivenessEventCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_liveness_event");
            return;
        }// end function

        public function getEventById(param1:int) : Object
        {
            return this._map[param1];
        }// end function

        public function getCount() : int
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            for (_loc_2 in this._map)
            {
                
                if (int(_loc_2) != 0)
                {
                    _loc_1++;
                }
            }
            return _loc_1;
        }// end function

        public static function getInstance() : LivenessEventCfgObj
        {
            var _loc_1:* = new LivenessEventCfgObj;
            _inst = new LivenessEventCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
