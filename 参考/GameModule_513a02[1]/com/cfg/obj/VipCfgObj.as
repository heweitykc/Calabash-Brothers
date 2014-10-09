package com.cfg.obj
{
    import com.f1.manager.*;
    import com.staticdata.*;

    public class VipCfgObj extends Object
    {
        private var _map:Object;
        public var minLevel:int;
        public var maxLevel:int;
        private static var instance:VipCfgObj;

        public function VipCfgObj()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = 0;
            this._map = CfgManager.getInstance().getMap("q_vip");
            if (this._map)
            {
                this.minLevel = int.MAX_VALUE;
                this.maxLevel = int.MIN_VALUE;
                for (_loc_1 in this._map)
                {
                    
                    _loc_2 = _loc_1;
                    if (this.minLevel > _loc_2)
                    {
                        this.minLevel = _loc_2;
                    }
                    if (this.maxLevel < _loc_2)
                    {
                        this.maxLevel = _loc_2;
                    }
                }
            }
            return;
        }// end function

        public function getNowVipCnt(param1:uint) : uint
        {
            return 1;
        }// end function

        public function getVipInfo(param1:int) : Object
        {
            if (this._map)
            {
                return this._map[param1];
            }
            return null;
        }// end function

        public function getVipExp(param1:int) : int
        {
            if (this._map && this._map[param1])
            {
                return this._map[param1].q_exp;
            }
            return 0;
        }// end function

        public function getSelfShopCost(param1:int) : int
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_SHOP];
            }
            return 0;
        }// end function

        public function getVIPStore(param1:int) : int
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_STORE];
            }
            return 0;
        }// end function

        public function dungeonAdd(param1:int) : int
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_DEVIL];
            }
            return 0;
        }// end function

        public function bossHomeAdd(param1:int) : int
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_BOSSHOME];
            }
            return 0;
        }// end function

        public function wolfSoulAdd(param1:int) : int
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_WOLFSOUL];
            }
            return 0;
        }// end function

        public function isVIPforMall(param1:int) : Boolean
        {
            if (this._map[param1])
            {
                return this._map[param1][VIPFuncType.Q_STORE] == 1;
            }
            return false;
        }// end function

        public static function getInstance() : VipCfgObj
        {
            if (instance == null)
            {
                instance = new VipCfgObj;
            }
            return instance;
        }// end function

    }
}
