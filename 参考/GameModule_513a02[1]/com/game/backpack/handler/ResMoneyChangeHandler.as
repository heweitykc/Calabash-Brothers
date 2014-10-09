package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.model.*;
    import net.*;

    public class ResMoneyChangeHandler extends Handler
    {

        public function ResMoneyChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResMoneyChangeMessage(this.message);
            UserObj.getInstance().playerInfo.money = _loc_1.money;
            return;
        }// end function

    }
}
