package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import com.game.magicbook.model.*;
    import flash.events.*;
    import net.*;

    public class ResAdvancedUpHandler extends Handler
    {

        public function ResAdvancedUpHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResAdvancedUpMessage(this.message);
            if (_loc_1.result == 0)
            {
                MagicBookData.dispatchEvent(new Event(MagicBookData.ONEKEY_UP_EXP));
            }
            else
            {
                MagicBookControl.getIntance().stopReqOneKeyUpExp();
            }
            return;
        }// end function

    }
}
