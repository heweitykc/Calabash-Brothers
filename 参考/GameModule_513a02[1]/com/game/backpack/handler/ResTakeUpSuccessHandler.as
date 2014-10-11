package com.game.backpack.handler
{
    import com.game.backpack.message.*;
    import com.game.map.control.*;
    import net.*;

    public class ResTakeUpSuccessHandler extends Handler
    {

        public function ResTakeUpSuccessHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResTakeUpSuccessMessage(this.message);
            MapControl.getInstance().dropTakeUpSuccess(_loc_1);
            return;
        }// end function

    }
}
