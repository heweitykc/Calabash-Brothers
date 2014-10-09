package com.game.player.handler
{
    import com.game.player.message.*;
    import com.model.*;
    import net.*;

    public class ResDropPlayerIntoBlackRoomHandler extends Handler
    {

        public function ResDropPlayerIntoBlackRoomHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResDropPlayerIntoBlackRoomMessage(this.message);
            RoleList.getInstance().player.info.isInBlack = _loc_1.drop;
            return;
        }// end function

    }
}
