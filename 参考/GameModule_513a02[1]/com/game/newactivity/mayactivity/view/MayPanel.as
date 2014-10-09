package com.game.newactivity.mayactivity.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class MayPanel extends BaseBox
    {
        private var archangelComing:MayArchangelComingView;
        private var fireCrackerView:MayFireCrackersView;
        private var jewelryView:MayJewelryView;
        private var oneGiftView:MayOneGiftView;
        private var restTime:TextField;
        private var page_map:Dictionary;
        private var btnDic:Dictionary;
        private var closeBtn:BaseButton;
        private var ACTIVITY_MAP:Dictionary;
        private var _curSelIndex:int;
        private var _infoArr:Dictionary;
        private var _enable:Boolean = false;

        public function MayPanel()
        {
            this.page_map = new Dictionary();
            this.page_map[1] = this.oneGiftView;
            this.page_map[2] = this.fireCrackerView;
            this.page_map[3] = this.jewelryView;
            this.page_map[4] = this.archangelComing;
            this.ACTIVITY_MAP = new Dictionary();
            this.ACTIVITY_MAP[1] = NewActivityConfig.ACTID_MAY_ACTIVITY_5;
            this.ACTIVITY_MAP[2] = NewActivityConfig.ACTID_MAY_ACTIVITY_2;
            this.ACTIVITY_MAP[3] = NewActivityConfig.ACTID_MAY_ACTIVITY_3;
            this.ACTIVITY_MAP[4] = NewActivityConfig.ACTID_MAY_ACTIVITY_4;
            setWH(774, 550);
            _peaceBox = ["*"];
            loadDisplay("res/mayactivity.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("mayActivityView");
            this.initUI();
            this.curSelIndex = this._curSelIndex;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            this._infoArr = new Dictionary();
            this.page_map[1] = new MayOneGiftView(getDisplayChildByName("item_1"));
            this.page_map[2] = new MayFireCrackersView(getDisplayChildByName("item_2"));
            this.page_map[3] = new MayJewelryView(getDisplayChildByName("item_3"));
            this.page_map[4] = new MayArchangelComingView(getDisplayChildByName("item_4"));
            this.btnDic = new Dictionary();
            var _loc_2:* = 1;
            _loc_2 = 1;
            while (_loc_2 <= 4)
            {
                
                this.btnDic[_loc_2] = new BaseButton(getDisplayChildByName("btn" + _loc_2));
                this.btnDic[_loc_2].name = _loc_2;
                _loc_1 = NewActivityModel.getInstance().getActivityByActivityId(this.ACTIVITY_MAP[_loc_2]);
                if (!_loc_1.isDetailInit)
                {
                    NewActivityControl.getInstance().getActivityInfo(_loc_1.activityId);
                }
                _loc_1.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
                this._infoArr[_loc_2] = _loc_1;
                _loc_2++;
            }
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.__closeClickHandler);
            _loc_2 = 1;
            while (_loc_2 <= 4)
            {
                
                this.page_map[_loc_2].visible = false;
                _loc_2++;
            }
            this.restTime = getDisplayChildByName("restTime");
            this.addListener();
            return;
        }// end function

        private function addListener() : void
        {
            var _loc_1:* = 1;
            _loc_1 = 1;
            while (_loc_1 <= 4)
            {
                
                this.btnDic[_loc_1].addEventListener(MouseEvent.CLICK, this.clickBtnHandler);
                _loc_1++;
            }
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function _actDelHandler(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_MAY_ACTIVITY)
            {
                this.removeListener();
                close();
            }
            return;
        }// end function

        private function removeListener() : void
        {
            var _loc_1:* = 0;
            if (UILoaded)
            {
                _loc_1 = 1;
                _loc_1 = 1;
                while (_loc_1 <= 4)
                {
                    
                    this.btnDic[_loc_1].removeEventListener(MouseEvent.CLICK, this.clickBtnHandler);
                    _loc_1++;
                }
            }
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function clickBtnHandler(event:MouseEvent) : void
        {
            var _loc_2:* = int(event.currentTarget.name);
            this.curSelIndex = _loc_2;
            return;
        }// end function

        private function __closeClickHandler(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        public function get curSelIndex() : int
        {
            return this._curSelIndex;
        }// end function

        public function set curSelIndex(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (!UILoaded)
            {
                this._curSelIndex = param1;
                return;
            }
            if (this.btnDic[this._curSelIndex])
            {
                _loc_2 = this.btnDic[this._curSelIndex];
                _loc_2.selected = false;
                _loc_2.enabled = true;
            }
            this._curSelIndex = param1;
            _loc_2 = this.btnDic[this._curSelIndex];
            if (!_loc_2)
            {
                return;
            }
            _loc_2.selected = true;
            _loc_2.enabled = false;
            _loc_3 = 1;
            while (_loc_3 <= 4)
            {
                
                this.page_map[_loc_3].visible = false;
                _loc_3++;
            }
            NewActivityControl.getInstance().getActivityInfo(this._infoArr[this._curSelIndex].activityId);
            this.updateByIndex();
            return;
        }// end function

        private function updateByActivityInfo(event:NewActivityEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.data as NewActivityInfo;
            if (UILoaded && _loc_2 && _loc_2.isDetailInit && _loc_2.activityId == this.ACTIVITY_MAP[this._curSelIndex])
            {
                if (!this.btnDic[this._curSelIndex])
                {
                    return;
                }
                _loc_3 = this._infoArr[this._curSelIndex];
                if (!_loc_3 || !_loc_3.isDetailInit)
                {
                    return;
                }
                this.updateByIndex();
                this.page_map[this._curSelIndex].visible = true;
            }
            return;
        }// end function

        private function updateByIndex() : void
        {
            if (!UILoaded)
            {
                return;
            }
            if (this.btnDic[this._curSelIndex] == -1)
            {
                return;
            }
            var _loc_1:* = this._infoArr[this._curSelIndex];
            if (!_loc_1 || !_loc_1.isDetailInit)
            {
                return;
            }
            IMayActView(this.page_map[this._curSelIndex]).updateByActInfo(_loc_1);
            if (this._curSelIndex == 4)
            {
                NewActivityControl.getInstance().getActivityRankInfo(_loc_1.activityId);
            }
            this._timeCountUpdate();
            return;
        }// end function

        private function _timeCountUpdate() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            if (!UILoaded)
            {
                return;
            }
            if (!this._infoArr[this._curSelIndex])
            {
                return;
            }
            var _loc_1:* = this._infoArr[this._curSelIndex];
            if (UILoaded && _loc_1 && _loc_1.isDetailInit)
            {
                _loc_2 = _loc_1.endTime - ToolKit.getServerTime() * 0.001;
                if (_loc_2 < 0)
                {
                    this.restTime.text = LanguageCfgObj.getInstance().getByIndex("10963");
                    this.setAuto(false);
                }
                else
                {
                    _loc_3 = ToolKit.second2TimeStr(_loc_2, LanguageCfgObj.getInstance().getByIndex("10026") + LanguageCfgObj.getInstance().getByIndex("10027") + LanguageCfgObj.getInstance().getByIndex("10028"));
                    if (_loc_3 == "")
                    {
                        this.restTime.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11968"), [Math.ceil(_loc_2)]);
                    }
                    else
                    {
                        this.restTime.text = _loc_3;
                    }
                    this.setAuto(true);
                }
            }
            return;
        }// end function

        private function setAuto(param1:Boolean) : void
        {
            if (this._enable == param1)
            {
                return;
            }
            this._enable = param1;
            Ticker.killTimer(this._timeCountUpdate);
            if (param1)
            {
                Ticker.registerTimer(1, this._timeCountUpdate);
            }
            return;
        }// end function

    }
}
