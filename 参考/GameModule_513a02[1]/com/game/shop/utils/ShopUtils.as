package com.game.shop.utils
{
    import com.game.backpack.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class ShopUtils extends Object
    {

        public function ShopUtils()
        {
            return;
        }// end function

        public static function checkMaxCount(param1:ShopItemInfo) : Array
        {
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = UserObj.getInstance().playerInfo;
            var _loc_4:* = BackpackObj.getInstance().getIdleCount(param1.prop);
            if (param1.limit_count != 0)
            {
                _loc_3 = param1.limit_count - param1.buy_count;
            }
            else
            {
                _loc_3 = -1;
            }
            if (param1.moneyType[0] == CostType.COIN)
            {
                _loc_5 = param1.prop.q_max * 5;
                _loc_6 = _loc_2.money / param1.coin >> 0;
                if (_loc_3 != -1)
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_3, _loc_5);
                }
                else
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_5);
                }
                return [CostType.COIN, param1.coin, _loc_6];
            }
            else if (param1.moneyType[0] == CostType.SOULDIAMOND)
            {
                _loc_5 = param1.prop.q_max;
                _loc_7 = BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND);
                _loc_6 = _loc_7 / param1.coin >> 0;
                if (_loc_3 != -1)
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_3, _loc_5);
                }
                else
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_5);
                }
                return [CostType.SOULDIAMOND, param1.q_souldiamond, _loc_6];
            }
            else if (param1.moneyType[0] == CostType.BINDGOLD)
            {
                _loc_5 = param1.prop.q_max;
                _loc_6 = _loc_2.bindgold / param1.bindgold >> 0;
                if (_loc_3 != -1)
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_3, _loc_5);
                }
                else
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_5);
                }
                return [CostType.BINDGOLD, param1.bindgold, _loc_6];
            }
            else if (param1.moneyType[0] == CostType.GOLD)
            {
                _loc_5 = param1.prop.q_max;
                _loc_6 = _loc_2.gold / param1.gold >> 0;
                if (_loc_3 != -1)
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_3, _loc_5);
                }
                else
                {
                    _loc_6 = Math.min(_loc_4, _loc_6, _loc_5);
                }
                return [CostType.GOLD, param1.gold, _loc_6];
            }
            return [];
        }// end function

        public static function getMoneyCount(param1:ShopItemInfo) : int
        {
            var _loc_2:* = UserObj.getInstance().playerInfo;
            if (param1.moneyType[0] == CostType.COIN)
            {
                return _loc_2.money;
            }
            if (param1.moneyType[0] == CostType.GOLD)
            {
                return _loc_2.gold;
            }
            if (param1.moneyType[0] == CostType.SOULDIAMOND)
            {
                return BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND);
            }
            if (param1.moneyType[0] == CostType.BINDGOLD)
            {
                return _loc_2.bindgold;
            }
            return 0;
        }// end function

        public static function isCanBuy(param1:ShopItemInfo, param2:int) : Array
        {
            var _loc_3:* = UserObj.getInstance().playerInfo;
            var _loc_4:* = 0;
            while (_loc_4 < param1.moneyType.length)
            {
                
                if (param1.moneyType[_loc_4] == CostType.COIN)
                {
                    if (_loc_3.money >= param1.coin * param2)
                    {
                        return [true, param1.moneyType[_loc_4]];
                    }
                    if (param1.moneyType[_loc_4] == CostType.GOLD)
                    {
                        return [_loc_3.gold >= param1.gold * param2 ? (true) : (false), param1.moneyType[_loc_4]];
                    }
                    else if (param1.moneyType[_loc_4] == CostType.SOULDIAMOND)
                    {
                        return [BackpackObj.getInstance().getItemCount(Params.SOUL_DIMAOND) >= param1.q_souldiamond * param2 ? (true) : (false), param1.moneyType[_loc_4]];
                    }
                    else if (param1.moneyType[_loc_4] == CostType.BINDGOLD)
                    {
                        return [_loc_3.bindgold >= param1.bindgold * param2 ? (true) : (false), param1.moneyType[_loc_4]];
                    }
                }
                _loc_4++;
            }
            return [false, 0];
        }// end function

    }
}
