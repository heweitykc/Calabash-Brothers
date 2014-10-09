package com.game.prey.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.game.guide.model.*;
    import com.game.operationpanel.control.*;
    import com.game.pray.bean.*;
    import com.game.prey.protocol.*;
    import com.game.prey.view.*;

    public class PrayControl extends Object
    {
        private var _protocol:PrayProtocol;
        private var _prayBox:PrayBox;
        private var _prayInfo:PrayInfo;
        private static var _instance:PrayControl;

        public function PrayControl()
        {
            this._protocol = new PrayProtocol();
            return;
        }// end function

        private function initprayBox() : PrayBox
        {
            if (!this._prayBox)
            {
                this._prayBox = new PrayBox();
                Global.popManager.addPop(this._prayBox);
            }
            return this._prayBox;
        }// end function

        public function setPrayInfo(param1:PrayInfo) : void
        {
            this._prayInfo = param1;
            if (this._prayBox && this._prayBox.isOpen)
            {
                this._prayBox.setPrayInfo(param1);
            }
            OperationPanelControl.getInstance().panel.setPrayCount(param1.prayExpTimes + param1.prayGoldTimes);
            FrameworkGlobal.sendMsg(new GameEvent(GameEvent.PLAYER_PRAY_INFO_UPDATE, param1));
            return;
        }// end function

        public function prayResult(param1:int, param2:Boolean) : void
        {
            if (this._prayBox && this._prayBox.isOpen)
            {
                if (param2)
                {
                    this._prayBox.showResultEffect(param1);
                }
            }
            return;
        }// end function

        public function get prayInfo() : PrayInfo
        {
            return this._prayInfo;
        }// end function

        public function reqPray(param1:int) : void
        {
            this._protocol.reqPray(param1);
            return;
        }// end function

        public function reqPrayInfo() : void
        {
            this._protocol.reqPrayInfo();
            return;
        }// end function

        public function openOrClosePrayBox() : void
        {
            if (!GuideConfigObj.getInstance().isOpenFunction(GuideConfigObj.getInstance().PRAY_ACTIVE_TEAM))
            {
                return;
            }
            this.initprayBox().openOrClose();
            return;
        }// end function

        public static function getInstance() : PrayControl
        {
            if (!_instance)
            {
                _instance = new PrayControl;
            }
            return _instance;
        }// end function

    }
}
