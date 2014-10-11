package com.game.card.handler
{
    import com.game.card.control.*;
    import com.game.card.message.*;
    import net.*;

    public class ResCardToClientHandler extends Handler
    {

        public function ResCardToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCardToClientMessage(this.message);
            CardControl.getInstance().resCardHandler(_loc_1);
            return;
        }// end function

    }
}
