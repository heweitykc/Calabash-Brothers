package com.game.newactivity.nothink.view
{
    import com.events.*;
    import com.f1.ui.*;
    import com.f1.ui.container.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.icon.*;
    import flash.events.*;

    public class GiftNothinkContent extends Component
    {
        private var activityItemInfo:NewActivityItemInfo;
        private var awardsHbox:HBox;
        private static var activityInfo:NewActivityInfo;

        public function GiftNothinkContent()
        {
            mouseEnabled = false;
            mouseChildren = false;
            loadDisplay("res/nothink.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("noThink");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.awardsHbox = new HBox();
            this.awardsHbox.oneRow = 4;
            this.awardsHbox.intervalX = 10;
            this.awardsHbox.horizontal = true;
            this.addChild(this.awardsHbox);
            this.awardsHbox.move(29, 60);
            return;
        }// end function

        private function addEvents() : void
        {
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            if (activityInfo == null)
            {
                activityInfo = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_GIFT_Nothink);
                if (!activityInfo.isDetailInit)
                {
                    NewActivityControl.getInstance().getActivityInfo(activityInfo.activityId);
                }
            }
            activityInfo.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            activityInfo.addEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.refreshData);
            activityInfo.removeEventListener(NewActivityEvent.ACTIVITY_INFO_UPDATE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_5:* = null;
            if (activityInfo == null || !activityInfo.isDetailInit)
            {
                return;
            }
            var _loc_2:* = activityInfo.activityItemLists;
            if (_loc_2.length == 0)
            {
                return;
            }
            this.activityItemInfo = _loc_2[0];
            var _loc_3:* = this.activityItemInfo.jobAwardList;
            while (this.awardsHbox.contents.length)
            {
                
                this.awardsHbox.removeByIndex(0);
            }
            var _loc_4:* = 0;
            while (_loc_4 < 4 && _loc_4 < _loc_3.length)
            {
                
                _loc_5 = new IconItem("commonRewardBox40");
                _loc_5.image.move(8, 7);
                _loc_5.setWH(56, 56);
                _loc_5.setCountTxtXY(_loc_5.countTxt.x - 5, _loc_5.countTxt.y - 6);
                _loc_5.setInfo(_loc_3[_loc_4]);
                this.awardsHbox.add(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

    }
}
