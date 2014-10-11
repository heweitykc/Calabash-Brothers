package com.game.maze.handler
{
    import com.game.maze.message.*;
    import net.*;

    public class ResChangeFloorHandler extends Handler
    {

        public function ResChangeFloorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangeFloorMessage(this.message);
            return;
        }// end function

    }
}
