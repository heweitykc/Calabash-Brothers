package com.game.newactivity.nothink.control
{
    import com.game.newactivity.control.*;
    import com.staticdata.*;

    public class GiftNothinkControl extends Object
    {
        private static var instance:GiftNothinkControl;

        public function GiftNothinkControl()
        {
            return;
        }// end function

        public function gainGift() : void
        {
            NewActivityControl.getInstance().getActivityReward(NewActivityConfig.ACTID_GIFT_Nothink, 0);
            return;
        }// end function

        public static function getInstance() : GiftNothinkControl
        {
            var _loc_1:* = new GiftNothinkControl;
            instance = new GiftNothinkControl;
            return instance || _loc_1;
        }// end function

    }
}
