package com.game.protect.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.events.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.player.model.*;
    import com.game.protect.message.*;
    import com.game.protect.model.*;
    import com.game.protect.protocol.*;
    import com.game.protect.view.*;
    import com.game.protectAdvanced.message.*;
    import com.game.store.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;

    public class ProtectControl extends Object
    {
        private var protocol:ProtectProtocol;
        private var protectData:ProtectData;
        public var lockButton:ProtectLockButton;
        private var protectServerIcon:ProtectServerIcon;
        private var createPasswordIntroPanel:ProtectCreatePasswordIntroPanel;
        private var createPasswordPanel:ProtectCreatePasswordPanel;
        private var unlockPanel:ProtectUnlockPanel;
        private var lockPanel:ProtectLockPanel;
        private var modifyPasswordPanel:ProtectModifyPasswordPanel;
        private var _highLockInfo:Object;
        public var info:PropInfo;
        private var hasOpenTipsDay:Boolean = false;
        private static var instance:ProtectControl;

        public function ProtectControl()
        {
            this.protocol = new ProtectProtocol();
            this.protectData = ProtectData.getInstance();
            this._highLockInfo = new Object();
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.SET_MY_INFO, this.onPlayerLevelChange);
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.onPlayerLevelChange);
            FrameworkGlobal.stage.addEventListener(SysCueEvent.LINK, this.onSysCueLink);
            ProtectManager.itemViewProtectMarkUpdater = ProtectItemMarkView.updateItemView;
            ProtectManager.itemViewHighProtectMarkUpdater = ProtectItemHighMarkView.updateItemView;
            this.onPlayerLevelChange();
            return;
        }// end function

        private function onPlayerLevelChange(event:RoleEvent = null) : void
        {
            var _loc_2:* = this.protectData.lockEnabled;
            this.protectData.refreshPlayerLevel();
            if (!_loc_2 && this.protectData.lockEnabled && event != null && event.type == RoleEvent.UPDATE_LEVEL)
            {
                if (!this.protectServerIcon)
                {
                    this.protectServerIcon = new ProtectServerIcon();
                }
                this.protectServerIcon.show();
            }
            return;
        }// end function

        private function openOrCloseCreatePasswordIntroPanel() : void
        {
            if (this.createPasswordPanel != null && this.createPasswordPanel.isOpen)
            {
                this.createPasswordPanel.close();
                return;
            }
            if (this.createPasswordIntroPanel == null)
            {
                this.createPasswordIntroPanel = new ProtectCreatePasswordIntroPanel();
            }
            this.createPasswordIntroPanel.openOrClose();
            return;
        }// end function

        public function openCreatePasswordPanel() : void
        {
            if (this.createPasswordPanel == null)
            {
                this.createPasswordPanel = new ProtectCreatePasswordPanel();
            }
            this.createPasswordPanel.open();
            return;
        }// end function

        private function getUnlockPanel() : ProtectUnlockPanel
        {
            if (this.unlockPanel == null)
            {
                this.unlockPanel = new ProtectUnlockPanel();
            }
            return this.unlockPanel;
        }// end function

        private function openOrCloseUnlockPanel() : void
        {
            this.getUnlockPanel().openOrClose();
            return;
        }// end function

        private function openUnlockPanel() : void
        {
            this.getUnlockPanel().open();
            return;
        }// end function

        private function openOrCloseLockPanel() : void
        {
            if (this.lockPanel == null)
            {
                this.lockPanel = new ProtectLockPanel();
            }
            this.lockPanel.openOrClose();
            return;
        }// end function

        public function openModifyPasswordPanel() : void
        {
            if (this.modifyPasswordPanel == null)
            {
                this.modifyPasswordPanel = new ProtectModifyPasswordPanel();
            }
            this.modifyPasswordPanel.open();
            return;
        }// end function

        public function openCreatePasswordRemindPanel() : void
        {
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12408"), LanguageCfgObj.getInstance().getByIndex("11635"), null, null, null, 1);
            return;
        }// end function

        private function onSysCueLink(event:SysCueEvent = null) : void
        {
            if (event.data == "openCreatePasswordPanel")
            {
                if (!this.protectData.hasPassword)
                {
                    if ((this.createPasswordIntroPanel == null || !this.createPasswordIntroPanel.isOpen) && (this.createPasswordPanel == null || !this.createPasswordPanel.isOpen))
                    {
                        BackPackControl.getInstance().openBackpack();
                        this.openOrCloseCreatePasswordIntroPanel();
                    }
                }
                else
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12409"));
                }
            }
            return;
        }// end function

        public function changeLockState() : void
        {
            if (!this.protectData.hasPassword)
            {
                this.openOrCloseCreatePasswordIntroPanel();
            }
            else if (this.protectData.locked)
            {
                this.openOrCloseUnlockPanel();
            }
            else
            {
                this.openOrCloseLockPanel();
            }
            return;
        }// end function

        public function createPassword(param1:String, param2:String, param3:String) : void
        {
            if (this.protectData.hasPassword)
            {
                return;
            }
            this.protocol.reqPasswordSetToGame(param1, param2, param3);
            return;
        }// end function

        public function checkOldPassword(param1:int, param2:String) : void
        {
            this.protocol.reqVerification(param1, param2);
            return;
        }// end function

        public function modifyPassword(param1:String, param2:String) : void
        {
            if (!this.protectData.hasPassword)
            {
                return;
            }
            this.protocol.reqModifyPasswordToGame(param2, param1);
            return;
        }// end function

        public function unlock(param1:String) : void
        {
            if (!this.protectData.locked)
            {
                return;
            }
            this.protocol.reqPasswordUnlockToGame(param1);
            return;
        }// end function

        public function lock(param1:String) : void
        {
            if (this.protectData.locked)
            {
                return;
            }
            this.protocol.reqPasswordLockToGame(param1);
            return;
        }// end function

        public function highUnlock(param1:long) : void
        {
            this.protocol.reqHighUnlockToGame(param1);
            return;
        }// end function

        public function highLock(param1:long) : void
        {
            this.protocol.reqHighLockToGame(param1);
            return;
        }// end function

        public function promptIfLocked() : Boolean
        {
            if (this.protectData.locked)
            {
                this.openUnlockPanel();
            }
            return this.protectData.locked;
        }// end function

        public function resAskedPanelToClient(param1:ResAskedPanelToClientMessage) : void
        {
            this.openUnlockPanel();
            return;
        }// end function

        public function resPointToClient(param1:ResPointToClientMessage) : void
        {
            this.protectData.refreshOperationState(param1);
            return;
        }// end function

        public function resProtectState(param1:ResProtectStateMessage) : void
        {
            this.protectData.updateData(param1);
            return;
        }// end function

        public function resVerification(param1:ResVerificationMessage) : void
        {
            this.protectData.setPasswordCompareResult(param1.sessionId, param1.result == 0);
            return;
        }// end function

        public function resProtectItemMessage(param1:ResProtectItemMessage) : void
        {
            var _loc_3:* = null;
            var _loc_7:* = null;
            var _loc_2:* = false;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            while (_loc_6 < param1.info.length)
            {
                
                _loc_7 = BackpackObj.getInstance().getItemById(param1.info[_loc_6].itemId);
                if (_loc_7)
                {
                    _loc_4 = true;
                    _loc_3 = _loc_7;
                }
                if (!_loc_7)
                {
                    _loc_7 = StoreModel.getInstance().getInfoById(param1.info[_loc_6].itemId);
                }
                if (!_loc_7)
                {
                    _loc_7 = EquipsObj.getInstance().getEquipById(param1.info[_loc_6].itemId);
                }
                if (_loc_7)
                {
                    _loc_7.lockedEndTime = param1.info[_loc_6].endTime;
                    _loc_2 = true;
                    if (_loc_7.lockedEndTime != -1 && _loc_7.lockedEndTime != 0)
                    {
                        _loc_5++;
                    }
                    _loc_7.dispatchEvt(new GameEvent("HIGH_LOCK_UPDE"));
                }
                this._highLockInfo[param1.info[_loc_6].itemId.toString()] = param1.info[_loc_6].endTime;
                _loc_6++;
            }
            if (_loc_2)
            {
                if (_loc_5)
                {
                    this.showTips(_loc_5);
                }
                if (_loc_4)
                {
                    BackPackControl.getInstance().updateItem(_loc_3);
                }
            }
            return;
        }// end function

        private function showTips(param1:int) : void
        {
            var _loc_2:* = new ProtectHighServerIcon();
            _loc_2.count = param1;
            Global.popManager.addedServerToCue(_loc_2);
            return;
        }// end function

        public function resProtectMessage(param1:ResProtectMessage) : void
        {
            this._highLockInfo[param1.itemId.toString()] = param1.endTime;
            var _loc_2:* = false;
            var _loc_3:* = BackpackObj.getInstance().getItemById(param1.itemId);
            if (_loc_3)
            {
                _loc_2 = true;
            }
            if (!_loc_3)
            {
                _loc_3 = StoreModel.getInstance().getInfoById(param1.itemId);
            }
            if (_loc_3)
            {
                _loc_3.lockedEndTime = param1.endTime;
                if (_loc_2)
                {
                    BackPackControl.getInstance().updateItem(_loc_3);
                }
                _loc_3.dispatchEvt(new GameEvent("HIGH_LOCK_UPDE"));
            }
            return;
        }// end function

        public function setHighLock(param1:PropInfo) : Boolean
        {
            if (param1 && this._highLockInfo[param1.itemId.toString()])
            {
                param1.lockedEndTime = this._highLockInfo[param1.itemId.toString()];
                return true;
            }
            return false;
        }// end function

        public function showHighLockedTips() : void
        {
            var tips:String;
            if (!this.hasOpenTipsDay)
            {
                tips = LanguageCfgObj.getInstance().getByIndex("10003", "lang_highlock");
                Global.popManager.cue(tips, LanguageCfgObj.getInstance().getByIndex("10004", "lang_highlock"), null, function () : void
            {
                if (info)
                {
                    highLock(info.itemId);
                }
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10638"), false, true, function (param1:Boolean) : void
            {
                hasOpenTipsDay = param1;
                return;
            }// end function
            );
            }
            else
            {
                this.highLock(this.info.itemId);
            }
            return;
        }// end function

        public static function getInstance() : ProtectControl
        {
            var _loc_1:* = new ProtectControl;
            instance = new ProtectControl;
            return instance || _loc_1;
        }// end function

    }
}
