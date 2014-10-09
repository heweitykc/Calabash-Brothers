package com.game.prompt.handler
{
    import com.game.prompt.control.*;
    import com.game.prompt.message.*;
    import net.*;

    public class PersonalNoticeWorldHandler extends Handler
    {

        public function PersonalNoticeWorldHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = PersonalNoticeWorldMessage(this.message);
            PromptControl.getInstance().personNoticeWorld(_loc_1);
            return;
        }// end function

    }
}
