package com.cfg.obj
{
    import com.f1.manager.*;

    public class QCastingCostCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:QCastingCostCfgObj;

        public function QCastingCostCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_casting_cost");
            return;
        }// end function

        public function getCostByLevel(param1:int) : int
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_4 in this._map)
            {
                
                _loc_2 = _loc_4.q_min_level;
                _loc_3 = _loc_4.q_max_level;
                if (_loc_2 <= param1 && param1 <= _loc_3)
                {
                    return _loc_4.q_cost_coin;
                }
            }
            return 0;
        }// end function

        public static function getInstance() : QCastingCostCfgObj
        {
            if (!_instance)
            {
                _instance = new QCastingCostCfgObj;
            }
            return _instance;
        }// end function

    }
}
