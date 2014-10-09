package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class QBaptismStarCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:QBaptismStarCfgObj;

        public function QBaptismStarCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_baptism_star");
            return;
        }// end function

        public function getQBaptismStarInfoById(param1:String) : QBaptismStar
        {
            if (!this._map[param1])
            {
                return null;
            }
            var _loc_2:* = new QBaptismStar();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function getTotalByJob(param1:String, param2:int) : int
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = 0;
            for (_loc_4 in this._map)
            {
                
                if (_loc_4.charAt(0) == param1)
                {
                    _loc_5 = _loc_8[_loc_4].q_add_attribute.split(";");
                    _loc_6 = _loc_5[(param2 - 1)].split("_");
                    _loc_3 = _loc_3 + int(_loc_6[1]);
                }
            }
            return _loc_3;
        }// end function

        public static function getInstance() : QBaptismStarCfgObj
        {
            if (!_instance)
            {
                _instance = new QBaptismStarCfgObj;
            }
            return _instance;
        }// end function

    }
}
