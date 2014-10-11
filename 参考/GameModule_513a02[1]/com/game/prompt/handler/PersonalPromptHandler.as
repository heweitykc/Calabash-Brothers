package com.game.prompt.handler
{
    import com.game.prompt.message.*;
    import net.*;

    public class PersonalPromptHandler extends Handler
    {

        public function PersonalPromptHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = PersonalPromptMessage(this.message);
            return;
        }// end function

    }
}
