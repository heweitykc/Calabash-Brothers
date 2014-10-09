package com.game.transactions.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.protect.control.*;
    import com.game.transactions.bean.*;
    import com.game.transactions.control.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TransactionConfirmPanel extends BaseBox
    {
        private var _head:MovieClip;
        private var _tipsTxt:TextField;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _info:RoleModeInfo;

        public function TransactionConfirmPanel()
        {
            super.loadDisplay("res/transactionconfirm.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("transactionconfirm");
            this.initUI();
            this.addlistener();
            if (this._info)
            {
                this._head.gotoAndStop((this._info.job - 1) % 3 + 1);
                this._tipsTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12289"), [this._info.playername, this._info.playerlv]) + "<br>" + LanguageCfgObj.getInstance().getByIndex("12290");
            }
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._head = getDisplayChildByName("headBack") as MovieClip;
            this._tipsTxt = getDisplayChildByName("txt_tips");
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11378"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("11379"));
            return;
        }// end function

        private function addlistener() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            return;
        }// end function

        public function show(param1:RoleModeInfo) : void
        {
            this._info = param1;
            open();
            if (UILoaded)
            {
                this._head.gotoAndStop((param1.job - 1) % 3 + 1);
                this._tipsTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12289"), [this._info.playername, this._info.playerlv]) + "<br>" + LanguageCfgObj.getInstance().getByIndex("12290");
            }
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            TransactionControl.getInstance().refuseTransactions();
            close();
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return;
            }
            TransactionControl.getInstance().acceptTransactions();
            close();
            return;
        }// end function

    }
}
