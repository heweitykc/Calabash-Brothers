package com.game.login.handler
{
    import com.game.login.message.*;
    import net.*;

    public class ResQuitHandler extends Handler
    {

        public function ResQuitHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResQuitMessage(this.message);
            return;
        }// end function

    }
}
