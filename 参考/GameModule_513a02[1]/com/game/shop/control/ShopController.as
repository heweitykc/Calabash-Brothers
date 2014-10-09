package com.game.shop.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.mall.control.*;
    import com.game.map.control.*;
    import com.game.player.control.*;
    import com.game.shop.model.*;
    import com.game.shop.protocol.*;
    import com.game.shop.view.*;
    import com.model.*;
    import com.model.vo.*;

    public class ShopController extends Object
    {
        private var _protocol:ShopProtocol;
        private var _buyPanel:ShopBuyPanel;
        private var _oneKey:OneKeyPanel;
        private var _shopPanel:ShopPanel;
        private var _requireObj:Object;
        public var autoGroup:Boolean;
        private var _supervaluePanel:SuperValueBuyPanel;
        private static var _instance:ShopController;

        public function ShopController()
        {
            this._requireObj = new Object();
            this._protocol = new ShopProtocol();
            return;
        }// end function

        public function get shopPanel() : ShopPanel
        {
            return this._shopPanel;
        }// end function

        public function buy(param1:ShopItemInfo, param2:int, param3:int, param4:int = 1) : void
        {
            this._protocol.buy(param1, param2, param3, param4);
            return;
        }// end function

        public function buyFromOther(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int = 0, param11:int = 1) : void
        {
            this._protocol.buyFromOther(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            return;
        }// end function

        public function isShopOpen() : Boolean
        {
            return this._shopPanel && this._shopPanel.isOpen;
        }// end function

        public function openBuyItem(param1:ShopItemInfo, param2:int = 1) : ShopBuyPanel
        {
            if (this._buyPanel == null)
            {
                this._buyPanel = new ShopBuyPanel();
                Global.popManager.addPop(this._buyPanel, true, true, true, true, false, true);
            }
            this._buyPanel.acceptParam(param1, param2);
            this._buyPanel.open();
            return this._buyPanel;
        }// end function

        public function setPanelInfo(param1:ShopItemsInfo) : void
        {
            if (this._requireObj)
            {
                if (this._requireObj[param1.shopModelId])
                {
                    if (this._requireObj[param1.shopModelId].type == 1)
                    {
                        this._requireObj[param1.shopModelId] = null;
                        return;
                    }
                    if (this._requireObj[param1.shopModelId].type == 2)
                    {
                        MallControl.getInstance().acceptShopData(param1);
                        this._requireObj[param1.shopModelId] = null;
                        return;
                    }
                }
            }
            if (this._shopPanel)
            {
                this._shopPanel.info = param1;
            }
            return;
        }// end function

        public function screenSell() : void
        {
            BackPackControl.getInstance().changeToSell();
            Global.primaryCursorManager.showSellIcon();
            return;
        }// end function

        public function cancelSell() : void
        {
            Global.primaryCursorManager.hide();
            BackPackControl.getInstance().closeSell(BackPackControl.SELL);
            if (this._shopPanel)
            {
                this._shopPanel.cancelSell();
            }
            return;
        }// end function

        public function openOneKey() : void
        {
            if (this._oneKey == null)
            {
                this._oneKey = new OneKeyPanel();
                Global.popManager.addPop(this._oneKey, true, false, true, true, false, true);
            }
            var _loc_1:* = BackPackControl.getInstance().getOneKeyitems();
            this._oneKey.list = _loc_1;
            this._oneKey.open();
            return;
        }// end function

        public function buySuperValue(param1:PropInfo) : void
        {
            BackPackControl.getInstance().useItemId(param1.itemId, 1);
            return;
        }// end function

        public function openSupervaluePanel(param1:PropInfo = null) : void
        {
            if (this._supervaluePanel == null)
            {
                this._supervaluePanel = new SuperValueBuyPanel();
                Global.popManager.addPop(this._supervaluePanel, true, false, true, true, false, true);
            }
            if (param1)
            {
                this._supervaluePanel.prop = param1;
            }
            this._supervaluePanel.open();
            return;
        }// end function

        public function openorcloseShop() : void
        {
            if (this._shopPanel == null)
            {
                this._shopPanel = new ShopPanel();
                Global.popManager.addPop(this._shopPanel);
            }
            var _loc_1:* = VipCfgObj.getInstance().getSelfShopCost(UserObj.getInstance().playerInfo.vipid);
            if (_loc_1 == 0 || this._shopPanel.isOpen)
            {
                if (!this._shopPanel.isOpen)
                {
                    this._protocol.getItems(10000);
                }
                this._shopPanel.openOrClose();
            }
            else
            {
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12183"), [_loc_1]), LanguageCfgObj.getInstance().getByIndex("11635"), [_loc_1], this.yesToOpenShop);
            }
            return;
        }// end function

        public function closeShop() : void
        {
            if (this._shopPanel == null)
            {
                return;
            }
            if (this._shopPanel.isOpen)
            {
                this._shopPanel.close();
            }
            return;
        }// end function

        public function openShop() : void
        {
            if (this._shopPanel == null)
            {
                this._shopPanel = new ShopPanel();
                Global.popManager.addPop(this._shopPanel);
            }
            if (UserObj.getInstance().playerInfo.pkValue > 0)
            {
                PlayerControl.getInstance().openBannerTips();
                return;
            }
            this._protocol.getItems(ShopCfgObj.SELF_SHOP);
            var _loc_1:* = VipCfgObj.getInstance().getSelfShopCost(UserObj.getInstance().playerInfo.vipid);
            if (_loc_1 == 0)
            {
                this._shopPanel.open();
            }
            else
            {
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12184"), [_loc_1]), LanguageCfgObj.getInstance().getByIndex("11635"), [_loc_1], this.yesToOpenShop);
            }
            return;
        }// end function

        private function yesToOpenShop(param1:int) : void
        {
            if (UserObj.getInstance().playerInfo.gold < param1)
            {
                MapControl.getInstance().showRechargeD();
            }
            else
            {
                this._protocol.getItems(10000);
                this._shopPanel.open();
            }
            return;
        }// end function

        public function shopKey(param1:Boolean) : void
        {
            if (param1)
            {
                if (this._shopPanel == null)
                {
                    this._shopPanel = new ShopPanel();
                    Global.popManager.addPop(this._shopPanel);
                }
                if (UserObj.getInstance().playerInfo.pkValue > 0)
                {
                    PlayerControl.getInstance().openBannerTips();
                    return;
                }
                this._shopPanel.open();
            }
            else
            {
                this._shopPanel.close();
            }
            return;
        }// end function

        public function getItems(param1:int, param2:int) : void
        {
            if (this._requireObj[param2] == null)
            {
                this._requireObj[param2] = {};
            }
            this._requireObj[param2].type = param1;
            this._requireObj[param2].shopid = param2;
            this._protocol.getItems(param2);
            return;
        }// end function

        public function sell(param1:Vector.<long>) : void
        {
            this._protocol.sell(param1);
            return;
        }// end function

        public static function getInstance() : ShopController
        {
            var _loc_1:* = new ShopController;
            _instance = new ShopController;
            return _instance || _loc_1;
        }// end function

    }
}
