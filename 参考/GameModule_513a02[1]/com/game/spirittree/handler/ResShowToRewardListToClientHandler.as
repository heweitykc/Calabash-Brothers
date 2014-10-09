package com.game.spirittree.handler
{
    import com.game.spirittree.message.*;
    import net.*;

    public class ResShowToRewardListToClientHandler extends Handler
    {

        public function ResShowToRewardListToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResShowToRewardListToClientMessage(this.message);
            return;
        }// end function

    }
}
