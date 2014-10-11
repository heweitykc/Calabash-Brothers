package com.game.shop.protocol
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.shop.message.*;
    import com.model.vo.*;

    public class ShopProtocol extends BaseProtocol
    {

        public function ShopProtocol()
        {
            return;
        }// end function

        public function buy(param1:ShopItemInfo, param2:int, param3:int = 0, param4:int = 1) : void
        {
            var _loc_5:* = new BuyItemMessage();
            _loc_5.costType = param2;
            _loc_5.modelId = param1.prop ? (param1.prop.itemModelId) : (0);
            _loc_5.npcId = param3;
            _loc_5.num = param4;
            _loc_5.sellId = param1.sellId;
            _loc_5.bindgold = param1.bindgold;
            _loc_5.gold = param1.gold;
            _loc_5.coin = param1.coin;
            _loc_5.originalGold = param1.originalGold;
            _loc_5.originalBindGold = param1.originalBindGold;
            _loc_5.originalCoin = param1.originalCoin;
            _loc_5.originalSoulDiamond = param1.q_show_souldiamond;
            _loc_5.soulDiamond = param1.q_souldiamond;
            send(_loc_5);
            return;
        }// end function

        public function buyFromOther(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int = 0, param11:int = 1) : void
        {
            var _loc_12:* = new BuyItemMessage();
            _loc_12.costType = param9;
            _loc_12.modelId = param8;
            _loc_12.npcId = param10;
            _loc_12.num = param11;
            _loc_12.sellId = param1;
            _loc_12.bindgold = 0;
            _loc_12.gold = param2;
            _loc_12.coin = param3;
            _loc_12.originalGold = param5;
            _loc_12.originalBindGold = 0;
            _loc_12.originalCoin = param4;
            _loc_12.originalSoulDiamond = param7;
            _loc_12.soulDiamond = param6;
            send(_loc_12);
            return;
        }// end function

        public function sell(param1:Vector.<long>) : void
        {
            var _loc_2:* = new ReqSellItemsMessage();
            _loc_2.itemId = param1;
            send(_loc_2);
            return;
        }// end function

        public function getItems(param1:int) : void
        {
            var _loc_2:* = new ReqShopListMessage();
            _loc_2.shopModelId = param1;
            _loc_2.page = 1;
            _loc_2.gradeLimit = 1;
            send(_loc_2);
            return;
        }// end function

    }
}
