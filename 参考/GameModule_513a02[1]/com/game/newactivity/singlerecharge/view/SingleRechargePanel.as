package com.game.newactivity.singlerecharge.view
{
    import com.events.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class SingleRechargePanel extends BaseBox
    {
        private var _closeBtn:BaseButton;
        private var _rechargeBtn:BaseButton;
        private var _actTime:TextField;
        private var _restTime:TextField;
        private var _itemList:List;
        private var _info:NewActivityInfo;

        public function SingleRechargePanel()
        {
            super(null, 100);
            setWH(869, 584);
            this._info = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_SINGLE_RECHARGE);
            if (!this._info.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this._info.activityId);
            }
            this._info.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
            this._info.addEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.updateAllInfo);
            loadDisplay("res/singlerecharge.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("singleRechargeView", 100);
            this.initUI();
            super.displayReady();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.setAuto(true);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.setAuto(false);
            return;
        }// end function

        private function initUI() : void
        {
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("rechargeBtn"));
            this._actTime = getDisplayChildByName("actTime") as TextField;
            this._restTime = getDisplayChildByName("restTime") as TextField;
            this.addListener();
            this.updateByActivityInfo();
            return;
        }// end function

        private function _resetList() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (!this._itemList)
            {
                this._itemList = new List(470, 298, null, "scrollBar2");
                this._itemList.cellRenderer = SingleRechargeItem;
                this._itemList.objs = this._info.activityItemLists;
                this._itemList.move(275, 175);
                addChild(this._itemList);
            }
            else
            {
                _loc_1 = 0;
                _loc_2 = this._itemList.length;
                while (_loc_1 < _loc_2)
                {
                    
                    _loc_3 = this._itemList.getContent(_loc_1);
                    _loc_3.obj = this._info.activityItemLists[_loc_1];
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function _resetListWithAllInfo() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (!this._itemList)
            {
                this._itemList = new List(470, 298, null, "scrollBar2");
                this._itemList.cellRenderer = SingleRechargeItem;
                this._itemList.objs = this._info.activityItemLists;
                this._itemList.move(275, 175);
                addChild(this._itemList);
            }
            else
            {
                _loc_1 = 0;
                _loc_2 = this._itemList.length;
                while (_loc_1 < _loc_2)
                {
                    
                    _loc_3 = this._itemList.getContent(_loc_1);
                    SingleRechargeItem(_loc_3).resetAllInfoByObj(this._info.activityItemLists[_loc_1]);
                    _loc_1++;
                }
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._closeBtn.addEventListener(MouseEvent.CLICK, this.__closeClickHandler);
            this._rechargeBtn.addEventListener(MouseEvent.CLICK, this.__rechargeHandler);
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function removeListener() : void
        {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.__closeClickHandler);
            this._rechargeBtn.removeEventListener(MouseEvent.CLICK, this.__rechargeHandler);
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function _actDelHandler(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_SINGLE_RECHARGE)
            {
                this.removeListener();
                this.close();
            }
            return;
        }// end function

        private function __closeClickHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __rechargeHandler(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            ClickStream.add(ClickStreamId.CLICK_DanBiChongZhi_ChongDianXiaoQian);
            return;
        }// end function

        private function updateByActivityInfo(event:NewActivityEvent = null) : void
        {
            if (UILoaded && this._info && this._info.isDetailInit)
            {
                this._resetList();
                this._resetTimeView();
            }
            return;
        }// end function

        private function updateAllInfo(event:NewActivityEvent = null) : void
        {
            if (UILoaded && this._info && this._info.isDetailInit)
            {
                this._resetListWithAllInfo();
                this._resetTimeView();
            }
            return;
        }// end function

        private function _resetTimeView() : void
        {
            if (UILoaded && this._info && this._info.isDetailInit)
            {
                this._actTime.text = ToolKit.getFormatDate(this._info.beginTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022")) + "-" + ToolKit.getFormatDate(this._info.endTime * 1000, LanguageCfgObj.getInstance().getByIndex("10020") + LanguageCfgObj.getInstance().getByIndex("10021") + LanguageCfgObj.getInstance().getByIndex("10022"));
                this._timeCountUpdate();
            }
            return;
        }// end function

        private function _timeCountUpdate() : void
        {
            var _loc_1:* = NaN;
            if (UILoaded && this._info && this._info.isDetailInit)
            {
                _loc_1 = this._info.endTime - ToolKit.getServerTime() * 0.001;
                this._restTime.text = ToolKit.second2TimeStr(_loc_1, LanguageCfgObj.getInstance().getByIndex("10966"));
            }
            return;
        }// end function

        private function setAuto(param1:Boolean) : void
        {
            if (param1)
            {
                Ticker.registerTimer(1, this._timeCountUpdate);
            }
            else
            {
                Ticker.killTimer(this._timeCountUpdate);
            }
            return;
        }// end function

    }
}
