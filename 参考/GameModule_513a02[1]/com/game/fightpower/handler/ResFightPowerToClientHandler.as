package com.game.fightpower.handler
{
    import com.game.fightpower.message.*;
    import com.model.*;
    import net.*;

    public class ResFightPowerToClientHandler extends Handler
    {

        public function ResFightPowerToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFightPowerToClientMessage(this.message);
            UserObj.getInstance().playerInfo.fightPower = _loc_1.fightPower;
            return;
        }// end function

    }
}
