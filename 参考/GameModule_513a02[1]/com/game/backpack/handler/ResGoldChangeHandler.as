package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.model.*;
    import net.*;

    public class ResGoldChangeHandler extends Handler
    {

        public function ResGoldChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGoldChangeMessage(this.message);
            UserObj.getInstance().playerInfo.gold = _loc_1.gold;
            return;
        }// end function

    }
}
