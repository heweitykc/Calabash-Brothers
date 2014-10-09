package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.vo.*;

    public class ShopCfgObj extends Object
    {
        private var _map:Object;
        private var _shopitems:Object;
        private var _commonToolsItems:Object;
        private static var _instance:ShopCfgObj;
        public static const SHOP_INSIDE:int = 60001;
        public static const SHOP_TOOLS:int = 30001;
        public static const SELF_SHOP:int = 10000;

        public function ShopCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_shop");
            return;
        }// end function

        public function getShopItem(param1:int) : Object
        {
            return this._map[param1];
        }// end function

        public function getShopItemBySellId(param1:int, param2:int) : Object
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._map)
            {
                
                if (_loc_3.q_sell == param2 && _loc_3.q_model_id == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function getShopItemInfo(param1:int) : ShopItemInfo
        {
            var _loc_2:* = this._map[param1];
            var _loc_3:* = new ShopItemInfo();
            _loc_3.initByShopConfig(_loc_2);
            return _loc_3;
        }// end function

        public function getShopItemInfoFromInside(param1:int) : ShopItemInfo
        {
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._shopitems == null)
            {
                this._shopitems = new Object();
                for (_loc_2 in this._map)
                {
                    
                    if (_loc_6[_loc_2].q_model_id == SHOP_INSIDE)
                    {
                        _loc_3 = _loc_6[_loc_2];
                        _loc_4 = new ShopItemInfo();
                        _loc_4.initByShopConfig(_loc_3);
                        this._shopitems[_loc_4.itemModelId] = _loc_4;
                    }
                }
            }
            return this._shopitems[param1];
        }// end function

        public function getShopItems(param1:int, param2:int = 1) : Array
        {
            var _loc_4:* = null;
            var _loc_3:* = [];
            for each (_loc_4 in this._map)
            {
                
                if (_loc_4["q_model_id"] == param1 && _loc_4["q_shop_type"] == param2)
                {
                    _loc_3.push(_loc_4);
                }
            }
            return _loc_3;
        }// end function

        public static function getInstance() : ShopCfgObj
        {
            var _loc_1:* = new ShopCfgObj;
            _instance = new ShopCfgObj;
            return _instance || _loc_1;
        }// end function

    }
}
