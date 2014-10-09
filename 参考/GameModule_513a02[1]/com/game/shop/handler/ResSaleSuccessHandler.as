package com.game.shop.handler
{
    import com.game.shop.message.*;
    import com.game.sound.control.*;
    import net.*;

    public class ResSaleSuccessHandler extends Handler
    {

        public function ResSaleSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSaleSuccessMessage(this.message);
            SoundControl.getInstance().playSound(SoundFlag.SELL_ITEM);
            return;
        }// end function

    }
}
