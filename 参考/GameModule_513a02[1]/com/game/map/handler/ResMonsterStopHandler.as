package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResMonsterStopHandler extends Handler
    {

        public function ResMonsterStopHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterStopMessage(this.message);
            MapControl.getInstance().monsterStopHandler(_loc_1);
            return;
        }// end function

    }
}
