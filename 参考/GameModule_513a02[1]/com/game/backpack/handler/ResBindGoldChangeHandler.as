package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.model.*;
    import net.*;

    public class ResBindGoldChangeHandler extends Handler
    {

        public function ResBindGoldChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResBindGoldChangeMessage(this.message);
            UserObj.getInstance().playerInfo.bindgold = _loc_1.bindgold;
            return;
        }// end function

    }
}
