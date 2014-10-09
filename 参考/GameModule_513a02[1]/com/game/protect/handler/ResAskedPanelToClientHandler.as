package com.game.protect.handler
{
    import com.game.magicbook.control.*;
    import com.game.protect.control.*;
    import com.game.protect.message.*;
    import net.*;

    public class ResAskedPanelToClientHandler extends Handler
    {

        public function ResAskedPanelToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ProtectControl.getInstance().resAskedPanelToClient(message as ResAskedPanelToClientMessage);
            MagicBookControl.getIntance().stopReqOneKeyUpExp();
            return;
        }// end function

    }
}
