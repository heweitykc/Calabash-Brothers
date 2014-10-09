package com.game.shortcut.handler
{
    import com.game.shortcut.control.*;
    import com.game.shortcut.message.*;
    import net.*;

    public class ShortCutAddHandler extends Handler
    {

        public function ShortCutAddHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ShortCutAddMessage(this.message);
            ShortcutControl.getInstance().shortCutAddHandle(_loc_1);
            return;
        }// end function

    }
}
