package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResMagicbookLevelHandler extends Handler
    {

        public function ResMagicbookLevelHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMagicbookLevelMessage(this.message);
            MagicBookControl.getIntance().resMagicbookLevel(_loc_1);
            return;
        }// end function

    }
}
