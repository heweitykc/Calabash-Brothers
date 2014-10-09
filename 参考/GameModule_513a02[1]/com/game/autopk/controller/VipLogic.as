package com.game.autopk.controller
{
    import com.cfg.obj.*;
    import com.game.autopk.model.*;
    import com.game.shop.control.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.utils.*;

    public class VipLogic extends Object
    {
        private static var lastbuyTime:int;
        private static const LIMIT:int = 5000;

        public function VipLogic()
        {
            return;
        }// end function

        public static function buyHp() : void
        {
            if (UserObj.getInstance().playerInfo.vipid <= 0)
            {
                return;
            }
            if (!AutoFightModel.autoBuyBlood)
            {
                return;
            }
            var _loc_1:* = getTimer();
            if (_loc_1 - lastbuyTime < LIMIT)
            {
                return;
            }
            SellLogic.autoSell();
            var _loc_2:* = 1;
            var _loc_3:* = 0;
            var _loc_4:* = 99;
            var _loc_5:* = AutoFightModel.autoBuyBloodType;
            var _loc_6:* = DrinkLogic.BLOOD_IDS[_loc_5];
            var _loc_7:* = ShopCfgObj.getInstance().getShopItemBySellId(ShopCfgObj.SELF_SHOP, _loc_6);
            var _loc_8:* = new ShopItemInfo();
            _loc_8.initByShopConfig(_loc_7);
            _loc_8.npc = 0;
            ShopController.getInstance().buy(_loc_8, _loc_2, _loc_3, _loc_4);
            lastbuyTime = _loc_1;
            return;
        }// end function

        public static function buyMp() : void
        {
            var _loc_4:* = null;
            if (UserObj.getInstance().playerInfo.vipid <= 0)
            {
                return;
            }
            if (!AutoFightModel.autoBuyMagic)
            {
                return;
            }
            var _loc_1:* = getTimer();
            if (_loc_1 - lastbuyTime < LIMIT)
            {
                return;
            }
            SellLogic.autoSell();
            var _loc_2:* = 1;
            var _loc_3:* = 0;
            var _loc_5:* = 99;
            var _loc_6:* = AutoFightModel.autoBuyMagicType;
            var _loc_7:* = DrinkLogic.MAGIC_IDS[_loc_6];
            _loc_4 = ShopCfgObj.getInstance().getShopItemBySellId(ShopCfgObj.SELF_SHOP, _loc_7);
            var _loc_8:* = new ShopItemInfo();
            _loc_8.initByShopConfig(_loc_4);
            _loc_8.npc = 0;
            ShopController.getInstance().buy(_loc_8, _loc_2, _loc_3, _loc_5);
            lastbuyTime = _loc_1;
            return;
        }// end function

    }
}
