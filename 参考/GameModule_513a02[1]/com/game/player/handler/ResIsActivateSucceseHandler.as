package com.game.player.handler
{
    import com.game.player.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResIsActivateSucceseHandler extends Handler
    {

        public function ResIsActivateSucceseHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResIsActivateSuccese(this.message);
            ChangeJobControl.getInstance().resIsActivateSucceseHandler(_loc_1);
            return;
        }// end function

    }
}
