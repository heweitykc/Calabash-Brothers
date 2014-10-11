package com.game.npc.handler
{
    import com.game.npc.message.*;
    import net.*;

    public class ResNpcActionHandler extends Handler
    {

        public function ResNpcActionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNpcActionMessage(this.message);
            return;
        }// end function

    }
}
