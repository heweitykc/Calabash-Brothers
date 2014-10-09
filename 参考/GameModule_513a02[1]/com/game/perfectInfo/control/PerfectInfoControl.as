package com.game.perfectInfo.control
{
    import com.*;
    import com.game.perfectInfo.protocol.*;
    import com.game.perfectInfo.view.*;

    public class PerfectInfoControl extends Object
    {
        private var _protocol:PerfectInfoProtocol;
        private var _perfectInfoPanel:PerfectInfoPanel;
        private static var _instance:PerfectInfoControl;

        public function PerfectInfoControl()
        {
            this._protocol = new PerfectInfoProtocol();
            return;
        }// end function

        public function gainRewardResult(param1:Boolean) : void
        {
            if (this._perfectInfoPanel)
            {
                this._perfectInfoPanel.gainRewardResult(param1);
            }
            return;
        }// end function

        public function submitInfoResult(param1:Boolean) : void
        {
            if (this._perfectInfoPanel)
            {
                this._perfectInfoPanel.submitInfoResult(param1);
            }
            return;
        }// end function

        public function openOrColsePerfectPanel() : void
        {
            if (!this._perfectInfoPanel)
            {
                this._perfectInfoPanel = new PerfectInfoPanel();
                Global.popManager.addPop(this._perfectInfoPanel);
            }
            this._perfectInfoPanel.openOrClose();
            return;
        }// end function

        public function reqSubmitImproveData(param1:String, param2:String) : void
        {
            this._protocol.reqSubmitImproveData(param1, param2);
            return;
        }// end function

        public function reqCollectImproveReward() : void
        {
            this._protocol.reqCollectImproveReward();
            return;
        }// end function

        public static function getInstance() : PerfectInfoControl
        {
            if (!_instance)
            {
                _instance = new PerfectInfoControl;
            }
            return _instance;
        }// end function

    }
}
