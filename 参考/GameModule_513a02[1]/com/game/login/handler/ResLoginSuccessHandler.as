﻿package com.game.login.handler
{
    import com.game.login.control.*;
    import com.game.login.message.*;
    import net.*;

    public class ResLoginSuccessHandler extends Handler
    {

        public function ResLoginSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResLoginSuccessMessage(this.message);
            RegistControl.getInstance().loginSuccessHandler(_loc_1);
            return;
        }// end function

    }
}
