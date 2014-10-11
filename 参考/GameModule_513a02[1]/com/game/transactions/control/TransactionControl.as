package com.game.transactions.control
{
    import com.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.player.control.*;
    import com.game.protect.control.*;
    import com.game.transactions.bean.*;
    import com.game.transactions.model.*;
    import com.game.transactions.protocol.*;
    import com.game.transactions.view.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;

    public class TransactionControl extends Object
    {
        private var _protocol:TransactionProtocol;
        private var _goodNum:int;
        private var _panel:TransactionPanel;
        private var _timeId:String;
        private var _info:RoleModeInfo;
        private var _transactionId:long;
        private var _icon:TransactionIcon;
        private var _transactionConfirm:TransactionConfirmPanel;
        private static var _instance:TransactionControl;
        public static const CAPACITY:int = 6;

        public function TransactionControl()
        {
            this._protocol = new TransactionProtocol();
            return;
        }// end function

        public function get goodNum() : int
        {
            return this._goodNum;
        }// end function

        public function set goodNum(param1:int) : void
        {
            this._goodNum = param1;
            if (this.goodNum >= CAPACITY)
            {
                this.closeTransactionSelect();
            }
            return;
        }// end function

        public function get info() : RoleModeInfo
        {
            return this._info;
        }// end function

        public function set info(param1:RoleModeInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function openTransaction(param1:long, param2:String, param3:int) : void
        {
            if (this._panel == null)
            {
                this._panel = new TransactionPanel();
                Global.popManager.addPop(this._panel, true, true);
            }
            this._panel.otherId = param1;
            this._panel.otherName = param2;
            this._panel.otherLevel = param3;
            this._panel.open();
            this.openSelect();
            return;
        }// end function

        public function openSelect() : void
        {
            FrameworkGlobal.stage.addEventListener("rightClick", this.__rightClick, false, 0, true);
            BackPackControl.getInstance().changeToTransaction();
            FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.__cancelSelect, false, 0, true);
            return;
        }// end function

        public function launchTransactionRes(param1:int, param2:RoleModeInfo, param3:long) : void
        {
            this._info = param2;
            this._timeId = TimerManager.registerTimer(180, 1, this.cancelTransactions);
            if (this._icon == null)
            {
                this._icon = new TransactionIcon();
            }
            this._icon.tipsStr = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12289"), [this._info.playername, this._info.playerlv]);
            Global.popManager.addedServerToCue(this._icon);
            this._transactionId = param3;
            return;
        }// end function

        private function __cancelSelect(event:MouseEvent) : void
        {
            this.closeTransactionSelect();
            return;
        }// end function

        private function __rightClick(event:MouseEvent) : void
        {
            this.closeTransactionSelect();
            return;
        }// end function

        public function closeTransactionSelect() : void
        {
            FrameworkGlobal.stage.removeEventListener("rightClick", this.__rightClick);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__cancelSelect);
            BackPackControl.getInstance().closeSelectStatus();
            Global.primaryCursorManager.hide();
            if (this._panel)
            {
                this._panel.cancelSelect();
            }
            return;
        }// end function

        public function releaseBackpackLock() : void
        {
            BackPackControl.getInstance().closeSell(BackPackControl.TRANSCATION);
            return;
        }// end function

        public function cancelTransaction() : void
        {
            this._protocol.cancelTransactions();
            return;
        }// end function

        public function launchTransactions(param1:long) : void
        {
            if (!UserObj.getInstance().playerInfo.alive())
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11376"));
            }
            else if (UserObj.getInstance().playerInfo.pkValue > 0)
            {
                PlayerControl.getInstance().openBannerTips();
            }
            else
            {
                if (ProtectControl.getInstance().promptIfLocked())
                {
                    return;
                }
                this._protocol.launchTransactions(param1);
            }
            return;
        }// end function

        public function acceptTransactions() : void
        {
            if (UserObj.getInstance().playerInfo.alive())
            {
                this._protocol.acceptTransactions(this._transactionId);
                TimerManager.killTimer(this._timeId);
                if (this._icon)
                {
                    Global.popManager.removeServerToCue(this._icon);
                }
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11376"));
            }
            return;
        }// end function

        public function removeItemRes(param1:long, param2:long) : void
        {
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.removeItem(param1, param2);
            }
            else
            {
                TransactionModel.instance.removeItemRes(param1, param2);
            }
            return;
        }// end function

        public function completeTransaction() : void
        {
            TransactionModel.instance.clear();
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.completeTransaction();
            }
            return;
        }// end function

        public function refuseTransactions() : void
        {
            this._protocol.refuseTransactions(this._transactionId);
            TimerManager.killTimer(this._timeId);
            if (this._icon)
            {
                Global.popManager.removeServerToCue(this._icon);
            }
            return;
        }// end function

        public function cancelTransactions(event:TimerManagerEvent = null) : void
        {
            this._protocol.cancelTransactions();
            TimerManager.killTimer(this._timeId);
            if (this._icon)
            {
                Global.popManager.removeServerToCue(this._icon);
            }
            return;
        }// end function

        public function insertItem(param1:int, param2:long) : void
        {
            this._protocol.insertItem(param1, param2);
            return;
        }// end function

        public function removeItem(param1:long) : void
        {
            this._protocol.removeItem(param1);
            return;
        }// end function

        public function changeMoney(param1:int) : void
        {
            this._protocol.changeMoney(param1);
            return;
        }// end function

        public function changeMoneyRes(param1:long, param2:int) : void
        {
            TransactionModel.instance.changeMoney(param1, param2);
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.changeMoneyRes(param1, param2);
            }
            return;
        }// end function

        public function goldChange(param1:int) : void
        {
            this._protocol.goldChange(param1);
            return;
        }// end function

        public function diamondChange(param1:int) : void
        {
            this._protocol.diamondChange(param1);
            return;
        }// end function

        public function setStateRes(param1:long, param2:int) : void
        {
            TransactionModel.instance.setState(param1, param2);
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.setState(param1, param2);
            }
            return;
        }// end function

        public function openConfirm() : void
        {
            if (this._transactionConfirm == null)
            {
                this._transactionConfirm = new TransactionConfirmPanel();
                Global.popManager.addPop(this._transactionConfirm, true, false, true, true, false, true);
            }
            this._transactionConfirm.show(this._info);
            return;
        }// end function

        public function cancelTransactionsRes() : void
        {
            this.closeTransaction();
            TransactionModel.instance.clear();
            if (this._panel && this._panel.isOpen)
            {
                this._panel.close();
            }
            return;
        }// end function

        public function closeTransaction() : void
        {
            BackPackControl.getInstance().releaseLock();
            this.closeTransactionSelect();
            return;
        }// end function

        public function insertItemRes(param1:int, param2:PropInfo, param3:long) : void
        {
            TransactionModel.instance.insertItemRes(param1, param2, param3);
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.insertItemRes(param1, param2, param3);
            }
            return;
        }// end function

        public function setState(param1:int) : void
        {
            this._protocol.setState(param1);
            return;
        }// end function

        public function moveToTranscation(param1:PropInfo) : void
        {
            if (this._panel && this._panel.initCompleted)
            {
                this._panel.moveInItem(param1);
            }
            return;
        }// end function

        public function cancelSelectFromBackpack() : void
        {
            return;
        }// end function

        public static function getInstance() : TransactionControl
        {
            var _loc_1:* = new TransactionControl;
            _instance = new TransactionControl;
            return _instance || _loc_1;
        }// end function

    }
}
