package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResWingChangeHandler extends Handler
    {

        public function ResWingChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResWingChangeMessage(this.message);
            MapControl.getInstance().wingChangeHandler(_loc_1);
            return;
        }// end function

    }
}
