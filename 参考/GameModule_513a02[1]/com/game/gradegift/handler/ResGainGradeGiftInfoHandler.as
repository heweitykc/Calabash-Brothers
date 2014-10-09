package com.game.gradegift.handler
{
    import com.game.gradegift.control.*;
    import com.game.gradegift.message.*;
    import net.*;

    public class ResGainGradeGiftInfoHandler extends Handler
    {

        public function ResGainGradeGiftInfoHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGainGradeGiftInfoMessage(this.message);
            GradeGiftControl.getInstance().updateGiftItem(_loc_1.awardInfo.giftId, null, _loc_1.awardInfo.isGain);
            return;
        }// end function

    }
}
