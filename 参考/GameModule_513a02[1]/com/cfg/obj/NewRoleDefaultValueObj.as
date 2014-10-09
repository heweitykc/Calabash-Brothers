package com.cfg.obj
{
    import com.f1.manager.*;

    public class NewRoleDefaultValueObj extends Object
    {
        private var _map:Object;
        private static var instance:NewRoleDefaultValueObj;

        public function NewRoleDefaultValueObj()
        {
            this._map = CfgManager.getInstance().getMap("newrole_defaultvalue");
            return;
        }// end function

        public function getDefaultPoint(param1:int) : int
        {
            return int(this._map[param1].vitality) + int(this._map[param1].strength) + int(this._map[param1].agile) + int(this._map[param1].intelligence);
        }// end function

        public static function getInstance() : NewRoleDefaultValueObj
        {
            if (instance == null)
            {
                instance = new NewRoleDefaultValueObj;
            }
            return instance;
        }// end function

    }
}
