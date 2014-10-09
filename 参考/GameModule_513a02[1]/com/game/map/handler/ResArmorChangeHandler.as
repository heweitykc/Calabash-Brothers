package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResArmorChangeHandler extends Handler
    {

        public function ResArmorChangeHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResArmorChangeMessage(this.message);
            MapControl.getInstance().armorChangeHandler(_loc_1);
            return;
        }// end function

    }
}
