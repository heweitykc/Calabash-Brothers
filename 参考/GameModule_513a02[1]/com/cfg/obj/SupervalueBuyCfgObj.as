package com.cfg.obj
{
    import com.f1.manager.*;

    public class SupervalueBuyCfgObj extends Object
    {
        private var _map:Object;
        private static var _instance:SupervalueBuyCfgObj;
        private static var _inst:SupervalueBuyCfgObj;

        public function SupervalueBuyCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_payui");
            return;
        }// end function

        public function getSupervalueById(param1:int) : Object
        {
            if (this._map && this._map[param1])
            {
                return this._map[param1];
            }
            throw new Error("q_payui缺少", param1);
        }// end function

        public static function getInstance() : SupervalueBuyCfgObj
        {
            var _loc_1:* = new SupervalueBuyCfgObj;
            _inst = new SupervalueBuyCfgObj;
            return _inst || _loc_1;
        }// end function

    }
}
