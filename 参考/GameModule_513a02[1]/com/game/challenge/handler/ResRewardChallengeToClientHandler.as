package com.game.challenge.handler
{
    import com.game.challenge.message.*;
    import net.*;

    public class ResRewardChallengeToClientHandler extends Handler
    {

        public function ResRewardChallengeToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRewardChallengeToClientMessage(this.message);
            return;
        }// end function

    }
}
