package com.game.transactions.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.role.util.*;
    import com.game.transactions.control.*;
    import com.game.transactions.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class TransactionPanel extends BaseBox
    {
        private var _initCompleted:Boolean;
        private var _selfContainer:HBox;
        private var _otherContainer:HBox;
        private var _selfItemArr:Array;
        private var _otherItemArr:Array;
        private var _selfNameTxt:TextField;
        private var _otherNameTxt:TextField;
        private var _selfLevelTxt:TextField;
        private var _otherLevelTxt:TextField;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _lockBtn:BaseButton;
        private var _coin:int;
        private var _selfCoinTxt:TextField;
        private var _showCoinTxt:TextField;
        private var _otherCoinTxt:TextField;
        private var _otherId:long;
        private var _otherName:String;
        private var _otherLevel:int;
        private var _selfLock:LockSP;
        private var _otherLock:LockSP;
        private var _lockEnable:Boolean = false;
        private var _transactionComplete:Boolean;
        private var _getInBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _timeId:int;
        private var _goldEnough:Boolean = false;
        private var _other:PlayerInfo;
        private var _selfLocked:int;
        private var _otherLocked:int;
        private var _completeArr:Array;
        private var _selectStatus:Boolean;
        private static const LENGTH:int = 6;
        private static const LOCKED:int = 1;
        private static const CONFIRMED:int = 2;
        private static const NORMAL:int = 0;

        public function TransactionPanel()
        {
            _combinedBox = ["com.game.backpack.view::BackPackPanel"];
            loadDisplay("res/transaction.swf");
            return;
        }// end function

        public function get initCompleted() : Boolean
        {
            return this._initCompleted;
        }// end function

        public function get coin() : int
        {
            return this._coin;
        }// end function

        public function set coin(param1:int) : void
        {
            this._coin = param1;
            if (this._coin <= UserObj.getInstance().playerInfo.money)
            {
                TransactionControl.getInstance().changeMoney(this._coin);
                this._goldEnough = false;
            }
            else
            {
                this._timeId = setTimeout(this.releaseGoldEnough, 1000);
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11381"));
                this._coin = 0;
                this._goldEnough = true;
            }
            if (this._coin == 0)
            {
                this._selfCoinTxt.text = "";
            }
            this._showCoinTxt.text = ToolKit.getMoneyString(this._coin);
            this.checkLockEnable();
            return;
        }// end function

        public function get lockEnable() : Boolean
        {
            return this._lockEnable;
        }// end function

        public function set lockEnable(param1:Boolean) : void
        {
            this._lockEnable = param1;
            if (param1)
            {
                this._lockBtn.enabled = true;
            }
            else
            {
                this._lockBtn.enabled = false;
            }
            return;
        }// end function

        public function get selectStatus() : Boolean
        {
            return this._selectStatus;
        }// end function

        public function set selectStatus(param1:Boolean) : void
        {
            this._selectStatus = param1;
            if (param1)
            {
                addEvtListener(MouseEvent.CLICK, this.__tipsClick);
            }
            else
            {
                removeEvtListener(MouseEvent.CLICK, this.__tipsClick);
            }
            return;
        }// end function

        private function __tipsClick(event:MouseEvent) : void
        {
            if (this._goldEnough)
            {
                event.stopImmediatePropagation();
                return;
            }
            if (!(event.target is TextField))
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11382"));
            }
            event.stopImmediatePropagation();
            return;
        }// end function

        public function get otherLevel() : int
        {
            return this._otherLevel;
        }// end function

        public function set otherLevel(param1:int) : void
        {
            this._otherLevel = param1;
            return;
        }// end function

        public function get otherName() : String
        {
            return this._otherName;
        }// end function

        public function set otherName(param1:String) : void
        {
            this._otherName = param1;
            return;
        }// end function

        public function get otherId() : long
        {
            return this._otherId;
        }// end function

        public function set otherId(param1:long) : void
        {
            this._otherId = param1;
            return;
        }// end function

        public function get other() : PlayerInfo
        {
            return this._other;
        }// end function

        public function set other(param1:PlayerInfo) : void
        {
            this._other = param1;
            return;
        }// end function

        public function insertItemRes(param1:int, param2:PropInfo, param3:long) : void
        {
            if (param3.equal(UserObj.getInstance().playerInfo.personId))
            {
                (this._selfContainer.getContent((param1 - 1)) as TransactionItem).info = param2;
                param2.isUsing = true;
                BackPackControl.getInstance().setLock(param2.itemId, true);
            }
            else
            {
                (this._otherContainer.getContent((param1 - 1)) as TransactionItem).info = param2;
            }
            this.countNum();
            this.lockEnable = true;
            return;
        }// end function

        private function countNum(param1:HBox = null) : int
        {
            var _loc_2:* = 0;
            if (param1 == null)
            {
                param1 = this._selfContainer;
            }
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                if ((param1.getContent(_loc_3) as TransactionItem).info != null)
                {
                    _loc_2++;
                }
                _loc_3++;
            }
            if (param1 == this._selfContainer)
            {
                TransactionControl.getInstance().goodNum = _loc_2;
            }
            return _loc_2;
        }// end function

        override protected function displayReady() : void
        {
            super.initComponentUI("transactionview");
            this.initUI();
            this.addListeners();
            this.update();
            this._completeArr = [];
            this._initCompleted = true;
            super.displayReady();
            return;
        }// end function

        public function completeTransaction() : void
        {
            this.close();
            this._transactionComplete = true;
            TransactionControl.getInstance().closeTransaction();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._selfContainer = new HBox();
            this._selfContainer.oneRow = 1;
            this._selfContainer.intervalY = 2;
            this._selfContainer.move(getDisplayChildByName("self_0").x, getDisplayChildByName("self_0").y);
            addChild(this._selfContainer);
            this._otherContainer = new HBox();
            this._otherContainer.oneRow = 1;
            this._otherContainer.intervalY = 2;
            this._otherContainer.move(getDisplayChildByName("other_0").x, getDisplayChildByName("other_0").y);
            addChild(this._otherContainer);
            var _loc_1:* = 0;
            while (_loc_1 < LENGTH)
            {
                
                _loc_3 = new TransactionItem(getDisplayChildByName("other_" + _loc_1));
                _loc_3.isMine = true;
                _loc_3.pos = _loc_1 + 1;
                this._selfContainer.add(_loc_3);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < LENGTH)
            {
                
                _loc_3 = new TransactionItem(getDisplayChildByName("self_" + _loc_1));
                _loc_3.isMine = false;
                _loc_3.pos = _loc_1 + 1;
                this._otherContainer.add(_loc_3);
                _loc_1++;
            }
            this._selfNameTxt = getDisplayChildByName("txt_selfName");
            this._otherNameTxt = getDisplayChildByName("txt_otherName");
            this._selfLevelTxt = getDisplayChildByName("txt_selfLevel");
            this._otherLevelTxt = getDisplayChildByName("txt_otherLevel");
            this._selfCoinTxt = getDisplayChildByName("txt_selfCoin");
            this._selfCoinTxt.mouseEnabled = false;
            this._selfCoinTxt.maxChars = 9;
            this._selfCoinTxt.restrict = "0-9";
            this._showCoinTxt = new TextField();
            this._showCoinTxt.textColor = 16766079;
            this._showCoinTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._showCoinTxt.width = 120;
            this._showCoinTxt.height = 20;
            var _loc_2:* = this._showCoinTxt.defaultTextFormat;
            _loc_2.font = "SimSun";
            this._showCoinTxt.defaultTextFormat = _loc_2;
            this._showCoinTxt.x = this._selfCoinTxt.x;
            this._showCoinTxt.y = this._selfCoinTxt.y;
            addChild(this._showCoinTxt);
            this._otherCoinTxt = getDisplayChildByName("txt_otherCoin");
            this._getInBtn = new BaseButton(getDisplayChildByName("btn_getIn"));
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._lockBtn = new BaseButton(getDisplayChildByName("btn_lock"));
            this._confirmBtn.setText(LanguageCfgObj.getInstance().getByIndex("11383"));
            this._lockBtn.setText(LanguageCfgObj.getInstance().getByIndex("11384"));
            this._confirmBtn.enabled = false;
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.selectStatus = true;
            this._getInBtn.setText(LanguageCfgObj.getInstance().getByIndex("11385"));
            this.lockEnable = false;
            return;
        }// end function

        private function addListeners() : void
        {
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._lockBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._getInBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._selfCoinTxt.addEventListener(FocusEvent.FOCUS_OUT, this.__coinChange, false, 0, true);
            this._showCoinTxt.addEventListener(MouseEvent.CLICK, this.__focusIn, false, 0, true);
            this._selfCoinTxt.addEventListener(Event.CHANGE, this.__txtChange, false, 0, true);
            this._getInBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._selfContainer.addEvtListener(MouseEvent.CLICK, this.__itemClick);
            return;
        }// end function

        private function __focusIn(event:MouseEvent) : void
        {
            this._showCoinTxt.visible = false;
            this._selfCoinTxt.visible = true;
            FrameworkGlobal.stage.focus = this._selfCoinTxt;
            event.stopImmediatePropagation();
            return;
        }// end function

        private function __txtChange(event:Event) : void
        {
            this.checkLockEnable();
            return;
        }// end function

        private function __itemClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.target.parent as TransactionItem;
            if (_loc_2 && _loc_2.info)
            {
                TransactionControl.getInstance().removeItem(_loc_2.info.itemId);
            }
            event.stopImmediatePropagation();
            return;
        }// end function

        public function removeItem(param1:long, param2:long) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                this.removeContainerItem(this._selfContainer, param2);
                BackPackControl.getInstance().setLock(param2, false);
            }
            else
            {
                this.removeContainerItem(this._otherContainer, param2);
            }
            return;
        }// end function

        private function removeContainerItem(param1:HBox, param2:long) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = (param1.getContent(_loc_3) as TransactionItem).info;
                if (_loc_4)
                {
                    if (_loc_4.itemId.equal(param2))
                    {
                        _loc_4.isUsing = false;
                        (param1.getContent(_loc_3) as TransactionItem).info = null;
                        _loc_4 = null;
                        break;
                    }
                }
                _loc_3++;
            }
            this.checkLockEnable();
            return;
        }// end function

        private function __coinChange(event:FocusEvent) : void
        {
            this._selfCoinTxt.visible = false;
            this._showCoinTxt.visible = true;
            this.coin = int(this._selfCoinTxt.text);
            return;
        }// end function

        private function releaseGoldEnough() : void
        {
            clearTimeout(this._timeId);
            this._goldEnough = false;
            return;
        }// end function

        public function changeMoneyRes(param1:long, param2:int) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._showCoinTxt.htmlText = ToolKit.getMoneyString(param2);
            }
            else
            {
                this._otherCoinTxt.htmlText = ToolKit.getMoneyString(param2);
            }
            if (param2 != 0)
            {
                this.lockEnable = true;
            }
            else
            {
                this.checkLockEnable();
            }
            return;
        }// end function

        private function addComma(param1:String) : String
        {
            var _loc_5:* = 0;
            var _loc_2:* = param1.length;
            var _loc_3:* = _loc_2 % 3;
            if (_loc_3 == 0)
            {
                _loc_3 = 3;
            }
            var _loc_4:* = param1.substr(0, _loc_3);
            if (_loc_2 > 3)
            {
                _loc_5 = _loc_3;
                while (_loc_5 < _loc_2)
                {
                    
                    _loc_4 = _loc_4 + ("," + param1.substr(_loc_3, 3));
                    _loc_5 = _loc_5 + 3;
                }
            }
            return _loc_4;
        }// end function

        private function checkLockEnable() : void
        {
            if (this.countNum(this._selfContainer) == 0 && this.countNum(this._otherContainer) == 0 && (this._selfCoinTxt.text == "" || int(this._selfCoinTxt.text) == 0 || int(this._selfCoinTxt.text) > UserObj.getInstance().playerInfo.money) && this._otherCoinTxt.text == "0")
            {
                this.lockEnable = false;
            }
            else
            {
                this.lockEnable = true;
            }
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._lockBtn:
                {
                    if (this._selfLocked == LOCKED)
                    {
                        TransactionControl.getInstance().setState(0);
                    }
                    else
                    {
                        if (this._goldEnough)
                        {
                            clearTimeout(this._timeId);
                            this._goldEnough = false;
                            event.stopImmediatePropagation();
                            return;
                        }
                        TransactionControl.getInstance().setState(1);
                    }
                    break;
                }
                case this._confirmBtn:
                {
                    if (this._lockEnable)
                    {
                        TransactionControl.getInstance().setState(2);
                    }
                    break;
                }
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                case this._getInBtn:
                {
                    if (this.selectStatus)
                    {
                        this.selectStatus = false;
                        TransactionControl.getInstance().closeTransactionSelect();
                        this._getInBtn.setText(LanguageCfgObj.getInstance().getByIndex("11386"));
                    }
                    else
                    {
                        this.selectStatus = true;
                        TransactionControl.getInstance().openSelect();
                        this._getInBtn.setText(LanguageCfgObj.getInstance().getByIndex("11385"));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            event.stopImmediatePropagation();
            return;
        }// end function

        private function update() : void
        {
            this._selfCoinTxt.visible = false;
            var _loc_1:* = TransactionModel.instance.selfMoney;
            this._showCoinTxt.text = _loc_1 == 0 ? ("0") : (_loc_1.toString());
            this._selfNameTxt.text = LanguageCfgObj.getInstance().getByIndex("11388");
            this._otherNameTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12291"), [this._otherName]);
            this._selfLevelTxt.text = RoleLevelUtil.getMasterLevel(UserObj.getInstance().playerInfo.level, "Lv.");
            this._otherLevelTxt.text = RoleLevelUtil.getMasterLevel(this._otherLevel, "Lv.");
            _loc_1 = TransactionModel.instance.otherMoney;
            this._otherCoinTxt.text = _loc_1 == 0 ? ("0") : (_loc_1.toString());
            var _loc_2:* = 0;
            while (_loc_2 < LENGTH)
            {
                
                (this._selfContainer.getContent(_loc_2) as TransactionItem).info = TransactionModel.instance.selfItems[_loc_2];
                (this._otherContainer.getContent(_loc_2) as TransactionItem).info = TransactionModel.instance.otherItems[_loc_2];
                _loc_2++;
            }
            if (TransactionModel.instance.otherState == 1)
            {
                this.addLock(this._otherId);
            }
            return;
        }// end function

        private function addLock(param1:long) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                if (this._selfLock == null)
                {
                    this._selfLock = this.createSP();
                    this._selfLock.move(this._selfContainer.x - 2, this._selfContainer.y - 2);
                }
                this._selfLocked = LOCKED;
                this._lockBtn.setText(LanguageCfgObj.getInstance().getByIndex("11389"));
                addChild(this._selfLock);
                this.addboxLock(true);
                if (this._otherLocked == NORMAL)
                {
                    this._selfLock.tips = LanguageCfgObj.getInstance().getByIndex("11390");
                }
                else if (this._otherLocked == LOCKED)
                {
                    this._otherLock.tips = LanguageCfgObj.getInstance().getByIndex("11391");
                    this._selfLock.tips = LanguageCfgObj.getInstance().getByIndex("11391");
                }
                TransactionControl.getInstance().closeTransactionSelect();
            }
            else
            {
                if (this._otherLock == null)
                {
                    this._otherLock = this.createSP();
                    this._otherLock.move(this._otherContainer.x - 2, this._otherContainer.y - 2);
                }
                this._otherLocked = LOCKED;
                addChild(this._otherLock);
                if (this._selfLocked == NORMAL)
                {
                    this._otherLock.tips = LanguageCfgObj.getInstance().getByIndex("11393");
                }
                else if (this._selfLocked == LOCKED)
                {
                    this._selfLock.tips = LanguageCfgObj.getInstance().getByIndex("11391");
                    this._otherLock.tips = LanguageCfgObj.getInstance().getByIndex("11391");
                }
            }
            if (this._selfLocked == LOCKED && this._otherLocked == LOCKED)
            {
                this._confirmBtn.enabled = true;
            }
            return;
        }// end function

        public function createSP() : LockSP
        {
            var _loc_1:* = new LockSP();
            return _loc_1;
        }// end function

        public function setState(param1:long, param2:int) : void
        {
            if (param2 == 1)
            {
                this.addLock(param1);
            }
            else if (param2 == 0)
            {
                this.releaseLock(param1);
            }
            else if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._confirmBtn.enabled = false;
                this._selfLock.tips = LanguageCfgObj.getInstance().getByIndex("11396");
            }
            else
            {
                this._selfLock.tips = LanguageCfgObj.getInstance().getByIndex("11397");
            }
            return;
        }// end function

        private function addboxLock(param1:Boolean) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._selfContainer.length)
            {
                
                (this._selfContainer.getContent(_loc_2) as TransactionItem).setLocked(param1);
                _loc_2++;
            }
            return;
        }// end function

        private function releaseLock(param1:long) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                if (this._selfLock && this._selfLock.parent)
                {
                    this._selfLock.parent.removeChild(this._selfLock);
                }
                this._selfLocked = NORMAL;
                this._lockBtn.setText(LanguageCfgObj.getInstance().getByIndex("11384"));
                this.addboxLock(false);
            }
            else
            {
                if (this._otherLock && this._otherLock.parent)
                {
                    this._otherLock.parent.removeChild(this._otherLock);
                }
                this._otherLocked = NORMAL;
            }
            if (!this._selfLocked || !this._otherLocked)
            {
                this._confirmBtn.enabled = false;
            }
            return;
        }// end function

        private function clear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < LENGTH)
            {
                
                (this._selfContainer.getContent(_loc_1) as TransactionItem).info = null;
                (this._otherContainer.getContent(_loc_1) as TransactionItem).info = null;
                _loc_1++;
            }
            this._confirmBtn.enabled = false;
            if (this._selfLock && this._selfLock.parent)
            {
                this._selfLock.parent.removeChild(this._selfLock);
            }
            if (this._otherLock && this._otherLock.parent)
            {
                this._otherLock.parent.removeChild(this._otherLock);
            }
            this._lockBtn.setText(LanguageCfgObj.getInstance().getByIndex("11384"));
            this.selectStatus = true;
            this._getInBtn.setText(LanguageCfgObj.getInstance().getByIndex("11385"));
            this._selfLocked = NORMAL;
            this._otherLocked = NORMAL;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.lockEnable = false;
                this.clear();
                this.update();
                this._completeArr = [];
            }
            return;
        }// end function

        public function moveInItem(param1:PropInfo) : void
        {
            var _loc_2:* = this.getNearItem();
            if (_loc_2)
            {
                _loc_2.setItem(param1);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11401"));
                TransactionControl.getInstance().closeTransactionSelect();
            }
            return;
        }// end function

        public function cancelSelect() : void
        {
            if (this._getInBtn)
            {
                this._getInBtn.setText(LanguageCfgObj.getInstance().getByIndex("11386"));
            }
            this.selectStatus = false;
            return;
        }// end function

        public function getNearItem() : TransactionItem
        {
            var _loc_1:* = 0;
            while (_loc_1 < LENGTH)
            {
                
                if ((this._selfContainer.getContent(_loc_1) as TransactionItem).info == null)
                {
                    return this._selfContainer.getContent(_loc_1);
                }
                _loc_1++;
            }
            return null;
        }// end function

        override public function close() : void
        {
            super.close();
            TransactionControl.getInstance().cancelTransaction();
            return;
        }// end function

    }
}
