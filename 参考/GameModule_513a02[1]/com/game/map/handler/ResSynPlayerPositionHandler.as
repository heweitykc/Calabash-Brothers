package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResSynPlayerPositionHandler extends Handler
    {

        public function ResSynPlayerPositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSynPlayerPositionMessage(this.message);
            return;
        }// end function

    }
}
