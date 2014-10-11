package com.game.newactivity.gift37.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.locale.*;
    import com.game.newactivity.gift37.view.*;
    import com.game.newactivity.handler.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class Gift37Control extends Object
    {
        private var panel:Gift37Panel;
        private static var instance:Gift37Control;

        public function Gift37Control()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_37))
            {
                Global.popManager.addedToSystem(GiftText.errActivityEnded);
                return;
            }
            ResGetPlatformGiftErrorHandler.handler = this.resGetPlatformGiftError;
            if (!this.panel)
            {
                this.panel = new Gift37Panel();
                Global.popManager.addPop(this.panel);
            }
            this.panel.openOrClose();
            return;
        }// end function

        public function gotoOpenVipWebsite() : void
        {
            JSTools.openWindow(GlobalCfgObj.getInstance().getGift37OpenVipWebsite());
            return;
        }// end function

        public function resGetPlatformGiftError(param1:ResGetPlatformGiftError) : void
        {
            switch(param1.errorId)
            {
                case -1:
                case -4:
                {
                    this.cueToWebsite(GiftText.err37VipLevelNotEnough);
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
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cueToWebsite(param1:String) : void
        {
            Global.popManager.cue(param1, GiftText.txtTip, null, this.gotoOpenVipWebsite, null, 2, GiftText.btnSeeDetail);
            return;
        }// end function

        public static function getInstance() : Gift37Control
        {
            var _loc_1:* = new Gift37Control;
            instance = new Gift37Control;
            return instance || _loc_1;
        }// end function

    }
}
