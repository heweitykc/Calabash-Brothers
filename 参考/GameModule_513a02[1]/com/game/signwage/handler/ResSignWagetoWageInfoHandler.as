package com.game.signwage.handler
{
    import com.game.signwage.message.*;
    import net.*;

    public class ResSignWagetoWageInfoHandler extends Handler
    {

        public function ResSignWagetoWageInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSignWagetoWageInfoMessage(this.message);
            return;
        }// end function

    }
}
