package com.game.shop.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.shop.control.*;
    import com.game.shop.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ShopItem extends Component
    {
        private var _backImg:Sprite;
        private var _icon:NeedIcon;
        private var _nameTxt:TextField;
        private var _priceTxt:TextField;
        private var _buyBtn:BaseButton;
        private var _info:ShopItemInfo;
        private var _iconBmp:Bitmap;
        private var _holder:DisplayObject;
        private var _bg:MovieClip;
        private var _tuijian:Sprite;
        private var _class:String;
        private var _price:int;

        public function ShopItem()
        {
            super.initComponentUI("shopitem");
            this._holder = getDisplayChildByName("holder");
            this._icon = new NeedIcon("shopboxbg");
            this._icon.setImageXY(6, 6);
            this._icon.setImageSize(56, 56);
            addChild(this._icon);
            this._icon.x = this._holder.x;
            this._icon.y = this._holder.y;
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._nameTxt = getDisplayChildByName("txt_name");
            this._priceTxt = getDisplayChildByName("txt_price");
            this._bg = getDisplayChildByName("bg");
            this._tuijian = getDisplayChildByName("mc_tuijian");
            this.addListener();
            return;
        }// end function

        public function get info() : ShopItemInfo
        {
            return this._info;
        }// end function

        public function set info(param1:ShopItemInfo) : void
        {
            var _loc_4:* = null;
            this._info = param1;
            this._icon.setInfo(this._info.prop);
            var _loc_2:* = ShopUtils.checkMaxCount(param1);
            this._priceTxt.htmlText = ToolKit.getMoneyString(_loc_2[1]);
            var _loc_3:* = PropUtil.getEquipNameAndColor(param1.prop);
            this._nameTxt.htmlText = "<font color =\'#" + _loc_3[1].toString(16) + "\'>" + _loc_3[0] + "</font>";
            if (_loc_2[0])
            {
                if (_loc_2[0] == CostType.COIN)
                {
                    _loc_4 = "icon_gold";
                }
                else if (_loc_2[0] == CostType.GOLD)
                {
                    _loc_4 = "icon_diamond";
                }
                else if (_loc_2[0] == CostType.BINDGOLD || _loc_2[0] == CostType.SOULDIAMOND)
                {
                    _loc_4 = "icon_bindedDiamond";
                }
                this.drawIcon(_loc_4);
                if (_loc_2[0])
                {
                    this._price = _loc_2[1];
                }
            }
            var _loc_5:* = UserObj.getInstance().playerInfo.level;
            if (UserObj.getInstance().playerInfo.level >= this._info.q_suitable_level_min && _loc_5 <= this._info.q_suitable_level_max)
            {
                this._tuijian.visible = true;
            }
            else
            {
                this._tuijian.visible = false;
            }
            if (_loc_5 < this._info.prop.q_level)
            {
                this._icon.iconMask.visible = true;
            }
            else
            {
                this._icon.iconMask.visible = false;
            }
            return;
        }// end function

        private function drawIcon(param1:String) : void
        {
            if (this._class != param1)
            {
                if (this._iconBmp && this._iconBmp.parent)
                {
                    this._iconBmp.parent.removeChild(this._iconBmp);
                }
                this._iconBmp = ToolKit.getNewDO(param1) as Bitmap;
                this._iconBmp.x = this._priceTxt.x - this._iconBmp.width;
                this._iconBmp.y = this._priceTxt.y;
                addChild(this._iconBmp);
                this._class = param1;
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._buyBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(2);
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            this._bg.gotoAndStop(1);
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this._buyBtn:
                {
                    if (ShopController.getInstance().autoGroup)
                    {
                        _loc_2 = ShopUtils.checkMaxCount(this._info);
                        if (_loc_2.length != 3)
                        {
                            Log.error("wrong count");
                        }
                        ShopController.getInstance().buy(this._info, _loc_2[0], this._info.npc, this._info.prop.q_max);
                    }
                    else
                    {
                        ShopController.getInstance().openBuyItem(this._info);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
