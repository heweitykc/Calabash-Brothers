package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.vo.*;

    public class BuffCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:BuffCfgObj;

        public function BuffCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("buff");
            return;
        }// end function

        public function getBuffInfo(param1:uint) : BuffInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = this._map[param1];
            if (_loc_2)
            {
                _loc_3 = new BuffInfo();
                _loc_3.parse(_loc_2);
                return _loc_3;
            }
            return null;
        }// end function

        public static function getInstance() : BuffCfgObj
        {
            if (instance == null)
            {
                instance = new BuffCfgObj;
            }
            return instance;
        }// end function

    }
}
