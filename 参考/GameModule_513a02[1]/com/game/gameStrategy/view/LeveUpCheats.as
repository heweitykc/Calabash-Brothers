package com.game.gameStrategy.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.challenge.view.component.*;
    import flash.events.*;

    public class LeveUpCheats extends Component
    {
        private var _fastLevelupBtn:BaseButton;
        private var _multiExpBtn:BaseButton;
        private var _automotorBtn:BaseButton;
        private var _tabPanel:TabManager;

        public function LeveUpCheats()
        {
            initComponentUI("gameStrategy_levelupCheats");
            this.move(10, 78);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._tabPanel = new TabManager();
            this._fastLevelupBtn = new BaseButton(getDisplayChildByName("fastLevelupBtn"), true);
            this._fastLevelupBtn.setText(LanguageCfgObj.getInstance().getByIndex("10694"));
            this._multiExpBtn = new BaseButton(getDisplayChildByName("multiExpBtn"), true);
            this._multiExpBtn.setText(LanguageCfgObj.getInstance().getByIndex("10695"));
            this._automotorBtn = new BaseButton(getDisplayChildByName("automotorBtn"), true);
            this._automotorBtn.setText(LanguageCfgObj.getInstance().getByIndex("10696"));
            this._tabPanel.add(this._fastLevelupBtn, getDisplayChildByName("text21"));
            this._tabPanel.add(this._multiExpBtn, getDisplayChildByName("text22"));
            this._tabPanel.add(this._automotorBtn, getDisplayChildByName("text23"));
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
