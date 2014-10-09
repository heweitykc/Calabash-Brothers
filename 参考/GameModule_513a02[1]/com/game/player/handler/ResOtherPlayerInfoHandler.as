package com.game.player.handler
{
    import com.game.player.message.*;
    import com.game.primaryrole.control.*;
    import net.*;

    public class ResOtherPlayerInfoHandler extends Handler
    {

        public function ResOtherPlayerInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOtherPlayerInfoMessage(this.message);
            OtherRoleControl.getInstance().otherPlayerInfoHandler(_loc_1);
            return;
        }// end function

    }
}
