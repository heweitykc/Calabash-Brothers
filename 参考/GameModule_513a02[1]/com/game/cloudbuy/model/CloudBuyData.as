package com.game.cloudbuy.model
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.cloudbuy.events.*;
    import com.game.cloudbuy.message.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;

    public class CloudBuyData extends BaseEventDispatcher
    {
        private var _cloudBuyID:int = 1;
        private var _lastCloudBuyID:int = 1;
        private var _cloudBuyState:int = 0;
        private var _msg:ResOpenCloudBuyInfoToClientMessage;
        private static var _instance:CloudBuyData;

        public function CloudBuyData()
        {
            return;
        }// end function

        public function get cloudBuyID() : int
        {
            return this._cloudBuyID;
        }// end function

        public function set cloudBuyID(param1:int) : void
        {
            this._cloudBuyID = param1;
            return;
        }// end function

        public function get lastCloudBuyID() : int
        {
            return this._lastCloudBuyID;
        }// end function

        public function set lastCloudBuyID(param1:int) : void
        {
            this._lastCloudBuyID = param1;
            return;
        }// end function

        public function get cloudBuyState() : int
        {
            return this._cloudBuyState;
        }// end function

        public function set cloudBuyState(param1:int) : void
        {
            this._cloudBuyState = param1;
            return;
        }// end function

        public function get msg() : ResOpenCloudBuyInfoToClientMessage
        {
            return this._msg;
        }// end function

        public function set msg(param1:ResOpenCloudBuyInfoToClientMessage) : void
        {
            this._msg = param1;
            this.cloudBuyID = this.msg.cloudBuyID;
            this.cloudBuyState = this.msg.isReward;
            this.lastCloudBuyID = this.msg.lastCloudBuyID;
            dispatchEvt(new CloudBuyEvent(CloudBuyEvent.CLOUD_BUY_INFO_CHANGE, null));
            var _loc_2:* = this.msg.end.toNumber() - ToolKit.getServerTime();
            _loc_2 = _loc_2 / 1000;
            if (_loc_2 < 0)
            {
                _loc_2 = 0;
            }
            if (_loc_2 >= 1)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_CLOUD_BUY, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_CLOUD_BUY, false);
            }
            return;
        }// end function

        public static function getInstance() : CloudBuyData
        {
            if (_instance == null)
            {
                _instance = new CloudBuyData;
            }
            return _instance;
        }// end function

    }
}
