package com.game.shop.view
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.shop.control.*;
    import com.game.shop.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ShopBuyPanel extends BaseBox
    {
        protected var _addBtn:BaseButton;
        protected var _subBtn:BaseButton;
        protected var _maxBtn:BaseButton;
        protected var _buyBtn:BaseButton;
        protected var _cancelBtn:BaseButton;
        protected var _input:TextField;
        protected var _icon:IconBase;
        protected var _iconSingle:Bitmap;
        protected var _iconTotal:Bitmap;
        protected var _singlePrice:TextField;
        protected var _image:Image;
        protected var _countTxt:TextField;
        protected var _nameTxt:TextField;
        private var _itemContainer:Sprite;
        protected var _info:ShopItemInfo;
        protected var _class:String;
        private var _maxCount:int;
        private var _count:int;
        private var _price:int;
        private var _activeSp:int;
        private var _costType:int;
        private var _closeBtn:BaseButton;
        private var _totalprice:TextField;
        private var _preTimer:int;
        private var _initCount:int;
        private var _needPaid:int;

        public function ShopBuyPanel()
        {
            _peaceBox = ["com.game.backpack.view::BackPackPanel", "com.game.shop.view::ShopPanel"];
            loadDisplay("res/shopbuy.swf");
            return;
        }// end function

        public function get info() : ShopItemInfo
        {
            return this._info;
        }// end function

        public function set info(param1:ShopItemInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("shopbuypanel");
            this.initUI();
            this.addListener();
            if (this._info)
            {
                this.update();
            }
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._addBtn = new BaseButton(getDisplayChildByName("btn_add"));
            this._subBtn = new BaseButton(getDisplayChildByName("btn_sub"));
            this._maxBtn = new BaseButton(getDisplayChildByName("btn_max"));
            this._maxBtn.setText("MAX");
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("11134"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11135"));
            this._input = getDisplayChildByName("txt_count");
            this._input.restrict = "0-9";
            this._input.maxChars = 13;
            this._itemContainer = getDisplayChildByName("container");
            this._icon = new IconItem("shopboxbg");
            this._icon.x = 30;
            this._icon.y = 15;
            this._icon.image.x = 5;
            this._icon.image.y = 5;
            this._icon.setImageSize(56, 56);
            this._itemContainer.addChild(this._icon);
            this._countTxt = this._itemContainer.getChildByName("txt_numcount") as TextField;
            this._nameTxt = this._itemContainer.getChildByName("txt_name") as TextField;
            this._singlePrice = this._itemContainer.getChildByName("txt_price") as TextField;
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._totalprice = getDisplayChildByName("txt_totalprice");
            return;
        }// end function

        private function addListener() : void
        {
            this._addBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._subBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._maxBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._buyBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._cancelBtn.addEventListener(MouseEvent.CLICK, this.__btnClick);
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_MONEY, this.__updateMoney);
            this._input.addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            UserObj.getInstance().playerInfo.removeEvtListener(RoleEvent.UPDATE_MONEY, this.__updateMoney);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function checkCount() : void
        {
            if (this._count > this._maxCount)
            {
                this._count = this._maxCount;
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_MONEY, this.__updateMoney);
            }
            return;
        }// end function

        private function __inputChange(event:Event) : void
        {
            var _loc_2:* = int(this._input.text);
            _loc_2 = Math.min(_loc_2, this._maxCount);
            _loc_2 = Math.max(_loc_2, 1);
            this._count = _loc_2;
            this.changeCount(this._count);
            if (this._count == 1)
            {
                this._input.setSelection(0, 1);
            }
            return;
        }// end function

        private function __updateMoney(event:RoleEvent) : void
        {
            this.changeCount(this._count);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            switch(event.target)
            {
                case this._buyBtn:
                {
                    _loc_2 = getTimer();
                    if (this._preTimer != 0 && _loc_2 - this._preTimer < 200)
                    {
                        return;
                    }
                    this._preTimer = _loc_2;
                    if (this._costType == CostType.COIN)
                    {
                        if (this._needPaid > UserObj.getInstance().playerInfo.money)
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11136"));
                            FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
                            return;
                        }
                    }
                    else if (this._costType == CostType.GOLD)
                    {
                        if (this._needPaid > UserObj.getInstance().playerInfo.gold)
                        {
                            MapControl.getInstance().showRechargeD();
                            return;
                        }
                    }
                    else if (this._costType == CostType.BINDGOLD)
                    {
                        if (this._needPaid > UserObj.getInstance().playerInfo.bindgold)
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11137"));
                            return;
                        }
                    }
                    else if (this._costType == CostType.SOULDIAMOND)
                    {
                        if (this._needPaid > BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND))
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11138"));
                            return;
                        }
                    }
                    ShopController.getInstance().buy(this._info, this._costType, this._info.npc, this._count);
                    this.close();
                    break;
                }
                case this._cancelBtn:
                {
                    this.close();
                    break;
                }
                case this._maxBtn:
                {
                    this.count("max");
                    break;
                }
                case this._addBtn:
                {
                    this.count("add");
                    break;
                }
                case this._subBtn:
                {
                    this.count("sub");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function count(param1:String) : void
        {
            switch(param1)
            {
                case "add":
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._count + 1;
                    _loc_2._count = _loc_3;
                    this._count = Math.min(this._maxCount, this._count);
                    break;
                }
                case "sub":
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this._count - 1;
                    _loc_2._count = _loc_3;
                    this._count = Math.max(1, this._count);
                    break;
                }
                case "max":
                {
                    this._count = this._maxCount;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.changeCount(this._count);
            return;
        }// end function

        public function acceptParam(... args) : void
        {
            this._info = args[0];
            this._initCount = args[1];
            if (this._initCount == -1)
            {
                Log.error("数量为负");
            }
            if (this._info == null)
            {
                Log.error("没有物品");
            }
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function update() : void
        {
            this._icon.setInfo(this._info.prop);
            var _loc_1:* = ShopUtils.checkMaxCount(this._info);
            if (_loc_1.length != 3)
            {
                Log.error("wrong");
            }
            this._maxCount = Math.min(_loc_1[2], 500);
            this._maxCount = Math.min(this._maxCount, 1500);
            this._count = this._initCount;
            this._activeSp = this._info.moneyType.length;
            if (this._info.moneyType)
            {
                this._costType = this._info.moneyType[0];
            }
            if (_loc_1[0])
            {
                this.drawType(_loc_1[0]);
                if (_loc_1[0])
                {
                    this._price = _loc_1[1];
                }
            }
            this.changeCount(this._count);
            this._nameTxt.htmlText = this._info.prop.q_name.toString();
            this._countTxt.htmlText = this._info.prop.q_max.toString();
            return;
        }// end function

        private function drawType(param1:int) : void
        {
            if (param1 == CostType.COIN)
            {
                this._class = "icon_gold";
                this._singlePrice.htmlText = ToolKit.getMoneyString(this._info.coin);
            }
            else if (param1 == CostType.GOLD)
            {
                this._class = "icon_diamond";
                this._singlePrice.htmlText = ToolKit.getMoneyString(this._info.gold);
            }
            else if (param1 == CostType.BINDGOLD || param1 == CostType.SOULDIAMOND)
            {
                this._class = "icon_bindedDiamond";
                this._singlePrice.htmlText = ToolKit.getMoneyString(this._info.bindgold);
            }
            else if (param1 == CostType.SOULDIAMOND)
            {
                this._class = "icon_souldiamond";
                this._singlePrice.htmlText = ToolKit.getMoneyString(this._info.q_souldiamond);
            }
            this.drawIcon(this._class);
            return;
        }// end function

        private function drawIcon(param1:String) : void
        {
            if (this._iconSingle && this._iconSingle.parent)
            {
                this._iconSingle.parent.removeChild(this._iconSingle);
                this._iconTotal.parent.removeChild(this._iconTotal);
            }
            this._iconSingle = ToolKit.getNewDO(param1) as Bitmap;
            this._iconSingle.x = this._singlePrice.x - this._iconSingle.width - 2;
            this._iconSingle.y = this._singlePrice.y;
            this._iconTotal = ToolKit.getNewDO(param1) as Bitmap;
            this._iconTotal.x = this._totalprice.x - this._iconTotal.width - 2;
            this._iconTotal.y = this._totalprice.y;
            this._itemContainer.addChild(this._iconSingle);
            addChild(this._iconTotal);
            return;
        }// end function

        private function changeCount(param1:int) : void
        {
            var _loc_6:* = 0;
            if (param1 < 1)
            {
                param1 = 1;
            }
            this._input.text = param1.toString();
            var _loc_2:* = this._info.bindgold * param1;
            var _loc_3:* = this._info.gold * param1;
            var _loc_4:* = this._info.coin * param1;
            var _loc_5:* = this._info.q_souldiamond * param1;
            if (this._costType == CostType.COIN)
            {
                this.setTotalPrice(_loc_4, UserObj.getInstance().playerInfo.money);
            }
            else if (this._costType == CostType.GOLD)
            {
                this.setTotalPrice(_loc_3, UserObj.getInstance().playerInfo.gold);
            }
            else if (this._costType == CostType.BINDGOLD)
            {
                this.setTotalPrice(_loc_2, UserObj.getInstance().playerInfo.bindgold);
            }
            else if (this._costType == CostType.SOULDIAMOND)
            {
                _loc_6 = BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND);
                this.setTotalPrice(_loc_5, _loc_6);
            }
            this._count = int(this._input.text);
            return;
        }// end function

        private function setTotalPrice(param1:Number, param2:int) : void
        {
            var _loc_3:* = 0;
            if (param1 <= param2)
            {
                _loc_3 = 65280;
            }
            else
            {
                _loc_3 = 16711680;
            }
            this._needPaid = param1;
            this._totalprice.htmlText = "<font color = \'#" + _loc_3.toString(16) + "\'>" + param1 + "</font>";
            return;
        }// end function

    }
}
