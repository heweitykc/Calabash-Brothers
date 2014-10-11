package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.vo.*;

    public class QEHeartCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:QEHeartCfgObj;

        public function QEHeartCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_eheart");
            return;
        }// end function

        public function getItem(param1:int) : ElementHeartInfo
        {
            var _loc_2:* = new ElementHeartInfo();
            _loc_2.parse(this._map[param1]);
            return _loc_2;
        }// end function

        public function getNextLevel(param1:int, param2:int) : ElementHeartInfo
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_4:* = 0;
            while (_loc_4 <= 20)
            {
                
                _loc_3 = this._map[param1 + _loc_4];
                if (!_loc_3)
                {
                    return null;
                }
                if (_loc_3.q_exp_max > param2)
                {
                    _loc_5 = new ElementHeartInfo();
                    _loc_5.parse(_loc_3);
                    return _loc_5;
                }
                _loc_4++;
            }
            return null;
        }// end function

        public static function getInstance() : QEHeartCfgObj
        {
            if (!_instance)
            {
                _instance = new QEHeartCfgObj;
            }
            return _instance;
        }// end function

    }
}
