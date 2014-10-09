package com.game.newactivity.handler
{
    import com.game.newactivity.message.*;
    import com.game.newactivity.rechargedays.control.*;
    import net.*;

    public class ResFirstPayGroupCountHandler extends Handler
    {

        public function ResFirstPayGroupCountHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResFirstPayGroupCountMessage(this.message);
            RechargetDaysControl.getInstance().updateGroupCount(_loc_1.groupCount);
            return;
        }// end function

    }
}
