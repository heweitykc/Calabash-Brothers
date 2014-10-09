package com.game.gem.handler
{
    import com.game.gem.message.*;
    import net.*;

    public class ResGemActivationORUpHandler extends Handler
    {

        public function ResGemActivationORUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGemActivationORUpMessage(this.message);
            return;
        }// end function

    }
}
