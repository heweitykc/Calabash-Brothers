package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResSuitEffectHandler extends Handler
    {

        public function ResSuitEffectHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSuitEffectMessage(this.message);
            PlayerControl.getInstance().updateSuitEffect(_loc_1);
            return;
        }// end function

    }
}
