package com.game.mall.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.shop.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class MallItem extends Component implements IItem
    {
        protected var _icon:IconItem;
        protected var _orginalPriceSp:PriceSP;
        protected var _priceSp:PriceSP;
        protected var _buyBtn:BaseButton;
        protected var _info:ShopItemInfo;
        protected var _nameTxt:TextField;
        protected var _select:Boolean;
        protected var _hotBmp:Bitmap;
        protected var _recommendBmp:Bitmap;

        public function MallItem(param1, param2:String = null)
        {
            super.initComponentUI(param1);
            this.initUI();
            this.addlistener();
            return;
        }// end function

        public function get icon() : IconItem
        {
            return this._icon;
        }// end function

        public function set icon(param1:IconItem) : void
        {
            this._icon = param1;
            return;
        }// end function

        protected function initUI() : void
        {
            this._icon = new IconItem("mall_icon");
            this._icon.image.x = 5;
            this._icon.image.y = 5;
            this._icon.move(11, 36);
            this._icon.setImageSize(56, 56);
            addChild(this._icon);
            this._nameTxt = getDisplayChildByName("txt_name");
            this._priceSp = new PriceSP(getDisplayChildByName("txt_price"));
            this._orginalPriceSp = new PriceSP(getDisplayChildByName("txt_orginPrice"));
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10917"));
            return;
        }// end function

        public function get info() : ShopItemInfo
        {
            return this._info;
        }// end function

        public function set info(param1:ShopItemInfo) : void
        {
            this._info = param1;
            this.update();
            visible = true;
            return;
        }// end function

        protected function update() : void
        {
            var _loc_1:* = false;
            var _loc_2:* = null;
            this._icon.setInfo(this._info.prop);
            switch(int(this._info.moneyType[0]))
            {
                case CostType.COIN:
                {
                    if (this._info.originalCoin == this._info.coin || this._info.originalCoin == 0)
                    {
                        this._orginalPriceSp.visible = false;
                        this._priceSp.setPrice(0, CostType.COIN, this._info.coin);
                    }
                    else
                    {
                        this._orginalPriceSp.visible = true;
                        this._priceSp.setPrice(0, CostType.COIN, this._info.coin);
                        this._orginalPriceSp.setPrice(1, CostType.COIN, this._info.originalCoin);
                    }
                    break;
                }
                case CostType.GOLD:
                {
                    if (this._info.originalGold == this._info.gold || this._info.originalGold == 0)
                    {
                        this._orginalPriceSp.visible = false;
                        this._priceSp.setPrice(0, CostType.GOLD, this._info.gold);
                    }
                    else
                    {
                        this._orginalPriceSp.visible = true;
                        this._orginalPriceSp.setPrice(1, CostType.GOLD, this._info.originalGold);
                        this._priceSp.setPrice(0, CostType.GOLD, this._info.gold);
                    }
                    break;
                }
                case CostType.BINDGOLD:
                {
                    if (this._info.originalBindGold == this._info.bindgold || this._info.originalBindGold == 0)
                    {
                        this._orginalPriceSp.visible = false;
                        this._priceSp.setPrice(0, CostType.BINDGOLD, this._info.bindgold);
                    }
                    else
                    {
                        this._orginalPriceSp.visible = true;
                        this._orginalPriceSp.setPrice(1, CostType.BINDGOLD, this._info.originalBindGold);
                        this._priceSp.setPrice(0, CostType.BINDGOLD, this._info.bindgold);
                    }
                    break;
                }
                case CostType.SOULDIAMOND:
                {
                    if (this._info.q_show_souldiamond == this._info.q_souldiamond || this._info.q_show_souldiamond == 0)
                    {
                        this._orginalPriceSp.visible = false;
                        this._priceSp.setPrice(0, CostType.SOULDIAMOND, this._info.q_souldiamond);
                    }
                    else
                    {
                        this._orginalPriceSp.visible = true;
                        this._orginalPriceSp.setPrice(1, CostType.SOULDIAMOND, this._info.q_show_souldiamond);
                        this._priceSp.setPrice(0, CostType.SOULDIAMOND, this._info.q_souldiamond);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._nameTxt)
            {
                _loc_2 = PropUtil.getEquipNameAndColor(this._info.prop);
                this._nameTxt.htmlText = "<b>" + _loc_2[0] + "</b>";
                this._nameTxt.textColor = _loc_2[1];
            }
            return;
        }// end function

        public function get key()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this.info = param1;
            return;
        }// end function

        public function get obj()
        {
            return this._info;
        }// end function

        public function get label() : String
        {
            return "";
        }// end function

        public function get selected() : Boolean
        {
            return this._select;
        }// end function

        private function addlistener() : void
        {
            this._buyBtn.addEvtListener(MouseEvent.CLICK, this.__buyClick);
            return;
        }// end function

        private function __buyClick(event:MouseEvent) : void
        {
            ShopController.getInstance().openBuyItem(this.info);
            return;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            this._select = param1;
            return;
        }// end function

    }
}
