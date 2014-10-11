package com.game.login.handler
{
    import com.game.login.message.*;
    import net.*;

    public class ResCreateUserHandler extends Handler
    {

        public function ResCreateUserHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCreateUserMessage(this.message);
            return;
        }// end function

    }
}
