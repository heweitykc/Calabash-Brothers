package com.game.map.handler
{
    import com.game.map.control.*;
    import com.game.map.message.*;
    import net.*;

    public class ResPlayerRunEndHandler extends Handler
    {

        public function ResPlayerRunEndHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResPlayerRunEndMessage(this.message);
            MapControl.getInstance().playerRunEndHandler(_loc_1);
            return;
        }// end function

    }
}
