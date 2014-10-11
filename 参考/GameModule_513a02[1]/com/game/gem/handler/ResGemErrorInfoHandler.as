package com.game.gem.handler
{
    import com.game.gem.message.*;
    import net.*;

    public class ResGemErrorInfoHandler extends Handler
    {

        public function ResGemErrorInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGemErrorInfoMessage(this.message);
            return;
        }// end function

    }
}
