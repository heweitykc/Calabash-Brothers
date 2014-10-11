package com.game.zones.handler
{
    import com.game.zones.control.*;
    import com.game.zones.message.*;
    import net.*;

    public class ResZoneBossAppearHandler extends Handler
    {

        public function ResZoneBossAppearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResZoneBossAppearMessage(this.message);
            ZonesControl.getInstance().ResZoneBossAppear(_loc_1);
            return;
        }// end function

    }
}
