package com.game.shortcut.handler
{
    import com.game.shortcut.control.*;
    import com.game.shortcut.message.*;
    import net.*;

    public class ShortCutInfosHandler extends Handler
    {

        public function ShortCutInfosHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ShortCutInfosMessage(this.message);
            ShortcutControl.getInstance().shortcutInfosHandler(_loc_1);
            return;
        }// end function

    }
}
