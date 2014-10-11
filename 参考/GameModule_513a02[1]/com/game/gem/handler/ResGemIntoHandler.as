package com.game.gem.handler
{
    import com.game.gem.message.*;
    import net.*;

    public class ResGemIntoHandler extends Handler
    {

        public function ResGemIntoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGemIntoMessage(this.message);
            return;
        }// end function

    }
}
