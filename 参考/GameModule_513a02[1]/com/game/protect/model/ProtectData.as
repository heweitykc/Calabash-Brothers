package com.game.protect.model
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.game.protect.event.*;
    import com.game.protect.message.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;

    public class ProtectData extends EventDispatcher
    {
        public var lockEnabled:Boolean = false;
        public var hasPassword:Boolean = false;
        public var locked:Boolean = false;
        private static var instance:ProtectData;

        public function ProtectData()
        {
            return;
        }// end function

        public function isPreciousItem(param1:PropInfo) : Boolean
        {
            var _loc_2:* = null;
            if (param1.q_lock == 1)
            {
                return true;
            }
            if (param1.suitId != 0)
            {
                return true;
            }
            if (param1 is EquipmentInfo)
            {
                _loc_2 = param1 as EquipmentInfo;
                if (_loc_2.intensify >= GlobalCfgObj.getInstance().getPreciousItemMinIntensify())
                {
                    return true;
                }
                if (_loc_2.addAttributLevel >= GlobalCfgObj.getInstance().getPreciousItemMinAddAttributLevel())
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function hasPreciousItem(param1) : Boolean
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                if (this.isPreciousItem(_loc_2))
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getPreciousItems(param1) : Vector.<PropInfo>
        {
            var _loc_3:* = null;
            var _loc_2:* = new Vector.<PropInfo>;
            for each (_loc_3 in param1)
            {
                
                if (this.isPreciousItem(_loc_3))
                {
                    _loc_2.push(_loc_3);
                }
            }
            return _loc_2;
        }// end function

        public function isItemLocked(param1:PropInfo) : Boolean
        {
            return this.locked && this.isPreciousItem(param1) && param1.lockedEndTime == 0;
        }// end function

        public function isItemHighLocked(param1:PropInfo) : Boolean
        {
            return param1.lockedEndTime != 0;
        }// end function

        public function updateData(param1:ResProtectStateMessage) : void
        {
            this.hasPassword = param1.type != 0;
            this.locked = param1.type == 1;
            dispatchEvent(new ProtectEvent(ProtectEvent.PROTECT_DATA_CHANGE));
            return;
        }// end function

        public function refreshPlayerLevel() : void
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.level >= ProtectConst.protectEnablePlayerLevel;
            if (this.lockEnabled != _loc_1)
            {
                this.lockEnabled = _loc_1;
                dispatchEvent(new ProtectEvent(ProtectEvent.PROTECT_DATA_CHANGE));
            }
            return;
        }// end function

        public function setPasswordCompareResult(param1:int, param2:Boolean) : void
        {
            dispatchEvent(new ProtectEvent(ProtectEvent.PASSWORD_COMPARE_RESULT, {sessionId:param1, ok:param2}));
            return;
        }// end function

        public function refreshOperationState(param1:ResPointToClientMessage) : void
        {
            switch(param1.type)
            {
                case 2:
                case 7:
                {
                    Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11094"));
                    break;
                }
                case 5:
                {
                    dispatchEvent(new ProtectEvent(ProtectEvent.MODIFY_PASSWORD_OK));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : ProtectData
        {
            var _loc_1:* = new ProtectData;
            instance = new ProtectData;
            return instance || _loc_1;
        }// end function

    }
}
