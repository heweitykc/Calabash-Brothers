package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResPetTranMoveHandler extends Handler
    {

        public function ResPetTranMoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPetTranMoveMessage(this.message);
            return;
        }// end function

    }
}
