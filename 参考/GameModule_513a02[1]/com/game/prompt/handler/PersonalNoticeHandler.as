package com.game.prompt.handler
{
    import com.game.prompt.control.*;
    import com.game.prompt.message.*;
    import net.*;

    public class PersonalNoticeHandler extends Handler
    {

        public function PersonalNoticeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = PersonalNoticeMessage(this.message);
            PromptControl.getInstance().personNotice(_loc_1);
            return;
        }// end function

    }
}
