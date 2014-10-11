package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResRoundArrowExteriorHandler extends Handler
    {

        public function ResRoundArrowExteriorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundArrowExteriorMessage(this.message);
            return;
        }// end function

    }
}
