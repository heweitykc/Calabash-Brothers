package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResGetActivatedStarInfoHandler extends Handler
    {

        public function ResGetActivatedStarInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetActivatedStarInfo(this.message);
            ChangeJobControl.getInstance().resMasterChangeState(_loc_1);
            return;
        }// end function

    }
}
