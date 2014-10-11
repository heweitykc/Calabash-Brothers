package com.game.stalls.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.stalls.control.*;
    import flash.display.*;
    import flash.events.*;

    public class StallsBox extends BaseBox
    {
        private var _tab:Buttons;
        private var _initComplete:Boolean;
        private var _searchTab:BaseButton;
        private var _mineTab:BaseButton;
        private var _logTab:BaseButton;
        private var _closeBtn:BaseButton;
        private var _list:StallsList;
        private var _mineBooth:MineBoothContainer;
        private var _log:LogContainer;
        private var _curContainer:Component;
        private var _bg:Sprite;

        public function StallsBox()
        {
            _combinedBox = ["com.game.backpack.view::BackPackPanel", "com.game.primaryrole.view::OtherRoleMainPanel"];
            loadDisplay("res/stalls.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("stallsbox");
            this.initUI();
            this.addListener();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._tab = new Buttons();
            this._tab.horizontal = true;
            this._searchTab = new BaseButton(getDisplayChildByName("tab_list"), true);
            this._mineTab = new BaseButton(getDisplayChildByName("tab_mine"), true);
            this._logTab = new BaseButton(getDisplayChildByName("tab_log"), true);
            this._searchTab.setText(LanguageCfgObj.getInstance().getByIndex("11242"));
            this._mineTab.setText(LanguageCfgObj.getInstance().getByIndex("11243"));
            this._logTab.setText(LanguageCfgObj.getInstance().getByIndex("11244"));
            this._tab.intervalX = 1;
            this._tab.add(this._searchTab);
            this._tab.add(this._mineTab);
            this._tab.add(this._logTab);
            addChild(this._tab);
            this._tab.y = 50;
            this._tab.x = 20;
            this._mineBooth = new MineBoothContainer(getDisplayChildByName("mineContainer"));
            this._mineBooth.visible = false;
            addChild(this._mineBooth);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._list = new StallsList();
            this._list.move(15, 87);
            this._list.visible = false;
            addChild(this._list);
            StallsControl.getInstance().list = this._list;
            this._log = new LogContainer();
            this._log.visible = false;
            this._log.move(14, 82);
            StallsControl.getInstance().log = this._log;
            addChild(this._log);
            this._bg = getDisplayChildByName("bg");
            this._curContainer = this._list;
            this._curContainer.visible = true;
            this._initComplete = true;
            if (StallsControl.getInstance().status != StallsControl.BOOTH)
            {
                this._list.openSearch();
            }
            else
            {
                this._list.openBooth();
            }
            this.openTab(StallsControl.getInstance().status);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function addListener() : void
        {
            this._tab.addEvtListener(Event.CHANGE, this.__tabChange);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            var _loc_2:* = null;
            switch(event.target.selectBtn)
            {
                case this._searchTab:
                {
                    _loc_2 = this._list;
                    this._bg.height = 400;
                    break;
                }
                case this._mineTab:
                {
                    StallsControl.getInstance().status = StallsControl.MINE;
                    _loc_2 = this._mineBooth;
                    this._bg.height = 400;
                    break;
                }
                case this._logTab:
                {
                    _loc_2 = this._log;
                    StallsControl.getInstance().status = StallsControl.LOG;
                    StallsControl.getInstance().reqLog();
                    this._bg.height = 452;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_2 != this._curContainer)
            {
                if (this._curContainer)
                {
                    this._curContainer.visible = false;
                }
                this._curContainer = _loc_2;
                if (this._curContainer != this._mineBooth)
                {
                    StallsControl.getInstance().closeAdd();
                    this._mineBooth.reset();
                }
                this._curContainer.visible = true;
            }
            return;
        }// end function

        public function openTab(param1:String) : void
        {
            var _loc_2:* = null;
            if (this._initComplete)
            {
                if (param1 == StallsControl.MINE)
                {
                    _loc_2 = this._mineBooth;
                    this._tab.doBtnClick(this._mineTab);
                }
                else if (param1 == StallsControl.LIST || param1 == StallsControl.BOOTH)
                {
                    _loc_2 = this._list;
                    this._tab.doBtnClick(this._searchTab);
                }
                else if (param1 == StallsControl.LOG)
                {
                    _loc_2 = this._log;
                    this._tab.doBtnClick(this._logTab);
                }
                if (_loc_2 != this._curContainer)
                {
                    if (this._curContainer)
                    {
                        this._curContainer.visible = false;
                    }
                }
                this._curContainer = _loc_2;
                if (this._curContainer != this._mineBooth)
                {
                    StallsControl.getInstance().closeAdd();
                }
                this._curContainer.visible = true;
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this._mineBooth.reset();
            StallsControl.getInstance().closeStalls();
            return;
        }// end function

    }
}
