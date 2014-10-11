package com.game.longyuan.handler
{
    import com.*;
    import com.game.longyuan.message.*;
    import com.model.*;
    import net.*;

    public class ResShowEffectToClientHandler extends Handler
    {

        public function ResShowEffectToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResShowEffectToClientMessage(this.message);
            RoleList.getInstance().player.dead();
            Global.popManager.addBgMask(false, true);
            return;
        }// end function

    }
}
