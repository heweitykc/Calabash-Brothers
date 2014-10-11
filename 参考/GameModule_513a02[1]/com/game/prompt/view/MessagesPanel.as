package com.game.prompt.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.prompt.model.*;
    import com.model.vo.*;
    import flash.events.*;

    public class MessagesPanel extends BaseBox
    {
        private var _list:List;
        private var _type:int;
        private var _openTab:int;
        private var _cancelBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _normalTab:BaseButton;
        private var _importantTab:BaseButton;
        private var _zhuzaoTab:BaseButton;
        private var _transactionTab:BaseButton;
        private var _tab:Buttons;

        public function MessagesPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            _peaceBox = ["*"];
            super.loadDisplay("res/messagespanel.swf");
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("messagespanel");
            this.initUI();
            this.addlisteners();
            this.show();
            if (this._type != MessagesModel.NORMAL)
            {
                this.tabClick();
            }
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._tab = new Buttons();
            this._tab.intervalX = -1;
            this._tab.horizontal = true;
            this._tab.x = getDisplayChildByName("type_1").x;
            this._tab.y = getDisplayChildByName("type_1").y;
            addChild(this._tab);
            this._normalTab = new BaseButton(getDisplayChildByName("type_1"), true);
            this._normalTab.setText(LanguageCfgObj.getInstance().getByIndex("11089"));
            this._tab.add(this._normalTab);
            this._importantTab = new BaseButton(getDisplayChildByName("type_2"), true);
            this._importantTab.setText(LanguageCfgObj.getInstance().getByIndex("11090"));
            this._tab.add(this._importantTab);
            this._zhuzaoTab = new BaseButton(getDisplayChildByName("type_3"), true);
            this._zhuzaoTab.setText(LanguageCfgObj.getInstance().getByIndex("11091"));
            this._tab.add(this._zhuzaoTab);
            this._transactionTab = new BaseButton(getDisplayChildByName("type_4"), true);
            this._transactionTab.setText(LanguageCfgObj.getInstance().getByIndex("11092"));
            this._tab.add(this._transactionTab);
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11093"), true);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._list = new List(385, 280);
            this._list.cellRenderer = MessagesPanelItem;
            this._list.move(18, 76);
            addChild(this._list);
            return;
        }// end function

        private function tabClick() : void
        {
            switch(this._type)
            {
                case MessagesModel.IMOPROTANT:
                {
                    this._tab.doBtnClick(this._importantTab);
                    break;
                }
                case MessagesModel.TRANSACTION:
                {
                    this._tab.doBtnClick(this._transactionTab);
                    break;
                }
                case MessagesModel.ZHUZAO:
                {
                    this._tab.doBtnClick(this._zhuzaoTab);
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
            super.open();
            if (UILoaded)
            {
                this.show();
                if (this._type != MessagesModel.NORMAL)
                {
                    this.tabClick();
                }
            }
            return;
        }// end function

        private function show() : void
        {
            var _loc_1:* = MessagesModel.getInstance().getMessageArr(this._type);
            this._list.objs = _loc_1.dataLst;
            return;
        }// end function

        private function addlisteners() : void
        {
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._tab.addEvtListener(Event.CHANGE, this.onTabChange);
            return;
        }// end function

        private function onTabChange(event:Event) : void
        {
            switch(event.target.selectBtn)
            {
                case this._normalTab:
                {
                    this._type = MessagesModel.NORMAL;
                    break;
                }
                case this._importantTab:
                {
                    this._type = MessagesModel.IMOPROTANT;
                    break;
                }
                case this._zhuzaoTab:
                {
                    this._type = MessagesModel.ZHUZAO;
                    break;
                }
                case this._transactionTab:
                {
                    this._type = MessagesModel.TRANSACTION;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.show();
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            this._type = MessagesModel.NORMAL;
            this._tab.doBtnClick(this._normalTab);
            return;
        }// end function

    }
}
