package com.game.map.handler
{
    import com.game.map.message.*;
    import net.*;

    public class ResSynMonsterPositionHandler extends Handler
    {

        public function ResSynMonsterPositionHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSynMonsterPositionMessage(this.message);
            return;
        }// end function

    }
}
