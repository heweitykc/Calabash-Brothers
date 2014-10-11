package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResMapSearchMemberNameClientHandler extends Handler
    {

        public function ResMapSearchMemberNameClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMapSearchMemberNameClientMessage(this.message);
            TeamControl.getInstance().mapSearchMemberNameClientBack(_loc_1);
            return;
        }// end function

    }
}
