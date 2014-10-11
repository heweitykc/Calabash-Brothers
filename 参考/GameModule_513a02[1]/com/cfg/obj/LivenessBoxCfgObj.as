package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.f1.manager.*;

    public class LivenessBoxCfgObj extends Object
    {
        private var _map:Object;
        private static var _inst:LivenessBoxCfgObj;

        public function LivenessBoxCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_liveness_box");
            return;
        }// end function

        public function getBoxById(param1:int) : LivenessBoxCfg
        {
            var _loc_2:* = new LivenessBoxCfg();
            _loc_2.prase(this._map[param1]);
            return _loc_2;
        }// end function

        public function getType() : Vector.<int>
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<int>;
            for (_loc_3 in this._map)
            {
                
                _loc_2 = int(_loc_3);
                if (_loc_2 != 0)
                {
                    _loc_1.push(_loc_2);
                }
            }
            _loc_1.sort(this.sortIntegers);
            return _loc_1;
        }// end function

        private function sortIntegers(param1:int, param2:int) : Number
        {
            if (param1 < param2)
            {
                return -1;
            }
            if (param1 > param2)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function getInstance() : LivenessBoxCfgObj
        {
            var _loc_1:* = new LivenessBoxCfgObj;
            _inst = new LivenessBoxCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
