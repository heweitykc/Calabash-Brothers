package com.game.backpack.handler
{
    import com.cfg.obj.*;
    import com.game.autopk.controller.*;
    import com.game.awardGuide.control.*;
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import com.game.guide.control.*;
    import com.game.player.control.*;
    import com.game.player.model.*;
    import com.game.player.view.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import net.*;

    public class ResItemAddHandler extends Handler
    {

        public function ResItemAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_1:* = ResItemAddMessage(this.message);
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(_loc_1.item.itemModelId);
            if (!_loc_2)
            {
                return;
            }
            if (PropUtil.isEquip(_loc_2.q_type))
            {
                _loc_3 = new EquipmentInfo();
                _loc_3.conv(_loc_1.item);
            }
            else
            {
                _loc_3 = new PropInfo();
                _loc_3.conv(_loc_1.item);
            }
            BackPackControl.getInstance().addItem(_loc_3);
            if (_loc_3.q_type == ItemType.MEDICINE)
            {
                _loc_4 = ItemConst.HPMEDICINE.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_5 = _loc_5 + BackpackObj.getInstance().getItemCount(ItemConst.HPMEDICINE[_loc_6]);
                    _loc_6++;
                }
                _loc_4 = ItemConst.EPMEDICINE.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_4)
                {
                    
                    _loc_7 = _loc_7 + BackpackObj.getInstance().getItemCount(ItemConst.EPMEDICINE[_loc_6]);
                    _loc_6++;
                }
                if (_loc_7 && _loc_5)
                {
                    FunGuideControl.getInstance().closeGuide(FunGuideControl.getInstance().SELF_SHOP);
                    FunGuideControl.getInstance().clearShopTime();
                }
            }
            if (_loc_3 is EquipmentInfo)
            {
                if (!EquipsObj.getInstance().isInSelf(_loc_3.itemId))
                {
                    EquipAwardGuideControl.getInstance().addGuide(_loc_3);
                }
            }
            else
            {
                ItemAwardGuideControl.getInstance().addGuide(_loc_3);
            }
            if (_loc_3.itemModelId == ReliveBox.ShopItemID)
            {
                PlayerControl.getInstance().updateStoneNum();
            }
            if (_loc_3.itemModelId == Params.VIP_EXP_ITEM_ID)
            {
                VipGuideControl.getInstance().showGetVipView(0);
            }
            SellLogic.autoSell();
            return;
        }// end function

    }
}
