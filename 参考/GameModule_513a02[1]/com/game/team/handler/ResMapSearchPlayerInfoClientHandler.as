package com.game.team.handler
{
    import com.game.team.control.*;
    import com.game.team.message.*;
    import net.*;

    public class ResMapSearchPlayerInfoClientHandler extends Handler
    {

        public function ResMapSearchPlayerInfoClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMapSearchPlayerInfoClientMessage(this.message);
            TeamControl.getInstance().mapSearchPlayerInfoClientBack(_loc_1);
            return;
        }// end function

    }
}
