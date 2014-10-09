package com.cfg.obj
{
    import com.f1.manager.*;
    import com.staticdata.*;

    public class PlayerCfgObj extends Object
    {
        private var _map1:Object;
        private var _mapExp:Object;
        private var _actCheck:Object;
        private static var instance:PlayerCfgObj;
        public static const ACT_IMMEDIATELY:uint = 1;
        public static const ACT_EFFECT_IMMEDIATELY:uint = 2;
        public static const ACT_IGNORE:uint = 3;

        public function PlayerCfgObj()
        {
            this._map1 = CfgManager.getInstance().getMap("roleresource");
            this._mapExp = CfgManager.getInstance().getMap("ExpCfg");
            this._actCheck = CfgManager.getInstance().getMap("actCheck");
            return;
        }// end function

        public function getPriObjByJob(param1:uint) : Object
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._map1)
            {
                
                if (_loc_2.job == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function getExp(param1:int) : Object
        {
            return this._mapExp[param1].q_exp;
        }// end function

        public function checkAct(param1:String, param2:String, param3:Boolean, param4:Boolean = true) : uint
        {
            var _loc_6:* = null;
            var _loc_5:* = ACT_IMMEDIATELY;
            if (!param4 && param1 != Params.ACTION_SIMPLE_HURT_ID)
            {
                return ACT_IMMEDIATELY;
            }
            if (param2)
            {
                _loc_6 = this._actCheck[param1];
                if (_loc_6)
                {
                    _loc_5 = _loc_6[param2];
                }
            }
            if (_loc_5 == this.ACT_EFFECT_IMMEDIATELY)
            {
                if (param3)
                {
                    _loc_5 = this.ACT_IMMEDIATELY;
                }
                else
                {
                    _loc_5 = this.ACT_IGNORE;
                }
            }
            return _loc_5;
        }// end function

        public static function getInstance() : PlayerCfgObj
        {
            if (instance == null)
            {
                instance = new PlayerCfgObj;
            }
            return instance;
        }// end function

    }
}
