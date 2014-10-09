package com.cfg.obj
{
    import com.f1.manager.*;

    public class VIPShowCfgObj extends Object
    {
        private static var _map:Object;
        private static var _inst:VIPShowCfgObj;

        public function VIPShowCfgObj()
        {
            _map = CfgManager.getInstance().getMap("VipPermissionCtg");
            return;
        }// end function

        public function getImage(param1:int) : String
        {
            if (param1 > 0 && param1 < 10)
            {
                return _map[param1].q_pic;
            }
            return null;
        }// end function

        public function getProfession(param1:int) : String
        {
            var _loc_2:* = _map[param1].q_Permission;
            if (_loc_2.charAt(0) == "\"" && _loc_2.charAt((_loc_2.length - 1)) == "\"")
            {
                _loc_2 = _loc_2.substring(1, (_loc_2.length - 1));
            }
            return _loc_2;
        }// end function

        public function getDescription(param1:int, param2) : String
        {
            var _loc_3:* = _map[param1][param2];
            if (_loc_3.charAt(0) == "\"" && _loc_3.charAt((_loc_3.length - 1)) == "\"")
            {
                _loc_3 = _loc_3.substring(1, (_loc_3.length - 1));
            }
            return _loc_3;
        }// end function

        public function getVipTips(param1:int) : String
        {
            if (param1 == 0)
            {
                param1 = 1;
            }
            if (_map == null || _map[param1] == null)
            {
                return "";
            }
            var _loc_2:* = this.getInstance().getAttribute(param1, "q_attribute");
            if (_loc_2 == "" || _loc_2 == null)
            {
                _loc_2 = "{remain}";
            }
            if (_loc_2.charAt(0) == "\"" && _loc_2.charAt((_loc_2.length - 1)) == "\"")
            {
                _loc_2 = _loc_2.substring(1, (_loc_2.length - 1));
            }
            return _loc_2;
        }// end function

        public function getAttribute(param1:int, param2:String) : String
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_3:* = _map[param1][param2];
            if (_loc_3.charAt(0) == "\"" && _loc_3.charAt((_loc_3.length - 1)) == "\"")
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_3.length)
                {
                    
                    if (_loc_3.charAt(_loc_6) != "\"")
                    {
                        _loc_4 = _loc_6;
                        break;
                    }
                    _loc_6++;
                }
                _loc_6 = _loc_3.length - 1;
                while (_loc_6 > -1)
                {
                    
                    if (_loc_3.charAt(_loc_6) != "\"")
                    {
                        _loc_5 = _loc_6;
                        break;
                    }
                    _loc_6 = _loc_6 - 1;
                }
            }
            _loc_3 = _loc_3.substring(_loc_4, (_loc_5 + 1));
            return _loc_3;
        }// end function

        public function getTenOffline() : int
        {
            var _loc_1:* = 0;
            while (_loc_1 < 11)
            {
                
                if (int(_map[_loc_1].q_10Recover))
                {
                    return _loc_1;
                }
                _loc_1++;
            }
            return 0;
        }// end function

        public function getRightNum(param1:int) : String
        {
            return _map[param1].q_Droit_num;
        }// end function

        public static function getInstance() : VIPShowCfgObj
        {
            var _loc_1:* = new VIPShowCfgObj;
            _inst = new VIPShowCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
