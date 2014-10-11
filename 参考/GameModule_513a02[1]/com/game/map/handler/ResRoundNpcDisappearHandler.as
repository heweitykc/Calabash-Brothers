package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResRoundNpcDisappearHandler extends Handler
    {

        public function ResRoundNpcDisappearHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResRoundNpcDisappearMessage(this.message);
            MapControl.getInstance().removeNpcsByNpcIDs(_loc_1.npcids);
            return;
        }// end function

    }
}
