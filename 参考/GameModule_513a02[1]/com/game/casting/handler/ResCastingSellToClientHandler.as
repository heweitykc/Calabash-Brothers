package com.game.casting.handler
{
    import com.game.casting.control.*;
    import com.game.casting.message.*;
    import net.*;

    public class ResCastingSellToClientHandler extends Handler
    {

        public function ResCastingSellToClientHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResCastingSellToClientMessage(this.message);
            var _loc_2:* = ZhuZaoControl.getInstance();
            _loc_2.showSellFlash(_loc_1.itemList, _loc_1.goldList);
            super.action();
            return;
        }// end function

    }
}
