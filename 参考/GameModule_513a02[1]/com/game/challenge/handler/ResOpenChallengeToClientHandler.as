package com.game.challenge.handler
{
    import com.game.challenge.message.*;
    import net.*;

    public class ResOpenChallengeToClientHandler extends Handler
    {

        public function ResOpenChallengeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenChallengeToClientMessage(this.message);
            return;
        }// end function

    }
}
