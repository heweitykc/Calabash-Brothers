package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.model.*;
    import net.*;

    public class ResSpiritChangeHandler extends Handler
    {

        public function ResSpiritChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResSpiritChangeMessage(this.message);
            UserObj.getInstance().playerInfo.spirit = _loc_1.spirit;
            return;
        }// end function

    }
}
