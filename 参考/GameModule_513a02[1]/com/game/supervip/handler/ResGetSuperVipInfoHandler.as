package com.game.supervip.handler
{
    import com.game.supervip.control.*;
    import com.game.supervip.message.*;
    import net.*;

    public class ResGetSuperVipInfoHandler extends Handler
    {

        public function ResGetSuperVipInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            SupervipControl.getInstance().resGetSuperVipInfo(message as ResGetSuperVipInfoMessage);
            return;
        }// end function

    }
}
