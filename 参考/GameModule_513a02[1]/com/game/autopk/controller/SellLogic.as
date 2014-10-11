package com.game.autopk.controller
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.game.autopk.*;
    import com.game.autopk.model.*;
    import com.game.backpack.model.*;
    import com.game.backpack.util.*;
    import com.game.shop.control.*;
    import com.game.utils.*;
    import com.game.vip.model.*;
    import com.model.*;
    import com.model.vo.*;

    public class SellLogic extends Object
    {
        private static const UNSELL_LIST:Array = [310026, 320007, 330013, 310126, 320107, 330113, 311326, 321307, 331313, 1310026, 1320007, 1330013, 2310026, 2320007, 2330013, 1311326, 1321307, 1331313];

        public function SellLogic()
        {
            return;
        }// end function

        public static function autoSell() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_1:* = AutoFightManager.getInstance().isAutoFighting();
            if (!_loc_1)
            {
                return;
            }
            if (AutoFightModel.fightSell == 0)
            {
                return;
            }
            if (BackpackObj.getInstance().isLessThan(5) == false)
            {
                return;
            }
            var _loc_2:* = BackpackObj.getInstance().getGoodsByType();
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = new Vector.<long>;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2[_loc_5];
                _loc_7 = sellCheck(_loc_6);
                if (_loc_7)
                {
                    _loc_4.push(_loc_6.itemId);
                }
                _loc_5++;
            }
            if (_loc_4.length)
            {
                ShopController.getInstance().sell(_loc_4);
            }
            return;
        }// end function

        private static function sellCheck(param1:PropInfo) : Boolean
        {
            if (AutoFightModel.fightSell == 1)
            {
                return defaultSell(param1);
            }
            if (AutoFightModel.fightSell == 2)
            {
                return userSetSell(param1);
            }
            return false;
        }// end function

        private static function userSetSell(param1:PropInfo) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (param1.q_type == 1)
            {
                if (param1 is EquipmentInfo && EquipmentInfo(param1).suitId != 0)
                {
                    return false;
                }
                if (param1 is EquipmentInfo && EquipmentInfo(param1).q_quality_lv >= 4)
                {
                    return false;
                }
                if (param1.intensify > AutoFightModel.sellRank1)
                {
                    return false;
                }
                if (param1.q_kind == 11 || param1.q_kind == 12 || UNSELL_LIST.indexOf(param1.q_id) != -1)
                {
                    return false;
                }
                if (param1 is EquipmentInfo && EquipmentInfo(param1).q_quality_lv >= 4)
                {
                    return false;
                }
                _loc_2 = AutoFightModel.sellRank2 + 1;
                if (param1.addAttributLevel > _loc_2)
                {
                    return false;
                }
                if (!AutoFightModel.sellLimit1)
                {
                    if (param1.q_kind == 5 || param1.q_kind == 9)
                    {
                        return false;
                    }
                }
                if (param1.q_remarkable == 1)
                {
                    return false;
                }
                if (param1.isUsing)
                {
                    return false;
                }
                if (!AutoFightModel.sellLimit5)
                {
                    if (param1 is EquipmentInfo && EquipUtil.compareEquip(EquipmentInfo(param1)) == 1)
                    {
                        return false;
                    }
                }
                if (!AutoFightModel.sellLimit6)
                {
                    if (param1 is EquipmentInfo && EquipmentInfo(param1).knowing_attackpercent)
                    {
                        return false;
                    }
                }
                return true;
            }
            if (AutoFightModel.sellLimit8)
            {
                _loc_3 = ItemCfgObj.getInstance().getAutoSellItemByLv(UserObj.getInstance().playerInfo.level, VipModel.getInstance().info.level, 8);
                if (_loc_3.indexOf(param1.itemModelId.toString()) != -1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private static function defaultSell(param1:PropInfo) : Boolean
        {
            var _loc_2:* = ItemCfgObj.getInstance().getAutoSellItemByLv(UserObj.getInstance().playerInfo.level, VipModel.getInstance().info.level);
            if (_loc_2.indexOf(param1.itemModelId.toString()) != -1)
            {
                return true;
            }
            if (param1 is EquipmentInfo)
            {
                if (EquipmentInfo(param1).knowing_attackpercent)
                {
                    return false;
                }
                if (EquipUtil.compareEquip(EquipmentInfo(param1)) == 1)
                {
                    return false;
                }
                if (EquipmentInfo(param1).suitId != 0)
                {
                    return false;
                }
            }
            return param1.q_type == 1 && param1.intensify < 5 && param1.addAttributLevel < 2 && param1.q_remarkable != 1 && param1.q_kind != 5 && param1.q_kind != 9 && param1.q_kind != 11 && param1.q_kind != 12 && UNSELL_LIST.indexOf(param1.q_id) == -1 && !param1.isUsing && param1.q_quality_lv < 4;
        }// end function

    }
}
