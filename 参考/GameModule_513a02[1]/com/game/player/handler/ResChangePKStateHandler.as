package com.game.player.handler
{
    import com.game.fight.control.*;
    import com.game.player.message.*;
    import net.*;

    public class ResChangePKStateHandler extends Handler
    {

        public function ResChangePKStateHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResChangePKStateMessage(this.message);
            FightControl.getInstance().resChangePKStateHandler(_loc_1);
            return;
        }// end function

    }
}
