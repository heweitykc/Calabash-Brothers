package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResMagicbookHandler extends Handler
    {

        public function ResMagicbookHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMagicbookMessage(this.message);
            MagicBookControl.getIntance().resMagicbook(_loc_1);
            super.action();
            return;
        }// end function

    }
}
