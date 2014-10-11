package com.game.batter.handler
{
    import com.game.batter.control.*;
    import com.game.batter.message.*;
    import net.*;

    public class ResMomentKillToClientHandler extends Handler
    {

        public function ResMomentKillToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMomentKillToClientMessage(this.message);
            BatterControl.getInstance().momentKillToClient(_loc_1);
            return;
        }// end function

    }
}
