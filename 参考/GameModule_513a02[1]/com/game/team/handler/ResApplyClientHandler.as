package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResApplyClientHandler extends Handler
    {

        public function ResApplyClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResApplyClientMessage(this.message);
            TeamControl.getInstance().applyClientBack(_loc_1);
            return;
        }// end function

    }
}
