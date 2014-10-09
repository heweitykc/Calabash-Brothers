package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceErrorToGameHandler extends Handler
    {

        public function ResEpalaceErrorToGameHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceErrorToGameMessage(this.message);
            return;
        }// end function

    }
}
