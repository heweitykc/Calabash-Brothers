package com.game.casting.handler
{
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import net.*;

    public class ResCastingUseItemToClientHandler extends Handler
    {

        public function ResCastingUseItemToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingUseItemToClientMessage(this.message);
            ZhuZaoControl.getInstance().useItem(_loc_1);
            super.action();
            return;
        }// end function

    }
}
