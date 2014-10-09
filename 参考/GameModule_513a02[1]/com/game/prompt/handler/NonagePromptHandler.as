package com.game.prompt.handler
{
    import com.game.player.control.*;
    import com.game.prompt.message.*;
    import net.*;

    public class NonagePromptHandler extends Handler
    {

        public function NonagePromptHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = NonagePromptMessage(this.message);
            PlayerControl.getInstance().nonageHanlder(_loc_1);
            return;
        }// end function

    }
}
