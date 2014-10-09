package com.game.dianjiangchun.handler
{
    import com.game.dianjiangchun.message.*;
    import net.*;

    public class SendDianjiangchunInfoToClientHandler extends Handler
    {

        public function SendDianjiangchunInfoToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = SendDianjiangchunInfoToClientMessage(this.message);
            return;
        }// end function

    }
}
