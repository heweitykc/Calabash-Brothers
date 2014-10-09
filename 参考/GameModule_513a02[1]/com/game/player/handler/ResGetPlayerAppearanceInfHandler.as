package com.game.player.handler
{
    import com.game.player.message.*;
    import net.*;

    public class ResGetPlayerAppearanceInfHandler extends Handler
    {

        public function ResGetPlayerAppearanceInfHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetPlayerAppearanceInfMessage(this.message);
            return;
        }// end function

    }
}
