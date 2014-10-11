package com.game.elementHeart.handler
{
    import com.game.elementHeart.model.*;
    import com.game.masterequip.message.*;
    import net.*;

    public class ResElementValueHandler extends Handler
    {

        public function ResElementValueHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResElementValueMessage(this.message);
            ElementHeartData.getInstance().updateValue(_loc_1.value);
            return;
        }// end function

    }
}
