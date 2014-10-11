package com.game.challenge.view
{
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.game.challenge.control.*;
    import com.game.challenge.event.*;
    import com.game.challenge.model.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class BossGuideEventView extends Component
    {
        private var _eventList:List;

        public function BossGuideEventView()
        {
            initComponentUI("bossGuide_bossGuideEvent");
            this.move(14, 84);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._eventList = new List(754, 382);
            this._eventList.move(8, 8);
            this._eventList.cellRenderer = DropEventItem;
            addChild(this._eventList);
            return;
        }// end function

        private function addListener() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
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

        private function freshInfo(event:BossGuideEvent) : void
        {
            var _loc_2:* = event.currentTarget as BossInfo;
            this._eventList.reset();
            this._eventList.objs = _loc_2.dropLog;
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            BossGuideControl.getInstance().bossInfo.addEvtListener(BossGuideEvent.UPDATELOG, this.freshInfo);
            BossGuideControl.getInstance().reqSelectChallengeToGame(2);
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            BossGuideControl.getInstance().bossInfo.removeEvtListener(BossGuideEvent.UPDATELOG, this.freshInfo);
            return;
        }// end function

    }
}
