package com.game.newactivity.mergeService.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class PrevMergePanel extends Component
    {
        private var _webUrl:String;
        private var _activityInfo:NewActivityInfo;
        private var _timeCount:int;
        private var _tabBar:Buttons;
        private var _scrollPanel:ScrollPanel;
        private var descTxt:TextField;
        private var bar:MovieClip;
        private var actCountDownTime:TextField;
        private var seeMoreBtn:BaseButton;

        public function PrevMergePanel(param1 = null, param2:String = null)
        {
            var _loc_6:* = null;
            super(param1, param2);
            this._tabBar = new Buttons();
            var _loc_3:* = 1;
            while (_loc_3 <= 1)
            {
                
                _loc_6 = new BaseButton(getDisplayChildByName("act_" + _loc_3), true);
                if (_loc_3 == 1)
                {
                    this._tabBar.move(_loc_6._x, _loc_6._y);
                }
                this._tabBar.add(_loc_6);
                _loc_3++;
            }
            addChild(this._tabBar);
            this.descTxt = getDisplayChildByName("descTxt");
            this.descTxt.selectable = false;
            this.descTxt.mouseEnabled = false;
            this.descTxt.mouseWheelEnabled = false;
            this.descTxt.tabEnabled = false;
            this.bar = getDisplayChildByName("bar");
            this.bar.stop();
            this.bar.parent.removeChild(this.bar);
            var _loc_4:* = this.descTxt.width + this.bar.width;
            var _loc_5:* = this.descTxt.height;
            this._scrollPanel = new ScrollPanel(_loc_4, _loc_5, "scrollBar2");
            this._scrollPanel.move(this.descTxt.x, this.descTxt.y);
            this._scrollPanel.content = this.descTxt;
            this._scrollPanel.setWH(_loc_4, _loc_5);
            addChild(this._scrollPanel);
            this.actCountDownTime = getDisplayChildByName("actCountDownTime");
            this.seeMoreBtn = new BaseButton(getDisplayChildByName("seeMoreBtn"));
            return;
        }// end function

        override public function finalize() : void
        {
            this.clearInfo();
            super.finalize();
            return;
        }// end function

        public function updateText(param1:String) : void
        {
            this.descTxt.htmlText = param1;
            this.descTxt.height = this.descTxt.textHeight + 5;
            this._scrollPanel.updateThumb();
            return;
        }// end function

        private function updateInfo(event:Event = null) : void
        {
            Ticker.killTimer(this.updateCountTime);
            this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_PREV_MERGE);
            this.seeMoreBtn.addEvtListener(MouseEvent.CLICK, this.onSeeMoreHandler);
            var _loc_2:* = StringUtil.clearJsonQuote(this._activityInfo.q_condDesc);
            _loc_2 = _loc_2.replace("{", "").replace("}", "").replace(/\"/g, "");
            var _loc_3:* = _loc_2.split(";");
            var _loc_4:* = _loc_3[0];
            var _loc_5:* = _loc_4.split(":");
            _loc_5.shift();
            _loc_4 = _loc_5.join(":");
            this.updateText(_loc_4);
            var _loc_6:* = _loc_3[1];
            _loc_5 = _loc_6.split(":");
            _loc_5.shift();
            _loc_6 = _loc_5.join(":");
            this._webUrl = _loc_6;
            this._timeCount = this._activityInfo.endTime - ToolKit.getServerTime() / 1000;
            this.updateTimeText();
            if (this._timeCount > 0)
            {
                Ticker.registerTimer(1, this.updateCountTime, null, this._timeCount);
            }
            return;
        }// end function

        private function updateCountTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._timeCount - 1;
            _loc_1._timeCount = _loc_2;
            this.updateTimeText();
            return;
        }// end function

        private function updateTimeText() : void
        {
            this.actCountDownTime.text = "" + ToolKit.second2TimeStr(this._timeCount, LanguageCfgObj.getInstance().getByIndex("10964"));
            return;
        }// end function

        public function clearInfo() : void
        {
            this.descTxt.text = "";
            this.seeMoreBtn.removeEventListener(MouseEvent.CLICK, this.onSeeMoreHandler);
            Ticker.killTimer(this.updateCountTime);
            if (this._activityInfo)
            {
                this._activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateInfo);
                this._activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.updateInfo);
            }
            this._activityInfo = null;
            return;
        }// end function

        public function loadInfo() : void
        {
            this._activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_PREV_MERGE);
            if (this._activityInfo)
            {
                this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateInfo);
                this._activityInfo.addEvtListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.updateInfo);
                NewActivityControl.getInstance().getActivityInfo(this._activityInfo.activityId);
            }
            if (this._activityInfo)
            {
                this.updateInfo();
            }
            return;
        }// end function

        private function onSeeMoreHandler(event:MouseEvent) : void
        {
            JSTools.openWindow(this._webUrl);
            return;
        }// end function

    }
}
