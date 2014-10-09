package com.game.gameStrategy.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.game.challenge.view.component.*;
    import flash.display.*;
    import flash.events.*;

    public class StrongCheatsView extends Component
    {
        private var _strongfastBtn:BaseButton;
        private var _strongtoolsBtn:BaseButton;
        private var _weaponBtn:BaseButton;
        private var _zhuoyueBtn:BaseButton;
        private var _strengthBtn:BaseButton;
        private var _lostskillBtn:BaseButton;
        private var _tabPanel:TabManager;
        private var _scrollpanel:ScrollPanel;
        private var _view1:DisplayObject;
        private var _view2:DisplayObject;
        private var _view3:DisplayObject;
        private var _view4:DisplayObject;
        private var _view5:DisplayObject;
        private var _view6:DisplayObject;

        public function StrongCheatsView()
        {
            initComponentUI("gameStrategy_strengthCheats");
            this.move(10, 78);
            this.initUI();
            this.addListener();
            return;
        }// end function

        private function initUI() : void
        {
            this._tabPanel = new TabManager();
            this._strongfastBtn = new BaseButton(getDisplayChildByName("strongfastBtn"), true);
            this._strongfastBtn.setText(LanguageCfgObj.getInstance().getByIndex("10699"));
            this._strongtoolsBtn = new BaseButton(getDisplayChildByName("strongtoolsBtn"), true);
            this._strongtoolsBtn.setText(LanguageCfgObj.getInstance().getByIndex("10700"));
            this._weaponBtn = new BaseButton(getDisplayChildByName("weaponBtn"), true);
            this._weaponBtn.setText(LanguageCfgObj.getInstance().getByIndex("10701"));
            this._zhuoyueBtn = new BaseButton(getDisplayChildByName("zhuoyueBtn"), true);
            this._zhuoyueBtn.setText(LanguageCfgObj.getInstance().getByIndex("10702"));
            this._strengthBtn = new BaseButton(getDisplayChildByName("strengthBtn"), true);
            this._strengthBtn.setText(LanguageCfgObj.getInstance().getByIndex("10703"));
            this._lostskillBtn = new BaseButton(getDisplayChildByName("lostskillBtn"), true);
            this._lostskillBtn.setText(LanguageCfgObj.getInstance().getByIndex("10704"));
            this._view1 = getDisplayChildByName("view1");
            this._view2 = getDisplayChildByName("view2");
            this._view3 = getDisplayChildByName("view3");
            this._view4 = getDisplayChildByName("view4");
            this._view5 = getDisplayChildByName("view5");
            this._view6 = getDisplayChildByName("view6");
            this._view1.parent.removeChild(this._view1);
            this._view2.parent.removeChild(this._view2);
            this._view3.parent.removeChild(this._view3);
            this._view4.parent.removeChild(this._view4);
            this._view5.parent.removeChild(this._view5);
            this._view6.parent.removeChild(this._view6);
            this._scrollpanel = new ScrollPanel(427, 249);
            this._scrollpanel.move(170, 32);
            addChildAt(this._scrollpanel, 1);
            this._tabPanel.add(this._strongfastBtn, null);
            this._tabPanel.add(this._strongtoolsBtn, null);
            this._tabPanel.add(this._weaponBtn, null);
            this._tabPanel.add(this._zhuoyueBtn, null);
            this._tabPanel.add(this._strengthBtn, null);
            this._tabPanel.add(this._lostskillBtn, null);
            return;
        }// end function

        private function __changeTab(event:Event) : void
        {
            var _loc_2:* = null;
            if (this._scrollpanel.content)
            {
                if (this._scrollpanel.content.parent)
                {
                    this._scrollpanel.content.parent.removeChild(this._scrollpanel.content);
                }
            }
            _loc_2 = this["_view" + ((event.target as TabManager).index + 1)];
            _loc_2.x = 5;
            _loc_2.y = 5;
            this._scrollpanel.content = _loc_2;
            this._scrollpanel.scrollTo(0);
            return;
        }// end function

        private function addListener() : void
        {
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

        private function onAddedToStage(event:Event) : void
        {
            this._tabPanel.addEvtListener(Event.CHANGE, this.__changeTab);
            this._tabPanel.selected = 0;
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            this._tabPanel.removeEvtListener(Event.CHANGE, this.__changeTab);
            return;
        }// end function

    }
}
