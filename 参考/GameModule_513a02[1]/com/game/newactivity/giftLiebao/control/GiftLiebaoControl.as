package com.game.newactivity.giftLiebao.control
{
    import com.game.newactivity.control.*;
    import com.staticdata.*;

    public class GiftLiebaoControl extends Object
    {
        private static var instance:GiftLiebaoControl;

        public function GiftLiebaoControl()
        {
            return;
        }// end function

        public function gainGift() : void
        {
            NewActivityControl.getInstance().getActivityReward(NewActivityConfig.ACTID_GIFT_LIEBAO, 0);
            return;
        }// end function

        public static function getInstance() : GiftLiebaoControl
        {
            var _loc_1:* = new GiftLiebaoControl;
            instance = new GiftLiebaoControl;
            return instance || _loc_1;
        }// end function

    }
}
