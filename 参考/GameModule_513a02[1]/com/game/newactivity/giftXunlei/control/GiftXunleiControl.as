package com.game.newactivity.giftXunlei.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.locale.*;
    import com.game.newactivity.giftXunlei.view.*;
    import com.game.newactivity.handler.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class GiftXunleiControl extends Object
    {
        private var panel:GiftXunleiPanel;
        private static var instance:GiftXunleiControl;

        public function GiftXunleiControl()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_XUNLEI))
            {
                Global.popManager.addedToSystem(GiftText.errActivityEnded);
                return;
            }
            ResGetPlatformGiftErrorHandler.handler = this.resGetPlatformGiftError;
            if (!this.panel)
            {
                this.panel = new GiftXunleiPanel();
                Global.popManager.addPop(this.panel);
            }
            this.panel.openOrClose();
            return;
        }// end function

        public function gotoOpenVipWebsite() : void
        {
            JSTools.openWindow(GlobalCfgObj.getInstance().getGiftXunleiWebsite());
            return;
        }// end function

        public function resGetPlatformGiftError(param1:ResGetPlatformGiftError) : void
        {
            switch(param1.errorId)
            {
                case 1:
                {
                    Global.popManager.addedToMouseCue(GiftText.errXunleiGetGiftError1);
                    break;
                }
                case 2:
                {
                    Global.popManager.addedToMouseCue(GiftText.errXunleiGetGiftError2);
                    break;
                }
                case 3:
                {
                    this.cueToWebsite(GiftText.errXunleiVipLevelNotEnough);
                    break;
                }
                case 4:
                {
                    Global.popManager.addedToMouseCue(GiftText.errXunleiGetGiftError3);
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
            Global.popManager.cue(param1, GiftText.txtTip, null, this.gotoOpenVipWebsite, null, 2, GiftText.btnOpenContinue);
            return;
        }// end function

        public static function getInstance() : GiftXunleiControl
        {
            var _loc_1:* = new GiftXunleiControl;
            instance = new GiftXunleiControl;
            return instance || _loc_1;
        }// end function

    }
}
