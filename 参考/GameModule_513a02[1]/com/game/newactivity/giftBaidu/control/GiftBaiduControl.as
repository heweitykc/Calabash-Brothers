package com.game.newactivity.giftBaidu.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.locale.*;
    import com.game.newactivity.giftBaidu.view.*;
    import com.game.newactivity.handler.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class GiftBaiduControl extends Object
    {
        private var panel:GiftBaiduPanel;
        private static var instance:GiftBaiduControl;

        public function GiftBaiduControl()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_BAIDU))
            {
                Global.popManager.addedToSystem(GiftText.errActivityEnded);
                return;
            }
            ResGetPlatformGiftErrorHandler.handler = this.resGetPlatformGiftError;
            if (!this.panel)
            {
                this.panel = new GiftBaiduPanel();
                Global.popManager.addPop(this.panel);
            }
            this.panel.openOrClose();
            return;
        }// end function

        public function gotoOpenVipWebsite() : void
        {
            JSTools.openWindow(GlobalCfgObj.getInstance().getGiftBaiduOpenVipWebsite());
            return;
        }// end function

        public function resGetPlatformGiftError(param1:ResGetPlatformGiftError) : void
        {
            switch(param1.errorId)
            {
                case -1:
                {
                    this.cueToWebsite(GiftText.errBaiduVipLevelNotEnough, GiftText.btnUpgradeVipNow);
                    break;
                }
                case -2:
                {
                    Global.popManager.addedToMouseCue(GiftText.errActivityNotStarted);
                    break;
                }
                case -3:
                {
                    Global.popManager.addedToMouseCue(GiftText.errSystemError);
                    break;
                }
                case -4:
                {
                    this.cueToWebsite(GiftText.errNotBaiduVip, GiftText.btnOpenVipNow);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cueToWebsite(param1:String, param2:String) : void
        {
            Global.popManager.cue(param1, GiftText.txtTip, null, this.gotoOpenVipWebsite, null, 2, param2);
            return;
        }// end function

        public static function getInstance() : GiftBaiduControl
        {
            var _loc_1:* = new GiftBaiduControl;
            instance = new GiftBaiduControl;
            return instance || _loc_1;
        }// end function

    }
}
