package com.game.guide.view
{
    import com.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.vip.bean.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import flash.events.*;
    import flash.text.*;

    public class VipGuideCountView extends BaseButton
    {
        private var _text:TextField;
        private var _lastTimeId:String;
        private var _info:VipInfo;
        private var _timeCount:int;

        public function VipGuideCountView()
        {
            setWH(51, 63);
            loadDisplay("res/vipguidecount.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseButtonUI("vip_guide_count");
            this.initUI();
            this.updateView();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            addEventListener(MouseEvent.CLICK, this.__clickHandler, false, 0, true);
            this._text = getDisplayChildByName("txt") as TextField;
            this._info = VIPControl.getInstance().vipinfo;
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 327, 160));
            this.updateView();
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            if (this._lastTimeId)
            {
                TimerManager.killTimer(this._lastTimeId);
            }
            return;
        }// end function

        private function updateView() : void
        {
            if (UILoaded)
            {
                this._timeCount = VipModel.getInstance().getCount();
                this.refreshTime();
                this._lastTimeId = TimerManager.registerTimer(1, this._timeCount, this.refreshTime);
            }
            return;
        }// end function

        private function __clickHandler(event:MouseEvent) : void
        {
            VIPControl.getInstance().openOrCloseVip();
            return;
        }// end function

        private function refreshTime(event:TimerManagerEvent = null) : void
        {
            if (UILoaded)
            {
                this._text.text = ToolKit.second2TimeStr(VipModel.getInstance().getCount(), "ms");
            }
            var _loc_2:* = this;
            var _loc_3:* = this._timeCount - 1;
            _loc_2._timeCount = _loc_3;
            return;
        }// end function

    }
}
