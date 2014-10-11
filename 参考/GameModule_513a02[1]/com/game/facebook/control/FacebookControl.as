package com.game.facebook.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.facebook.cfg.*;
    import com.game.facebook.locale.*;
    import com.game.facebook.view.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.task.events.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.external.*;

    public class FacebookControl extends Object
    {
        private var invitePanel:FacebookInvitePanel;
        private var sharePanel:FacebookSharePanel;
        private var shareDialog:FacebookShareDialog;
        private static var instance:FacebookControl;

        public function FacebookControl()
        {
            if (this.isFacebookUser)
            {
                FrameworkGlobal.addMsgListen(TaskEvent.DELETE_COMPLETE_TASK, this.onTaskFinish);
                if (ExternalInterface.available)
                {
                    ExternalInterface.addCallback("facebookShareCallback", this.onFacebookShareOK);
                }
            }
            return;
        }// end function

        public function openOrCloseInvitePanel() : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FACEBOOK_INVITE))
            {
                Global.popManager.addedToSystem(FacebookText.errActivityEnded);
                return;
            }
            if (!this.invitePanel)
            {
                this.invitePanel = new FacebookInvitePanel();
                Global.popManager.addPop(this.invitePanel);
            }
            this.invitePanel.openOrClose();
            return;
        }// end function

        public function openOrCloseSharePanel(param1:Boolean = false) : void
        {
            if (!NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_FACEBOOK_SHARE))
            {
                Global.popManager.addedToSystem(FacebookText.errActivityEnded);
                return;
            }
            if (!this.sharePanel)
            {
                this.sharePanel = new FacebookSharePanel();
                Global.popManager.addPop(this.sharePanel);
            }
            if (param1)
            {
                this.sharePanel.open();
            }
            else
            {
                this.sharePanel.openOrClose();
            }
            return;
        }// end function

        public function openSharePanel() : void
        {
            this.openOrCloseSharePanel(true);
            return;
        }// end function

        public function openShareDialog(param1:Function) : void
        {
            if (!this.shareDialog)
            {
                this.shareDialog = new FacebookShareDialog();
                Global.popManager.addPop(this.shareDialog, true, true, true, true, false, true);
            }
            this.shareDialog.show(param1);
            return;
        }// end function

        public function get isFacebookUser() : Boolean
        {
            return Params.isFacebookUser;
        }// end function

        private function onTaskFinish(event:TaskEvent) : void
        {
            var _loc_2:* = event.data;
            if (_loc_2 == GlobalCfgObj.getInstance().getOpenFacebookShareTaskId())
            {
                this.openSharePanel();
            }
            return;
        }// end function

        public function inviteFriends() : void
        {
            this.callJs("facebookInvite");
            return;
        }// end function

        public function gainInviteAward(param1:NewActivityInfo, param2:NewActivityItemInfo) : void
        {
            NewActivityControl.getInstance().getActivityReward(param1.activityId, param2.index);
            return;
        }// end function

        public function gainShareAward(param1:NewActivityItemInfo) : void
        {
            var activityItemInfo:* = param1;
            this.openShareDialog(function () : void
            {
                share(activityItemInfo);
                return;
            }// end function
            );
            return;
        }// end function

        private function share(param1:NewActivityItemInfo) : void
        {
            var _loc_2:* = FacebookShareCfgObj.getInstance().getCfg(param1.condiction);
            var _loc_3:* = param1.index.toString();
            this.callJs("facebookShare", _loc_2.q_feed_name, _loc_2.q_feed_caption, _loc_2.q_feed_description, _loc_3);
            if (!ExternalInterface.available)
            {
                this.onFacebookShareOK(_loc_3);
            }
            return;
        }// end function

        private function onFacebookShareOK(param1:String) : void
        {
            var _loc_2:* = int(param1);
            NewActivityControl.getInstance().getActivityReward(NewActivityConfig.ACTID_FACEBOOK_SHARE, _loc_2);
            return;
        }// end function

        private function callJs(param1:String, ... args) : void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call.apply(null, [param1].concat(args));
            }
            return;
        }// end function

        public static function getInstance() : FacebookControl
        {
            var _loc_1:* = new FacebookControl;
            instance = new FacebookControl;
            return instance || _loc_1;
        }// end function

    }
}
