package com.game.historymsg.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.cue.*;
    import com.game.historymsg.control.*;
    import com.game.historymsg.event.*;
    import com.game.historymsg.model.*;
    import flash.events.*;

    public class HistorymsgIcon extends ServerHitIcon
    {
        private var historymsgData:HistorymsgData;

        public function HistorymsgIcon()
        {
            this.historymsgData = HistorymsgData.getInstance();
            super("expireServerIcon");
            _content.gotoAndStop(1);
            mouseChildren = false;
            type = "HistorymsgIcon";
            tipsStr = LanguageCfgObj.getInstance().getByIndex("10859");
            count = 0;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }// end function

        public function show() : void
        {
            if (!stage)
            {
                Global.popManager.addedServerToCue(this);
            }
            return;
        }// end function

        public function hide() : void
        {
            if (stage)
            {
                Global.popManager.removeServerToCue(this);
            }
            return;
        }// end function

        public function get showing() : Boolean
        {
            return stage != null;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.historymsgData.addEventListener(HistorymsgEvent.HISTORYMSG_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.historymsgData.removeEventListener(HistorymsgEvent.HISTORYMSG_DATA_CHANGE, this.refreshData);
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            count = this.historymsgData.msgs.length;
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            HistorymsgControl.getInstance().openMsgListPanel();
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            _content.gotoAndStop(2);
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            _content.gotoAndStop(1);
            return;
        }// end function

    }
}
