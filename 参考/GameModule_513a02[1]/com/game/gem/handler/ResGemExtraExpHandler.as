package com.game.gem.handler
{
    import com.game.gem.message.*;
    import net.*;

    public class ResGemExtraExpHandler extends Handler
    {

        public function ResGemExtraExpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGemExtraExpMessage(this.message);
            return;
        }// end function

    }
}
