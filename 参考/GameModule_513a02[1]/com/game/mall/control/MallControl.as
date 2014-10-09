package com.game.mall.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.game.mall.model.*;
    import com.game.mall.view.*;
    import com.game.shop.control.*;
    import com.game.shop.model.*;
    import com.model.*;
    import flash.utils.*;

    public class MallControl extends Object
    {
        private var _mallPanel:MallPanel;
        private var _defaultId:int;
        public var diamondModel:int;
        public var vipModel:int;
        public var bindDiamondModel:int;
        private var _preTimer:int;
        private var _requestArr:Array;
        private var getItemTime:int;
        private static var _instance:MallControl;

        public function MallControl()
        {
            this.diamondModel = GlobalCfgObj.getInstance().getDiamondShop();
            this.vipModel = GlobalCfgObj.getInstance().getVipShop();
            this.bindDiamondModel = GlobalCfgObj.getInstance().getBindDiamondShop();
            return;
        }// end function

        public function openMall(param1:String = "", param2:int = 1) : void
        {
            if (this._mallPanel == null)
            {
                this._mallPanel = new MallPanel();
                Global.popManager.addPop(this._mallPanel);
            }
            if (param1 == "")
            {
                param1 = MallModel.GENERAL;
            }
            if (!this._mallPanel.isOpen)
            {
                MallModel.getInstance().modelType = param1;
            }
            var _loc_3:* = getTimer();
            if (this._preTimer == 0 || this._preTimer - _loc_3 > 600000)
            {
                this._preTimer = _loc_3;
                this.getShop();
            }
            this._mallPanel.openIndex = param2;
            this._mallPanel.openOrClose();
            return;
        }// end function

        public function getShop() : void
        {
            this._requestArr = MallModel.mallIds.concat(MallModel.jobHot[(UserObj.getInstance().playerInfo.job - 1)]);
            this.getItemTime = setInterval(this.getShopItem, 100);
            return;
        }// end function

        public function getShopItem() : void
        {
            var _loc_1:* = this._requestArr.splice(0, 1);
            if (_loc_1)
            {
                ShopController.getInstance().getItems(2, _loc_1);
            }
            else
            {
                clearInterval(this.getItemTime);
            }
            return;
        }// end function

        public function setType(param1:String) : void
        {
            MallModel.getInstance().modelType = param1;
            return;
        }// end function

        public function getList(param1:int) : Vector.<ShopItemInfo>
        {
            var _loc_2:* = MallModel.getInstance().getPageByIndex(MallModel.getInstance().modelType, param1);
            return _loc_2;
        }// end function

        public function addVip() : void
        {
            if (this._mallPanel && this._mallPanel.initComplete)
            {
                this._mallPanel.addVip();
            }
            return;
        }// end function

        public function getListTotal() : int
        {
            return MallModel.getInstance().getListTotal();
        }// end function

        public function getHot() : Vector.<ShopItemInfo>
        {
            var _loc_1:* = MallModel.getInstance().getHot();
            return _loc_1;
        }// end function

        public function acceptShopData(param1:ShopItemsInfo) : void
        {
            MallModel.getInstance().list = param1;
            if (!this._mallPanel.initComplete)
            {
                return;
            }
            if (param1.shopModelId == MallModel.getInstance().getCurShopModel())
            {
                this._mallPanel.setData(1);
            }
            if (param1.shopModelId == MallModel.jobHot[(UserObj.getInstance().playerInfo.job - 1)])
            {
                this._mallPanel.setHot();
            }
            return;
        }// end function

        public static function getInstance() : MallControl
        {
            var _loc_1:* = new MallControl;
            _instance = new MallControl;
            return _instance || _loc_1;
        }// end function

    }
}
