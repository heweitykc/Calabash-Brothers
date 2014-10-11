package com.game.role.control
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.shop.control.*;
    import com.game.shop.model.*;
    import com.game.shop.view.*;
    import com.model.vo.*;

    public class NpcShopControl extends Object
    {
        private static var _instance:NpcShopControl;

        public function NpcShopControl()
        {
            return;
        }// end function

        public function showNpcShopByCfg(param1:NpcCfg) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_2:* = param1._shop;
            ShopController.getInstance().shopKey(true);
            var _loc_3:* = ShopController.getInstance().shopPanel;
            if (_loc_3.isOpen)
            {
                _loc_4 = new ShopItemsInfo();
                _loc_4.npcId = param1._npcModelId;
                _loc_4.shopModelId = param1._npcModelId;
                _loc_5 = new Vector.<ShopItemInfo>;
                _loc_6 = _loc_2.split(";");
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    _loc_10 = ShopCfgObj.getInstance().getShopItems(_loc_6[_loc_7]);
                    _loc_11 = 0;
                    while (_loc_11 < _loc_10.length)
                    {
                        
                        _loc_12 = new ShopItemInfo();
                        _loc_12.initByShopConfig(_loc_10[_loc_11]);
                        _loc_12.npc = _loc_4.shopModelId;
                        _loc_5.push(_loc_12);
                        _loc_11++;
                    }
                    _loc_7++;
                }
                _loc_8 = LanguageCfgObj.getInstance().getByIndex("11125");
                _loc_9 = param1._function.split(";");
                _loc_7 = 0;
                while (_loc_7 < _loc_9.length)
                {
                    
                    if (_loc_9[_loc_7].toString().indexOf("2|") == 0)
                    {
                        _loc_8 = _loc_9[_loc_7].toString().substr(2);
                        break;
                    }
                    _loc_7++;
                }
                _loc_4.title = _loc_8;
                _loc_4.shopItemList = _loc_5;
                _loc_3.info = _loc_4;
            }
            return;
        }// end function

        public static function getInstance() : NpcShopControl
        {
            var _loc_1:* = _instance || new NpcShopControl;
            _instance = _instance || new NpcShopControl;
            return _loc_1;
        }// end function

    }
}
