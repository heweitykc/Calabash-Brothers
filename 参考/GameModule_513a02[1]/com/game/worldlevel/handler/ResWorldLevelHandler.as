package com.game.worldlevel.handler
{
    import com.game.worldlevel.control.*;
    import com.game.worldlevel.message.*;
    import net.*;

    public class ResWorldLevelHandler extends Handler
    {

        public function ResWorldLevelHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            WorldLevelControl.getInstance().resWorldLevel(message as ResWorldLevelMessage);
            return;
        }// end function

    }
}
