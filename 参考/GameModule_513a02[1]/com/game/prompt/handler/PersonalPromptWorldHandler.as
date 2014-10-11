package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class PersonalPromptWorldHandler extends Handler
    {

        public function PersonalPromptWorldHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = PersonalPromptWorldMessage(this.message);
            return;
        }// end function

    }
}
