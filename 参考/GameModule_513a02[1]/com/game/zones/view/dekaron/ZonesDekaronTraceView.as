package com.game.zones.view.dekaron
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesDekaronTraceView extends Component
    {
        private var _txtPower:TextField;
        private var _txtAdvicePower:TextField;
        private var _tableInfo:ZonesTableVo;
        private var _txtFirstBreakName:TextField;
        private var _txtNearBreakName:TextField;
        private var _txtFirstBreakTime:TextField;
        private var _txtNearBreakJob:TextField;
        private var _txtNearBreakPower:TextField;

        public function ZonesDekaronTraceView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/zonetasktrace.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("zones_dekaron_trace");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._txtAdvicePower = TextField(getDisplayChildByName("txt_advice_power"));
            this._txtPower = TextField(getDisplayChildByName("txt_power"));
            this._txtFirstBreakName = TextField(getDisplayChildByName("txt_first_break_name"));
            this._txtFirstBreakTime = TextField(getDisplayChildByName("txt_first_break_time"));
            this._txtNearBreakName = TextField(getDisplayChildByName("txt_near_break_name"));
            this._txtNearBreakJob = TextField(getDisplayChildByName("txt_near_break_job"));
            this._txtNearBreakPower = TextField(getDisplayChildByName("txt_near_break_power"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.freshPanel();
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.freshPanel();
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function freshPanel() : void
        {
            var _loc_3:* = null;
            if (!this.UILoaded)
            {
                return;
            }
            var _loc_1:* = ZonesModel.getInstance().zoneid;
            var _loc_2:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_1);
            this._tableInfo = _loc_2;
            if (_loc_2)
            {
                this._txtAdvicePower.text = ToolKit.getMoneyString(this._tableInfo.fighting_value);
                this._txtPower.text = ToolKit.getMoneyString(UserObj.getInstance().playerInfo.fightPower);
                _loc_3 = ZonesModel.getInstance().dekaronInfo;
                if (_loc_3 && _loc_3.bestTime > 0)
                {
                    this._txtFirstBreakName.htmlText = "<font color = \'#00ff00\'><u>" + _loc_3.bestName + "</u></font>";
                    this._txtFirstBreakTime.text = ToolKit.getTimeBySecond(_loc_3.bestTime);
                    this._txtNearBreakName.htmlText = "<font color = \'#00ff00\'><u>" + _loc_3.latelyName + "</u></font>";
                    this._txtNearBreakJob.text = JobType.getJobName(_loc_3.latelyJob);
                    this._txtNearBreakPower.text = _loc_3.latelyFightPower.toString();
                }
                else
                {
                    this._txtFirstBreakName.htmlText = LanguageCfgObj.getInstance().getByIndex("11523");
                    this._txtFirstBreakTime.text = "";
                    this._txtNearBreakName.htmlText = LanguageCfgObj.getInstance().getByIndex("11524");
                    this._txtNearBreakJob.text = "";
                    this._txtNearBreakPower.text = "";
                }
            }
            return;
        }// end function

        public function updateInfo() : void
        {
            this.freshPanel();
            return;
        }// end function

        public function close() : void
        {
            this.cleanInfo();
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT_CENTER, -30, 0), GroupPanelType.GROUP_LOW);
            return;
        }// end function

        private function cleanInfo() : void
        {
            return;
        }// end function

    }
}
