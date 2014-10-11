package com.game.shortcut.handler
{
    import com.game.shortcut.control.*;
    import com.game.shortcut.message.*;
    import net.*;

    public class ShortCutRemoveHandler extends Handler
    {

        public function ShortCutRemoveHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ShortCutRemoveMessage(this.message);
            ShortcutControl.getInstance().shortCutRemoveHandle(_loc_1);
            return;
        }// end function

    }
}
