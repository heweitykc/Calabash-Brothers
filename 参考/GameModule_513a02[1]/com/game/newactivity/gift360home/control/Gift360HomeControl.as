package com.game.newactivity.gift360home.control
{
    import com.game.newactivity.control.*;
    import com.staticdata.*;

    public class Gift360HomeControl extends Object
    {
        private static var instance:Gift360HomeControl;

        public function Gift360HomeControl()
        {
            return;
        }// end function

        public function gainGift() : void
        {
            NewActivityControl.getInstance().getActivityReward(NewActivityConfig.ACTID_GIFT_360HOME, 0);
            return;
        }// end function

        public static function getInstance() : Gift360HomeControl
        {
            var _loc_1:* = new Gift360HomeControl;
            instance = new Gift360HomeControl;
            return instance || _loc_1;
        }// end function

    }
}
