package com.game.maze.handler
{
    import com.game.maze.message.*;
    import net.*;

    public class ResRewardHandler extends Handler
    {

        public function ResRewardHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRewardMessage(this.message);
            return;
        }// end function

    }
}
