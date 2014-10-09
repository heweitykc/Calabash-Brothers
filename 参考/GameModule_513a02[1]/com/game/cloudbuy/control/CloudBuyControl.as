package com.game.cloudbuy.control
{
    import com.*;
    import com.f1.*;
    import com.game.cloudbuy.message.*;
    import com.game.cloudbuy.model.*;
    import com.game.cloudbuy.protocol.*;
    import com.game.cloudbuy.view.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.prompt.utils.*;
    import com.greensock.*;
    import flash.geom.*;

    public class CloudBuyControl extends Object
    {
        private var _cloudBuyBox:CloudBuyBox;
        private var _cloudBuyTips:CloudBuyTips;
        private var _model:CloudBuyData;
        private var _protocol:CloudBuyProtocol;
        private static var _instance:CloudBuyControl;

        public function CloudBuyControl()
        {
            this._protocol = new CloudBuyProtocol();
            this._model = CloudBuyData.getInstance();
            return;
        }// end function

        public function get cloudBuyBox() : CloudBuyBox
        {
            return this._cloudBuyBox;
        }// end function

        public function get cloudBuyTips() : CloudBuyTips
        {
            return this._cloudBuyTips;
        }// end function

        public function openCloudBuyBox(param1:int = 1) : void
        {
            if (!this._cloudBuyBox)
            {
                this._cloudBuyBox = new CloudBuyBox();
                Global.popManager.addPop(this._cloudBuyBox);
            }
            this._cloudBuyBox.openOrClose();
            return;
        }// end function

        public function openCloudBuyTipsBox(param1:int) : void
        {
            if (!this._cloudBuyTips)
            {
                this._cloudBuyTips = new CloudBuyTips();
                Global.popManager.addPop(this._cloudBuyTips);
            }
            this._cloudBuyTips.maxNum = param1;
            this._cloudBuyTips.openOrClose();
            return;
        }// end function

        public function reqOpenCloudBuyInfo() : void
        {
            this._protocol.reqOpenCloudBuyInfo();
            return;
        }// end function

        public function reqCloudBuy(param1:int) : void
        {
            this._protocol.reqCloudBuy(param1);
            return;
        }// end function

        public function reqCloudBuyReward() : void
        {
            this._protocol.reqCloudBuyReward();
            return;
        }// end function

        public function resOpenCloudBuyInfoHandler(param1:ResOpenCloudBuyInfoToClientMessage) : void
        {
            CloudBuyData.getInstance().msg = param1;
            return;
        }// end function

        public function resCloudBuyHandler(param1:ResCloudBuyToClientMessage) : void
        {
            if (param1.isSuccess)
            {
                this.reqOpenCloudBuyInfo();
                if (this.cloudBuyBox)
                {
                    this.cloudBuyBox.playEffect();
                }
            }
            return;
        }// end function

        public function resRewardHandler(param1:ResRewardToClientMessage) : void
        {
            var _msg:ResOpenCloudBuyInfoToClientMessage;
            var count:int;
            var i:int;
            var msg:* = param1;
            if (msg.isSuccess)
            {
                this.reqOpenCloudBuyInfo();
                _msg = CloudBuyData.getInstance().msg;
                count;
                i;
                while (_msg.itemInfoList && i < _msg.itemInfoList.length)
                {
                    
                    TweenLite.delayedCall(i * 0.2, function () : void
            {
                ItemGetAnim.doFlyToBackPack(_msg.itemInfoList[count].itemModelId, new Point(FrameworkGlobal.stage.mouseX, FrameworkGlobal.stage.mouseY));
                var _loc_2:* = count + 1;
                count = _loc_2;
                return;
            }// end function
            );
                    i = (i + 1);
                }
            }
            return;
        }// end function

        public function resUpdateCloudBuyHandler(param1:ResUpdateCloudBuyToClientMessage) : void
        {
            MapControl.getInstance().showOrHideCloudBuy(Boolean(param1.status));
            return;
        }// end function

        public function resLoginCloudBuyInfoHandler(param1:ResLoginCloudBuyInfoToClientMessage) : void
        {
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_CLOUD_BUY, param1.rewardCount.toString());
            return;
        }// end function

        public static function getInstance() : CloudBuyControl
        {
            if (_instance == null)
            {
                _instance = new CloudBuyControl;
            }
            return _instance;
        }// end function

    }
}
