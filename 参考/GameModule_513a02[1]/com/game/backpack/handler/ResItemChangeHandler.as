package com.game.backpack.handler
{
    import com.game.awardGuide.control.*;
    import com.game.backpack.control.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import com.game.player.control.*;
    import com.game.player.view.*;
    import com.model.vo.*;
    import com.util.*;
    import net.*;

    public class ResItemChangeHandler extends Handler
    {

        public function ResItemChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_2:* = false;
            var _loc_1:* = ResItemChangeMessage(this.message);
            var _loc_3:* = BackpackObj.getInstance().getItemById(_loc_1.item.itemId);
            if (_loc_3 && _loc_1.item.num.toNumber() > _loc_3.num)
            {
                _loc_2 = true;
            }
            var _loc_4:* = PropUtil.createItemByItemInfo(_loc_1.item);
            BackPackControl.getInstance().updateItemByItemInfo(_loc_1.item);
            var _loc_5:* = BackpackObj.getInstance().getItemById(_loc_1.item.itemId);
            if (_loc_2)
            {
                ItemAwardGuideControl.getInstance().addGuide(_loc_5);
            }
            if (_loc_5 && _loc_5.itemModelId == ReliveBox.ShopItemID)
            {
                PlayerControl.getInstance().updateStoneNum();
            }
            return;
        }// end function

    }
}
