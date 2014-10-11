package com.game.player.handler
{
    import com.game.player.message.*;
    import com.game.zones.control.*;
    import net.*;

    public class ResScriptCommonPlayerToClientHandler extends Handler
    {

        public function ResScriptCommonPlayerToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResScriptCommonPlayerToClientMessage(this.message);
            ZonesControl.getInstance().killMonsterCount(_loc_1);
            return;
        }// end function

    }
}
