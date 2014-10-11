package com.game.mail.view
{
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.mail.control.*;
    import flash.events.*;

    public class MailPanel extends BaseBox
    {
        private var _listContainer:MailListView;
        private var _infoContainer:MailInfoView;
        private var _tabs:Buttons;
        private var _totalTab:BaseButton;
        private var _readedTab:BaseButton;
        private var _unreadTab:BaseButton;
        private var _closeBtn:BaseButton;
        private var _btn:BaseButton;

        public function MailPanel()
        {
            loadDisplay("res/mail.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("mailbox");
            this.initUI();
            this.addlistener();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._tabs = new Buttons();
            this._tabs.horizontal = true;
            this._btn = new BaseButton(getDisplayChildByName("btn_check"), true);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._totalTab = new BaseButton("generalTabSmall", true);
            this._readedTab = new BaseButton("generalTabSmall", true);
            this._unreadTab = new BaseButton("generalTabSmall", true);
            this._tabs.intervalX = 1;
            this._totalTab.setText(LanguageCfgObj.getInstance().getByIndex("10911"));
            this._readedTab.setText(LanguageCfgObj.getInstance().getByIndex("10912"));
            this._unreadTab.setText(LanguageCfgObj.getInstance().getByIndex("10913"));
            this._tabs.add(this._totalTab);
            this._tabs.add(this._readedTab);
            this._tabs.add(this._unreadTab);
            this._tabs.move(23, 53);
            addChild(this._tabs);
            this._listContainer = new MailListView(getDisplayChildByName("listcontainer"));
            this._infoContainer = new MailInfoView(getDisplayChildByName("infocontainer"));
            MailController.getInstance().info = this._infoContainer;
            MailController.getInstance().list = this._listContainer;
            if (MailController.getInstance().preShow != null)
            {
                MailController.getInstance().preShow();
            }
            if (MailController.getInstance().kind_type == 1)
            {
                MailController.getInstance().type = 2;
            }
            this._tabs.doBtnClick(this._totalTab);
            return;
        }// end function

        private function addlistener() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__closeClick);
            this._tabs.addEvtListener(Event.CHANGE, this.__tabChange);
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            var _loc_2:* = this._tabs.selectBtn as BaseButton;
            switch(_loc_2)
            {
                case this._totalTab:
                {
                    MailController.getInstance().type = 2;
                    break;
                }
                case this._readedTab:
                {
                    MailController.getInstance().type = 1;
                    break;
                }
                case this._unreadTab:
                {
                    MailController.getInstance().type = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function open() : void
        {
            if (UILoaded)
            {
                if (MailController.getInstance().kind_type == 1)
                {
                    MailController.getInstance().type = 2;
                }
                this._tabs.doBtnClick(this._totalTab);
            }
            MailController.getInstance().curTotalPage = 1;
            MailController.getInstance().curUnreadPage = 1;
            MailController.getInstance().curReadedPage = 1;
            super.open();
            return;
        }// end function

        public function doTotalClick() : void
        {
            if (this._tabs && this._totalTab)
            {
                this._tabs.doBtnClick(this._totalTab);
            }
            return;
        }// end function

        public function setPageCount(param1:int) : void
        {
            if (this._listContainer)
            {
                this._listContainer.setPageCount(param1);
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        private function __closeClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

    }
}
