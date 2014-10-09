package com.game.remark.handler
{
    import com.game.player.message.*;
    import com.game.primaryrole.control.*;
    import net.*;

    public class ResAttributeChangeHandler extends Handler
    {

        public function ResAttributeChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAttributeChangeMessage(this.message);
            PrimaryRoleControl.getInstance().changeRemark(_loc_1.param);
            return;
        }// end function

    }
}
