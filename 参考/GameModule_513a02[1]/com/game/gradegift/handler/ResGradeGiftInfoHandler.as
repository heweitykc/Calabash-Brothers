package com.game.gradegift.handler
{
    import com.game.gradegift.control.*;
    import com.game.gradegift.message.*;
    import net.*;

    public class ResGradeGiftInfoHandler extends Handler
    {

        public function ResGradeGiftInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGradeGiftInfoMessage(this.message);
            GradeGiftControl.getInstance().updateGiftItem(_loc_1.info.giftId, _loc_1.info.reamain, null);
            super.action();
            return;
        }// end function

    }
}
