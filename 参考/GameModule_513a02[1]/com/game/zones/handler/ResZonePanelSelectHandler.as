package com.game.zones.handler
{
    import com.game.zones.message.*;
    import net.*;

    public class ResZonePanelSelectHandler extends Handler
    {

        public function ResZonePanelSelectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZonePanelSelectMessage(this.message);
            return;
        }// end function

    }
}
