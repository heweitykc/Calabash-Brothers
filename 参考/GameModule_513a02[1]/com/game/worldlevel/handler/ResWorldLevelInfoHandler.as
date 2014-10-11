package com.game.worldlevel.handler
{
    import com.game.worldlevel.control.*;
    import com.game.worldlevel.message.*;
    import net.*;

    public class ResWorldLevelInfoHandler extends Handler
    {

        public function ResWorldLevelInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            WorldLevelControl.getInstance().resWorldLevelInfo(message as ResWorldLevelInfoMessage);
            return;
        }// end function

    }
}
