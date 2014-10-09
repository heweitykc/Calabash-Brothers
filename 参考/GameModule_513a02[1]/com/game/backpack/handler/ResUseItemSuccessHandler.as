package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.game.getItem.control.*;
    import com.game.operationpanel.control.*;
    import com.game.sound.control.*;
    import net.*;

    public class ResUseItemSuccessHandler extends Handler
    {

        public function ResUseItemSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResUseItemSuccessMessage(this.message);
            OperationPanelControl.getInstance().setItemCD(_loc_1.itemId);
            GetItemControl.Instance.useItem(_loc_1);
            SoundControl.getInstance().playItemSound(SoundFlag.USE_ITEM, _loc_1.itemId);
            return;
        }// end function

    }
}
