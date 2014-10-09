package com.game.shop.handler
{
    import com.game.shop.message.*;
    import net.*;

    public class ResNotSaleHandler extends Handler
    {

        public function ResNotSaleHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNotSaleMessage(this.message);
            return;
        }// end function

    }
}
