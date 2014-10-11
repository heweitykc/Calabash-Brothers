package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.*;

    public class TopActivateCfgObj extends Object
    {
        private var _cfg:Object;
        private static var instance:TopActivateCfgObj;

        public function TopActivateCfgObj()
        {
            this._cfg = CfgManager.getInstance().getMap("q_button_sort");
            return;
        }// end function

        public function getButtonSortId(param1:String) : int
        {
            if (this._cfg && this._cfg[param1])
            {
                return int(this._cfg[param1].q_sequence);
            }
            return 0;
        }// end function

        public function getButtonShowLevel(param1:String) : int
        {
            if (this._cfg && this._cfg[param1])
            {
                return int(this._cfg[param1].q_level);
            }
            return 0;
        }// end function

        public function getButtonByLevel(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            param1 = UserObj.getInstance().playerInfo.level;
            for each (_loc_3 in this._cfg)
            {
                
                if (param1 >= int(_loc_3.q_level) && int(_loc_3.q_level) != 999)
                {
                    _loc_2.push(_loc_3.q_function);
                }
            }
            return _loc_2;
        }// end function

        public static function getInstance() : TopActivateCfgObj
        {
            if (instance == null)
            {
                instance = new TopActivateCfgObj;
            }
            return instance;
        }// end function

    }
}
