package com.game.primaryrole.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.list.*;
    import com.game.guide.*;
    import com.model.*;
    import flash.events.*;

    public class TitleViewPanel extends BaseBox implements IGuide
    {
        private var _closeBtn:BaseButton;
        private var _tabBtn0:BaseButton;
        private var _tabBtn1:BaseButton;
        private var _tabBtn2:BaseButton;
        private var _tabBtns:Buttons;
        private var _showGotCheck:BaseButton;
        private var _list:List;
        private var _tiledId:int;

        public function TitleViewPanel()
        {
            loadDisplay("res/titlePanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("titleUIPanel");
            super.displayReady();
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.onCloseHandler);
            this._tabBtn0 = new BaseButton(getDisplayChildByName("tabBtn0"), true);
            this._tabBtn0.visible = false;
            this._tabBtn0.setText(LanguageCfgObj.getInstance().getByIndex("11067"), true);
            this._tabBtn1 = new BaseButton(getDisplayChildByName("tabBtn1"), true);
            this._tabBtn1.setText(LanguageCfgObj.getInstance().getByIndex("11068"), true);
            this._tabBtn1.visible = false;
            this._tabBtn2 = new BaseButton(getDisplayChildByName("tabBtn2"), true);
            this._tabBtn2.setText(LanguageCfgObj.getInstance().getByIndex("11069"), true);
            this._tabBtns = new Buttons();
            this._tabBtns.move(this._tabBtn0.x, this._tabBtn0.y);
            this._tabBtns.horizontal = true;
            this._tabBtns.intervalX = 1;
            this._tabBtns.intervalY = 0;
            this._tabBtns.add(this._tabBtn2);
            this._tabBtns.addEvtListener(Event.CHANGE, this.onTabBtnChangeHandler);
            addChild(this._tabBtns);
            this._showGotCheck = new BaseButton(getDisplayChildByName("showGotCheck"), true);
            this._showGotCheck.addEvtListener(MouseEvent.CLICK, this.onShowGotOnlyHandler);
            this._list = new List(320, 456);
            this._list.cellRenderer = TitleViewItem;
            this._list.move(17, 85);
            addChild(this._list);
            this.onTabBtnChangeHandler();
            return;
        }// end function

        private function addListener() : void
        {
            addEventListener(UIEvent.BOX_LAYOUT_COMPLETE, this.showComplete);
            return;
        }// end function

        private function showComplete(event:UIEvent) : void
        {
            this.registerGuide();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this._tabBtns.selectIndex = this._tabBtns.selectIndex;
                MyTitleData.instance.addEvtListener(Event.CHANGE, this.onTabBtnChangeHandler);
            }
            return;
        }// end function

        public function titledId(param1:int) : void
        {
            this._tiledId = param1;
            var _loc_2:* = MyTitleData.getTabIndex(param1);
            if (this._tabBtns && this._tabBtns.selectIndex != _loc_2)
            {
                this._tabBtns.selectIndex = _loc_2;
            }
            return;
        }// end function

        private function onCloseHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._list.reset();
            MyTitleData.instance.removeEvtListener(Event.CHANGE, this.onTabBtnChangeHandler);
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        private function onTabBtnChangeHandler(event:Event = null) : void
        {
            var _loc_2:* = null;
            switch(this._tabBtns.selectBtn)
            {
                case this._tabBtn0:
                {
                    this._list.objs = MyTitleData.instance.getTitleVect1(this._showGotCheck.selected);
                    break;
                }
                case this._tabBtn1:
                {
                    this._list.objs = MyTitleData.instance.getTitleVect2(this._showGotCheck.selected);
                    break;
                }
                case this._tabBtn2:
                {
                    this._list.objs = MyTitleData.instance.getTitleVect3(this._showGotCheck.selected);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._tiledId)
            {
                _loc_2 = this._list.getItemByKey(this._tiledId) as TitleViewItem;
                this._list.scrollToItem(_loc_2);
                this._tiledId = 0;
            }
            return;
        }// end function

        private function onShowGotOnlyHandler(event:MouseEvent) : void
        {
            var _loc_2:* = this._showGotCheck.selected;
            this.onTabBtnChangeHandler();
            return;
        }// end function

        public function registerGuide() : void
        {
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded && isOpen;
        }// end function

    }
}
