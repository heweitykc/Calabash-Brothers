package com.game.offline.control
{
    import com.*;
    import com.game.offline.message.*;
    import com.game.offline.protocol.*;
    import com.game.offline.view.*;
    import com.game.signwage.control.*;
    import com.game.signwage.view.*;
    import com.game.utils.*;
    import com.model.*;

    public class OfflineControl extends Object
    {
        private var _protocol:OfflineProtocol;
        private var _offlinePanel:OfflinePanel;
        private var _offlineView:OfflineExpView;
        private var _stoneNum:int;
        private var _getExp:int;
        private var _canExp:long;
        private static var _instance:OfflineControl;

        public function OfflineControl()
        {
            this._protocol = new OfflineProtocol();
            return;
        }// end function

        public function get offlineView() : OfflineExpView
        {
            return this._offlineView;
        }// end function

        public function set offlineView(param1:OfflineExpView) : void
        {
            this._offlineView = param1;
            return;
        }// end function

        public function get canExp() : long
        {
            return this._canExp;
        }// end function

        public function get getExp() : int
        {
            return this._getExp;
        }// end function

        public function get stoneNum() : int
        {
            return this._stoneNum;
        }// end function

        private function get offlinePanel() : OfflinePanel
        {
            if (!this._offlinePanel)
            {
                this._offlinePanel = new OfflinePanel();
            }
            Global.popManager.addPop(this._offlinePanel);
            return this._offlinePanel;
        }// end function

        public function retreatInfo(param1:ResRetreatInfoMessage) : void
        {
            if (this._offlinePanel)
            {
                this._offlinePanel.upataData(param1.notifyType, param1.curTime, param1.curExp, param1.curZhenqi);
            }
            var _loc_2:* = false;
            if (this._stoneNum != param1.curZhenqi || this._getExp != param1.curTime || this._canExp != param1.curExp)
            {
                _loc_2 = true;
            }
            this._stoneNum = param1.curZhenqi;
            this._getExp = param1.curTime;
            this._canExp = param1.curExp;
            if (_loc_2)
            {
                SignWageControl.getInstance().setOffineExpTab();
                if (this._offlineView)
                {
                    this._offlineView.update();
                }
            }
            return;
        }// end function

        public function isShowOffineExp() : Boolean
        {
            return UserObj.getInstance().playerInfo.offlineExp > 5;
        }// end function

        public function openOrCloseOfflinePanel() : void
        {
            this.offlinePanel.openOrClose();
            return;
        }// end function

        public function getRetreatInfo() : void
        {
            this._protocol.reqRetreatInfo();
            return;
        }// end function

        public function getSingleExp() : void
        {
            this._protocol.reqGetRetreatAward(0);
            return;
        }// end function

        public function getThreeEx() : void
        {
            this._protocol.reqGetRetreatAward(1);
            return;
        }// end function

        public function getDoubleEx() : void
        {
            this._protocol.reqGetRetreatAward(2);
            return;
        }// end function

        public function getTenEx() : void
        {
            this._protocol.reqGetRetreatAward(3);
            return;
        }// end function

        public static function get instance() : OfflineControl
        {
            if (!_instance)
            {
                _instance = new OfflineControl;
            }
            return _instance;
        }// end function

        public static function getInstance() : OfflineControl
        {
            return instance;
        }// end function

    }
}
