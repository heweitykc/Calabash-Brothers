package com.game.gameStrategy.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class MakeMoneyView extends Component
    {
        private var _getMoneyBtn:BaseButton;
        private var _getBindGoldBtn:BaseButton;
        private var _tabPanel:TabManager;

        public function MakeMoneyView()
        {
            initComponentUI("gameStrategy_makemoney");
            this.move(10, 78);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._tabPanel = new TabManager();
            this._getMoneyBtn = new BaseButton(getDisplayChildByName("getMoneyBtn"), true);
            this._getMoneyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10697"));
            this._getBindGoldBtn = new BaseButton(getDisplayChildByName("getBindGoldBtn"), true);
            this._getBindGoldBtn.setText(LanguageCfgObj.getInstance().getByIndex("10698"));
            this._tabPanel.add(this._getMoneyBtn, getDisplayChildByName("text31"));
            this._tabPanel.add(this._getBindGoldBtn, getDisplayChildByName("text32"));
            addChild(this._tabPanel);
            this._tabPanel.selected = 0;
            return;
        }// end function

        private function addListener() : void
        {
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

        private function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            return;
        }// end function

    }
}
