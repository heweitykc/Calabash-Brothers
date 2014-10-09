package com.f1
{
    import com.f1.manager.*;

    public class LanguageCfgObj extends Object
    {
        private var _map:Object;
        private var _loginMap:Object;
        private static var instance:LanguageCfgObj;

        public function LanguageCfgObj()
        {
            return;
        }// end function

        public function getByIndex(param1:String, param2:String = "lang") : String
        {
            this._map = CfgManager.getInstance().getMap(param2);
            var _loc_3:* = "";
            if (this._map && this._map[param1])
            {
                _loc_3 = this._map[param1]["value"];
                if (_loc_3.charAt(0) == "\"")
                {
                    _loc_3 = _loc_3.substring(1);
                    if (_loc_3.charAt((_loc_3.length - 1)) == "\"")
                    {
                        _loc_3 = _loc_3.substring(0, (_loc_3.length - 1));
                    }
                    this._map[param1]["value"] = _loc_3;
                }
                return _loc_3;
            }
            else
            {
                return this.getByLoginIndex(param1);
            }
        }// end function

        public function getByLoginIndex(param1:String) : String
        {
            if (!this._loginMap)
            {
                this._loginMap = CfgManager.getInstance().getMap("login_lang");
            }
            if (this._loginMap && this._loginMap[param1])
            {
                return this._loginMap[param1]["value"];
            }
            return "";
        }// end function

        public static function getInstance() : LanguageCfgObj
        {
            if (instance == null)
            {
                instance = new LanguageCfgObj;
            }
            return instance;
        }// end function

    }
}
