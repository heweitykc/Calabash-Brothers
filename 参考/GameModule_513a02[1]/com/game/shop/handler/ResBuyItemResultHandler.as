package com.game.shop.handler
{
    import com.game.shop.message.*;
    import com.game.sound.control.*;
    import net.*;

    public class ResBuyItemResultHandler extends Handler
    {

        public function ResBuyItemResultHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBuyItemResultMessage(this.message);
            SoundControl.getInstance().playSound(SoundFlag.BUY_ITEM);
            return;
        }// end function

    }
}
