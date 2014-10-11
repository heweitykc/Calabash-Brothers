package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResMonsterRunPositionsHandler extends Handler
    {

        public function ResMonsterRunPositionsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterRunPositionsMessage(this.message);
            MapControl.getInstance().monsterRunPositionsHandler(_loc_1);
            return;
        }// end function

    }
}
