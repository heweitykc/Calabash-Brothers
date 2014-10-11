package com.game.newactivity.gift360.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.utils.*;
    import com.game.newactivity.gift.locale.*;
    import com.game.newactivity.gift360.view.*;
    import com.game.newactivity.handler.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;

    public class Gift360Control extends Object
    {
        private var panel:Gift360Panel;
        private static var instance:Gift360Control;

        public function Gift360Control()
        {
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_360))
            {
                Global.popManager.addedToSystem(GiftText.errActivityEnded);
                return;
            }
            ResGetPlatformGiftErrorHandler.handler = this.resGetPlatformGiftError;
            if (!this.panel)
            {
                this.panel = new Gift360Panel();
                Global.popManager.addPop(this.panel);
            }
            this.panel.openOrClose();
            return;
        }// end function

        public function gotoWebsite() : void
        {
            JSTools.openWindow(GlobalCfgObj.getInstance().getGift360Website());
            return;
        }// end function

        public function resGetPlatformGiftError(param1:ResGetPlatformGiftError) : void
        {
            switch(param1.errorId)
            {
                case 0:
                {
                    Global.popManager.addedToMouseCue(GiftText.err360GetGiftError0);
                    break;
                }
                case -1:
                {
                    this.cueToWebsite(GiftText.err360GetGiftError1);
                    break;
                }
                case -2:
                {
                    this.cueToWebsite(GiftText.err360GetGiftError2);
                    break;
                }
                case -3:
                {
                    Global.popManager.addedToMouseCue(GiftText.err360GetGiftError3);
                    break;
                }
                case -4:
                {
                    this.cueToWebsite(GiftText.err360GetGiftError4);
                    break;
                }
                case -5:
                {
                    Global.popManager.addedToMouseCue(GiftText.err360GetGiftError5);
                    break;
                }
                case -6:
                {
                    Global.popManager.addedToMouseCue(GiftText.err360GetGiftError6);
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
            Global.popManager.cue(param1, GiftText.txtTip, null, this.gotoWebsite, null, 2, GiftText.btnClickToSeeDetail);
            return;
        }// end function

        public static function getInstance() : Gift360Control
        {
            var _loc_1:* = new Gift360Control;
            instance = new Gift360Control;
            return instance || _loc_1;
        }// end function

    }
}
