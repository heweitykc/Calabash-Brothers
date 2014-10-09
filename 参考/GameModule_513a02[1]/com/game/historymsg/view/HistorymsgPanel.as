package com.game.historymsg.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.historymsg.bean.*;
    import com.game.historymsg.util.*;
    import flash.events.*;
    import flash.text.*;

    public class HistorymsgPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var btnOk:BaseButton;
        private var viewTitle:TextField;
        private var viewContent:TextField;
        private var contentViewCenterY:int;
        public var msg:HistorymsgMsg;

        public function HistorymsgPanel()
        {
            loadDisplay("res/historymsgPanel.swf");
            Global.popManager.addPop(this);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("historymsgPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = HistorymsgUiUtil.createButton(this, "btnClose", this.onClose);
            this.btnOk = HistorymsgUiUtil.createButton(this, "btnOk", this.onClose);
            this.btnOk.setText(LanguageCfgObj.getInstance().getByIndex("10863"));
            this.viewTitle = getDisplayChildByName("viewTitle");
            this.viewContent = getDisplayChildByName("viewContent");
            this.contentViewCenterY = this.viewContent.y + this.viewContent.height / 2;
            this.viewContent.autoSize = TextFieldAutoSize.LEFT;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            return;
        }// end function

        public function show(param1:HistorymsgMsg) : void
        {
            this.msg = param1;
            if (stage)
            {
                this.initData();
            }
            else
            {
                open();
            }
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            this.viewTitle.text = this.msg.title;
            this.viewContent.htmlText = this.msg.content;
            this.viewContent.y = this.contentViewCenterY - this.viewContent.height / 2;
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
