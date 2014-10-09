package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResStrengthLevelHandler extends Handler
    {

        public function ResStrengthLevelHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResStrengthLevelMessage(this.message);
            MapControl.getInstance().roundStrengthLevelHandler(_loc_1);
            return;
        }// end function

    }
}
