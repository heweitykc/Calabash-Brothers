package com.game.mall.view
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;

    public class HotItem extends MallItem
    {

        public function HotItem(param1, param2:String = null)
        {
            super(param1);
            return;
        }// end function

        override protected function initUI() : void
        {
            _icon = new IconItem("mall_icon");
            _icon.image.x = 5;
            _icon.image.y = 5;
            _icon.move(0, 2);
            _icon.setImageSize(56, 56);
            addChild(_icon);
            _nameTxt = getDisplayChildByName("txt_name");
            _priceSp = new PriceSP(getDisplayChildByName("txt_price"));
            _buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            _buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10916"));
            return;
        }// end function

        override protected function update() : void
        {
            _icon.setInfo(_info.prop);
            switch(int(_info.moneyType[0]))
            {
                case CostType.COIN:
                {
                    _priceSp.setPrice(0, CostType.COIN, _info.coin);
                    break;
                }
                case CostType.GOLD:
                {
                    _priceSp.setPrice(0, CostType.GOLD, _info.gold);
                    break;
                }
                case CostType.BINDGOLD:
                {
                    _priceSp.setPrice(0, CostType.BINDGOLD, _info.bindgold);
                    break;
                }
                case CostType.SOULDIAMOND:
                {
                    _priceSp.setPrice(1, CostType.SOULDIAMOND, _info.q_souldiamond);
                    break;
                }
                default:
                {
                    break;
                }
            }
            var _loc_1:* = PropUtil.getEquipNameAndColor(_info.prop);
            _nameTxt.htmlText = "<b>" + _loc_1[0] + "</b>";
            _nameTxt.textColor = _loc_1[1];
            return;
        }// end function

    }
}
