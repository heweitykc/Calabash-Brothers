package com.game.shop.handler
{
    import __AS3__.vec.*;
    import com.game.shop.control.*;
    import com.game.shop.message.*;
    import com.game.shop.model.*;
    import com.model.vo.*;
    import net.*;

    public class ResShopItemListHandler extends Handler
    {

        public function ResShopItemListHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_7:* = null;
            var _loc_1:* = ResShopItemListMessage(this.message);
            var _loc_2:* = new ShopItemsInfo();
            var _loc_3:* = new Vector.<ShopItemInfo>;
            var _loc_4:* = _loc_1.shopItemList.length;
            var _loc_5:* = new Vector.<ShopItemInfo>;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_7 = new ShopItemInfo();
                _loc_7.npc = _loc_1.shopModelId;
                _loc_7.con(_loc_1.shopItemList[_loc_6]);
                _loc_5.push(_loc_7);
                _loc_6++;
            }
            _loc_2.shopItemList = _loc_5;
            _loc_2.shopModelId = _loc_1.shopModelId;
            ShopController.getInstance().setPanelInfo(_loc_2);
            return;
        }// end function

    }
}
