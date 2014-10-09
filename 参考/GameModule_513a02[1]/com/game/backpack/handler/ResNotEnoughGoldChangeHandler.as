package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import net.*;

    public class ResNotEnoughGoldChangeHandler extends Handler
    {

        public function ResNotEnoughGoldChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResNotEnoughGoldChangeMessage(this.message);
            return;
        }// end function

    }
}
