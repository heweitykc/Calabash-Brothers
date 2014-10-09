package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class PersonalNoticeActivityHandler extends Handler
    {

        public function PersonalNoticeActivityHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = PersonalNoticeActivityMessage(this.message);
            return;
        }// end function

    }
}
