package com.game.signwage.handler
{
    import com.game.signwage.control.*;
    import com.game.signwage.message.*;
    import net.*;

    public class ResSignWageInfoHandler extends Handler
    {

        public function ResSignWageInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSignWageInfoMessage(this.message);
            SignWageControl.getInstance().setSignInfo(_loc_1.signInfo);
            return;
        }// end function

    }
}
