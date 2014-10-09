package com.game.mall.utils
{
    import com.f1.utils.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.staticdata.*;
    import flash.display.*;

    public class IconUtil extends Object
    {

        public function IconUtil()
        {
            return;
        }// end function

        public static function getIcon(param1:int) : Bitmap
        {
            var _loc_2:* = null;
            if (param1 == CostType.COIN)
            {
                _loc_2 = "icon_gold";
            }
            else if (param1 == CostType.GOLD)
            {
                _loc_2 = "icon_diamond";
            }
            else if (param1 == CostType.BINDGOLD)
            {
                _loc_2 = "icon_bindedDiamond";
            }
            else
            {
                _loc_2 = "icon_souldiamond";
            }
            var _loc_3:* = ToolKit.getNewDO(_loc_2) as Bitmap;
            return _loc_3;
        }// end function

        public static function getIconSp(param1:int) : CurrencyIcon
        {
            var _loc_2:* = getIcon(param1);
            var _loc_3:* = new CurrencyIcon(param1);
            _loc_3.addChild(_loc_2);
            return _loc_3;
        }// end function

    }
}
