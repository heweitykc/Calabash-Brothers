package com.game.login.handler
{
    import com.game.login.message.*;
    import net.*;

    public class ResDeleteSuccessHandler extends Handler
    {

        public function ResDeleteSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDeleteSuccessMessage(this.message);
            return;
        }// end function

    }
}
