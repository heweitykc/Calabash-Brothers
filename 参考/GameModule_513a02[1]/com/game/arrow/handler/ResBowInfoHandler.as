package com.game.arrow.handler
{
    import com.game.arrow.message.*;
    import net.*;

    public class ResBowInfoHandler extends Handler
    {

        public function ResBowInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBowInfoMessage(this.message);
            return;
        }// end function

    }
}
