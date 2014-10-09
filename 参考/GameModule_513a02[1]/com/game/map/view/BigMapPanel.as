package com.game.map.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.map.model.*;
    import com.game.team.message.*;
    import flash.events.*;

    public class BigMapPanel extends BaseBox
    {
        private var _closeBtn:BaseButton;
        private var _currentBtn:BaseButton;
        private var _globalBtn:BaseButton;
        private var _buttons:Buttons;
        private var _currentView:BigMapCurrentView;
        private var _golobalView:BigMapWorldView;
        private var _currentTab:uint;
        private var isInit:Boolean;

        public function BigMapPanel()
        {
            loadDisplay("res/bigmap.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("big_map_panel", 45);
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._currentBtn = new BaseButton(getDisplayChildByName("btn_current"), true);
            this._currentBtn.setText(LanguageCfgObj.getInstance().getByIndex("10937"));
            this._globalBtn = new BaseButton(getDisplayChildByName("btn_global"), true);
            this._globalBtn.setText(LanguageCfgObj.getInstance().getByIndex("10938"));
            this._buttons = new Buttons();
            this._buttons.horizontal = true;
            this._buttons.intervalX = 0;
            this._buttons.intervalY = 0;
            this._buttons.x = this._currentBtn.x;
            this._buttons.y = this._currentBtn.y;
            this._buttons.add(this._currentBtn);
            this._buttons.add(this._globalBtn);
            addChild(this._buttons);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._currentView = new BigMapCurrentView(getDisplayChildByName("current"));
            this._golobalView = new BigMapWorldView(getDisplayChildByName("world"));
            this.addListener();
            this.reset();
            this.isInit = true;
            return;
        }// end function

        private function reset() : void
        {
            this.updateMapView(MapObj.getInstance().mapID);
            this.currentTab = 0;
            this._buttons.selectIndex = 0;
            if (this._currentView)
            {
                this._currentView.reset();
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (this.isInit)
            {
                this.reset();
            }
            return;
        }// end function

        private function _updateViewByPage() : void
        {
            if (this._currentTab == 0)
            {
                this._currentView.visible = true;
                this._golobalView.visible = false;
            }
            else
            {
                this._currentView.visible = false;
                this._golobalView.visible = true;
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._buttons.addEvtListener(Event.CHANGE, this._onTabChange);
            return;
        }// end function

        private function _onTabChange(event:Event) : void
        {
            switch(event.target.selectBtn)
            {
                case this._currentBtn:
                {
                    this.currentTab = 0;
                    break;
                }
                case this._globalBtn:
                {
                    this.currentTab = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        public function updateMapView(param1:uint) : void
        {
            if (isOpen)
            {
                if (this._currentView)
                {
                    this._currentView.updateMapView(param1);
                }
            }
            return;
        }// end function

        public function updateByLevel(param1:int) : void
        {
            if (isOpen)
            {
                if (this._currentView)
                {
                    this._currentView.updateMapRecList(param1);
                }
            }
            return;
        }// end function

        public function updateUserDir(param1:int) : void
        {
            if (this._currentView)
            {
                this._currentView.updateUserDir(param1);
            }
            return;
        }// end function

        public function updateUserByPos(param1:int, param2:int, param3:Boolean) : void
        {
            if (this._currentView)
            {
                this._currentView.updateUserByPos(param1, param2, param3);
            }
            return;
        }// end function

        public function userFindPath(param1:Array) : void
        {
            if (this._currentView)
            {
                this._currentView.userFindPath(param1);
            }
            return;
        }// end function

        public function get currentTab() : uint
        {
            return this._currentTab;
        }// end function

        public function set currentTab(param1:uint) : void
        {
            this._currentTab = param1;
            this._updateViewByPage();
            return;
        }// end function

        public function teamMemberUpdate(param1:ResTeamClientRefreshMessage) : void
        {
            if (this._currentView)
            {
                this._currentView.teamMemberUpdate(param1);
            }
            return;
        }// end function

        public function teamMemberPosUpdate(param1:ResTeammateMoveToClientMessage) : void
        {
            if (this._currentView)
            {
                this._currentView.teamMemberPosUpdate(param1);
            }
            return;
        }// end function

    }
}
