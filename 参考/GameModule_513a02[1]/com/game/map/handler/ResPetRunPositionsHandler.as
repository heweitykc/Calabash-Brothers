package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResPetRunPositionsHandler extends Handler
    {

        public function ResPetRunPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetRunPositionsMessage(this.message);
            return;
        }// end function

    }
}
