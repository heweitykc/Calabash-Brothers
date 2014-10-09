package com.game.magicbook.handler
{
    import com.game.magicbook.control.*;
    import com.game.magicbook.message.*;
    import net.*;

    public class ResBreakthroughHandler extends Handler
    {

        public function ResBreakthroughHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBreakthroughMessage(this.message);
            MagicBookControl.getIntance().resBreakthrough(_loc_1);
            return;
        }// end function

    }
}
