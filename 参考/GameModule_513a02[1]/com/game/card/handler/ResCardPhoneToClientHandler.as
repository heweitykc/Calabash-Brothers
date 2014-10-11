package com.game.card.handler
{
    import com.game.card.control.*;
    import com.game.card.message.*;
    import net.*;

    public class ResCardPhoneToClientHandler extends Handler
    {

        public function ResCardPhoneToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCardPhoneToClientMessage(this.message);
            CardControl.getInstance().resCardPhoneHandler(_loc_1);
            return;
        }// end function

    }
}
