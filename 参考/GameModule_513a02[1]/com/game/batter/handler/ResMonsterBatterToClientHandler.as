package com.game.batter.handler
{
    import com.game.batter.control.*;
    import com.game.batter.message.*;
    import net.*;

    public class ResMonsterBatterToClientHandler extends Handler
    {

        public function ResMonsterBatterToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMonsterBatterToClientMessage(this.message);
            BatterControl.getInstance().monsterBatterToClient(_loc_1);
            return;
        }// end function

    }
}
