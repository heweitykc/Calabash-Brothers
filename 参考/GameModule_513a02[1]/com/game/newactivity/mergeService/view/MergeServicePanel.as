package com.game.newactivity.mergeService.view
{
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.model.*;
    import com.staticdata.*;
    import flash.events.*;

    public class MergeServicePanel extends BaseBox
    {
        private var _actType:String;
        private var _index:int;
        private var close_btn:BaseButton;
        private var _prevMergePanel:PrevMergePanel;
        private var _mergeActivityPanel:MergeActivityPanel;

        public function MergeServicePanel()
        {
            loadDisplay("res/mergeServicePanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("mergeServicePanel");
            this.initUI();
            this.actType = this._actType;
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.close_btn = new BaseButton(getDisplayChildByName("close_btn"));
            this.close_btn.addEvtListener(MouseEvent.CLICK, this.onClose);
            this._prevMergePanel = new PrevMergePanel(getDisplayChildByName("advancePanel"));
            this._prevMergePanel.visible = true;
            this._mergeActivityPanel = new MergeActivityPanel(getDisplayChildByName("mergeActivityPanel"));
            this._mergeActivityPanel.visible = false;
            return;
        }// end function

        private function onActivityGroupRemove(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_MERGE_SERVICE)
            {
                this.close();
            }
            if (int(event.data) == NewActivityConfig.GROUP_PREV_MERGE)
            {
                this.close();
            }
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            NewActivityModel.getInstance().addEvtListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this.onActivityGroupRemove);
            if (UILoaded)
            {
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._prevMergePanel.clearInfo();
            this._mergeActivityPanel.clearInfo();
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this.onActivityGroupRemove);
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function set actType(param1:String) : void
        {
            this._actType = param1;
            if (UILoaded)
            {
                if (this._actType == TopActivateName.MERGE_SERVICE)
                {
                    this._prevMergePanel.visible = false;
                    this._prevMergePanel.clearInfo();
                    this._mergeActivityPanel.visible = true;
                }
                else
                {
                    this._prevMergePanel.visible = true;
                    this._mergeActivityPanel.visible = false;
                    this._mergeActivityPanel.clearInfo();
                }
                if (this._actType == TopActivateName.MERGE_SERVICE)
                {
                    this._mergeActivityPanel.loadInfo(this._index);
                }
                else
                {
                    this._prevMergePanel.loadInfo();
                }
            }
            return;
        }// end function

        public function get actType() : String
        {
            return this._actType;
        }// end function

    }
}
