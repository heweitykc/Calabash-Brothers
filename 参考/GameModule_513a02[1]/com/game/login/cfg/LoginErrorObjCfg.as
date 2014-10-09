package com.game.login.cfg
{
    import com.f1.manager.*;

    public class LoginErrorObjCfg extends Object
    {
        private var _map:Object;
        private static var instance:LoginErrorObjCfg;

        public function LoginErrorObjCfg()
        {
            this._map = CfgManager.getInstance().getMap("errorsysmsg");
            return;
        }// end function

        public function getTableFromIDType(param1:int, param2:int) : LoginErrorTable
        {
            var _loc_4:* = null;
            var _loc_3:* = this._map[param1 + "_" + param2];
            if (_loc_3)
            {
                _loc_4 = new LoginErrorTable();
                _loc_4.parse(_loc_3);
                return _loc_4;
            }
            return null;
        }// end function

        public static function getInstance() : LoginErrorObjCfg
        {
            if (!instance)
            {
                instance = new LoginErrorObjCfg;
            }
            return instance;
        }// end function

    }
}
