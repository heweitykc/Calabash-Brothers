package com.cfg.obj
{
    import __AS3__.vec.*;
    import com.f1.manager.*;
    import com.staticdata.*;

    public class QSignWageCfgObj extends Object
    {
        private var _mapSign:Object;
        private static var _instance:QSignWageCfgObj;

        public function QSignWageCfgObj()
        {
            this._mapSign = CfgManager.getInstance().getMap("q_sign_wage");
            return;
        }// end function

        public function getRewards(param1:int) : Array
        {
            var _loc_2:* = [];
            return this._mapSign[param1].q_reward.split("_");
        }// end function

        public function getVipRewards(param1:int) : Array
        {
            var _loc_2:* = [];
            return this._mapSign[param1].q_vip_reward.split("_");
        }// end function

        public function getType() : Vector.<int>
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<int>;
            for (_loc_3 in this._mapSign)
            {
                
                _loc_2 = int(_loc_3);
                if (_loc_2 != 0)
                {
                    _loc_1.push(_loc_2);
                }
            }
            _loc_1.sort(this.sortIntegers);
            return _loc_1;
        }// end function

        public function getProfessionRewards(param1:int, param2:int) : Array
        {
            switch(param2)
            {
                case JobType.WARRIOR:
                {
                    return this._mapSign[param1].q_reward1.split(";");
                }
                case JobType.MAGICER:
                {
                    return this._mapSign[param1].q_reward2.split(";");
                }
                case JobType.BOWMAN:
                {
                    return this._mapSign[param1].q_reward3.split(";");
                }
                default:
                {
                    break;
                }
            }
            return [];
        }// end function

        private function sortIntegers(param1:int, param2:int) : Number
        {
            if (param1 < param2)
            {
                return -1;
            }
            if (param1 > param2)
            {
                return 1;
            }
            return 0;
        }// end function

        public static function getInstance() : QSignWageCfgObj
        {
            if (_instance == null)
            {
                _instance = new QSignWageCfgObj;
            }
            return _instance;
        }// end function

    }
}
