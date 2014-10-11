package com.game.npc.handler
{
    import com.game.npc.message.*;
    import net.*;

    public class ResNpcServicesHandler extends Handler
    {

        public function ResNpcServicesHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNpcServicesMessage(this.message);
            return;
        }// end function

    }
}
