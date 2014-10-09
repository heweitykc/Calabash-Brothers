package com.game.epalace.handler
{
    import com.game.epalace.message.*;
    import net.*;

    public class ResEpalaceOpenToGameHandler extends Handler
    {

        public function ResEpalaceOpenToGameHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResEpalaceOpenToGameMessage(this.message);
            return;
        }// end function

    }
}
