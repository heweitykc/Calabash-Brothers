package com.cfg.obj
{
    import com.f1.manager.*;

    public class ExpEffectCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:ExpEffectCfgObj;

        public function ExpEffectCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_exp_effect");
            return;
        }// end function

        public function getExpEffectInfo(param1:int) : Object
        {
            if (this._map)
            {
                return this._map[param1];
            }
            return null;
        }// end function

        public function getExpEffectValue(param1:int) : int
        {
            if (this._map && this._map[param1])
            {
                return this._map[param1].q_exp_switch;
            }
            return 0;
        }// end function

        public static function getInstance() : ExpEffectCfgObj
        {
            if (instance == null)
            {
                instance = new ExpEffectCfgObj;
            }
            return instance;
        }// end function

    }
}
