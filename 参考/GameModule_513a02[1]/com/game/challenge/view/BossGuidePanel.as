package com.game.challenge.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class BossGuidePanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var _tabBtn1:BaseButton;
        private var _tabBtn2:BaseButton;
        private var _tabBtn3:BaseButton;
        private var _tabBtn4:BaseButton;
        private var _tab:TabManager;
        private static var swf:String = "res/bossGuide.swf";

        public function BossGuidePanel()
        {
            loadDisplay(swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("bossGuide_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._tabBtn1 = new BaseButton(getDisplayChildByName("tabBtn1"), true);
            this._tabBtn1.setText(LanguageCfgObj.getInstance().getByIndex("10433"));
            this._tabBtn2 = new BaseButton(getDisplayChildByName("tabBtn2"), true);
            this._tabBtn2.setText(LanguageCfgObj.getInstance().getByIndex("10434"));
            this._tabBtn3 = new BaseButton(getDisplayChildByName("tabBtn3"), true);
            this._tabBtn3.setText(LanguageCfgObj.getInstance().getByIndex("10435"));
            this._tabBtn4 = new BaseButton(getDisplayChildByName("tabBtn4"), true);
            this._tabBtn4.setText(LanguageCfgObj.getInstance().getByIndex("10436"));
            this._tab = new TabManager();
            this._tab.add(this._tabBtn1, BossGradeView);
            this._tab.add(this._tabBtn2, BossTreasureView, 2);
            this._tab.add(this._tabBtn3, BossTreasureView, 3);
            this._tab.add(this._tabBtn4, BossGuideEventView);
            addChild(this._tab);
            this._tab.selected = 0;
            this.addEvents();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

    }
}
