package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.game.getItem.control.*;
    import net.*;

    public class ResGetItemReasonsHandler extends Handler
    {

        public function ResGetItemReasonsHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGetItemReasonsMessage(this.message);
            GetItemControl.Instance.getItem(_loc_1);
            return;
        }// end function

    }
}
