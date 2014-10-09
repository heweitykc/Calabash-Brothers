package com.game.fight.handler
{
    import com.game.fight.message.*;
    import net.*;

    public class ResEffectBroadcastHandler extends Handler
    {

        public function ResEffectBroadcastHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEffectBroadcastMessage(this.message);
            return;
        }// end function

    }
}
