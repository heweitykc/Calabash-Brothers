package com.game.gameStrategy.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class GameStrategyBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var tab2Btn:BaseButton;
        private var tab3Btn:BaseButton;
        private var tab4Btn:BaseButton;
        private var tab5Btn:BaseButton;
        private var tabPages:TabManager;

        public function GameStrategyBox()
        {
            loadDisplay("res/gameStrategy.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("gameStrategy_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this.tab2Btn = new BaseButton(getDisplayChildByName("tab2Btn"), true);
            this.tab2Btn.setText(LanguageCfgObj.getInstance().getByIndex("10690"));
            this.tab3Btn = new BaseButton(getDisplayChildByName("tab3Btn"), true);
            this.tab3Btn.setText(LanguageCfgObj.getInstance().getByIndex("10691"));
            this.tab4Btn = new BaseButton(getDisplayChildByName("tab4Btn"), true);
            this.tab4Btn.setText(LanguageCfgObj.getInstance().getByIndex("10692"));
            this.tab5Btn = new BaseButton(getDisplayChildByName("tab5Btn"), true);
            this.tab5Btn.setText(LanguageCfgObj.getInstance().getByIndex("10693"));
            this.tabPages = new TabManager();
            this.tabPages.add(this.tab2Btn, FunctionOpenView);
            this.tabPages.add(this.tab3Btn, LeveUpCheats);
            this.tabPages.add(this.tab4Btn, MakeMoneyView);
            this.tabPages.add(this.tab5Btn, StrongCheatsView);
            this.closeBtn.parent.addChild(this.tabPages);
            this.tabPages.parent.setChildIndex(this.tabPages, this.tabPages.parent.numChildren - 4);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.tabPages.addEvtListener(Event.CHANGE, this.changeTab);
            this.tabPages.selected = 0;
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.closeBtn:
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

        private function changeTab(event:Event) : void
        {
            return;
        }// end function

    }
}
