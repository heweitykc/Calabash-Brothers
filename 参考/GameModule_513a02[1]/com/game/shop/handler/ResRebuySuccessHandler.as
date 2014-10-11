package com.game.shop.handler
{
    import com.game.shop.message.*;
    import net.*;

    public class ResRebuySuccessHandler extends Handler
    {

        public function ResRebuySuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRebuySuccessMessage(this.message);
            return;
        }// end function

    }
}
