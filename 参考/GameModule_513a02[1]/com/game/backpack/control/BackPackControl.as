package com.game.backpack.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.backpack.bean.*;
    import com.game.backpack.events.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import com.game.backpack.protocol.*;
    import com.game.backpack.view.*;
    import com.game.chat.bean.*;
    import com.game.chat.control.*;
    import com.game.confirm.*;
    import com.game.equip.message.*;
    import com.game.expireguide.control.*;
    import com.game.map.control.*;
    import com.game.player.control.*;
    import com.game.player.model.*;
    import com.game.primaryrole.control.*;
    import com.game.prompt.control.*;
    import com.game.protect.control.*;
    import com.game.protect.model.*;
    import com.game.shop.control.*;
    import com.game.shop.utils.*;
    import com.game.store.control.*;
    import com.game.transactions.control.*;
    import com.game.utils.*;
    import com.manager.cd.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.utils.*;

    public class BackPackControl extends Object
    {
        private var _backpackprotocol:BackPackProtocol;
        private var _backpackObj:BackpackObj;
        private var _menu:ItemPopMenu;
        private var _mode:String = "normal";
        public var fastSelect:Boolean = false;
        private var _spiltpanel:ItemSpiltPanel;
        public var updateExpTip:Boolean = false;
        private var _backpackPanel:BackPackPanel;
        private var _batchUse:BatchUsePanel;
        private var _isShowingOpenItemrender:Boolean;
        private var soldPreciousItemAutoConfirm:Boolean = false;
        private var _endCDAfterReqTimeId:int;
        private var _beforeEndCDReqTimeId:int;
        private var _waitArr:Array;
        private var _talentPoints:Array;
        private var _readyToEquip:EquipmentInfo;
        private var _cellEndTime:int;
        private var _cellId:int;
        public var timer:int;
        private var _openTimeid:int;
        private var _backpackview:BackpackView;
        private static var _instance:BackPackControl;
        public static const SELL:String = "sell";
        public static const TRANSCATION:String = "transcation";
        public static const NORMAL:String = "normal";
        public static const ADDTOSTALLS:String = "addtostalls";

        public function BackPackControl()
        {
            this._waitArr = [];
            this._backpackprotocol = new BackPackProtocol();
            this._menu = ItemPopMenu.instance;
            this._backpackObj = BackpackObj.getInstance();
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this._userLevelUpdate);
            return;
        }// end function

        public function get isShowingOpenItemrender() : Boolean
        {
            return this._isShowingOpenItemrender;
        }// end function

        public function set isShowingOpenItemrender(param1:Boolean) : void
        {
            this._isShowingOpenItemrender = param1;
            return;
        }// end function

        public function get mode() : String
        {
            return this._mode;
        }// end function

        public function openSpilt(param1:PropInfo) : void
        {
            if (this._spiltpanel == null)
            {
                this._spiltpanel = new ItemSpiltPanel();
                Global.popManager.addPop(this._spiltpanel, true, true, true, true, false, true);
            }
            this._spiltpanel.info = param1;
            this._spiltpanel.open();
            return;
        }// end function

        public function set mode(param1:String) : void
        {
            if (this._mode != param1)
            {
                this._mode = param1;
                switch(this._mode)
                {
                    case NORMAL:
                    {
                        Global.primaryCursorManager.hide();
                        break;
                    }
                    case SELL:
                    {
                        Global.primaryCursorManager.showSellIcon();
                        BackPackControl.getInstance().fastSelect = true;
                        break;
                    }
                    case TRANSCATION:
                    {
                        Global.primaryCursorManager.showTradeIcon();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                BackpackObj.getInstance().dispatchEvt(new BackpackEvent(BackpackEvent.MODE_CHANGE, null));
            }
            return;
        }// end function

        public function cancelFastClick() : void
        {
            switch(BackPackControl.getInstance().mode)
            {
                case BackPackControl.SELL:
                {
                    this.mode = NORMAL;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.closeSelectStatus();
            return;
        }// end function

        public function get backpackview() : BackpackView
        {
            return this._backpackview;
        }// end function

        public function set backpackview(param1:BackpackView) : void
        {
            this._backpackview = param1;
            return;
        }// end function

        private function _userLevelUpdate(event:RoleEvent) : void
        {
            this.updateExpTip = true;
            if (this._backpackPanel && this._backpackPanel.isOpen)
            {
                this._backpackview.repaintExp();
                this.updateExpTip = false;
            }
            return;
        }// end function

        public function openBackpack() : void
        {
            if (this._backpackPanel == null)
            {
                this._backpackPanel = new BackPackPanel();
                Global.popManager.addPop(this._backpackPanel);
            }
            this._backpackPanel.open();
            return;
        }// end function

        private function insert() : void
        {
            var _loc_1:* = new Vector.<GoodsInfoRes>;
            var _loc_2:* = new GoodsInfoRes();
            _loc_2.ItemInfo = new ItemInfo();
            _loc_2.ItemInfo.itemModelId = 700070;
            _loc_1.push(_loc_2);
            PromptControl.getInstance().personToNotice(12, "lalala", new Vector.<String>, _loc_1);
            return;
        }// end function

        private function end(... args) : void
        {
            Global.popManager.cue(args[0] + args[1]);
            return;
        }// end function

        public function openUseBatch(param1:PropInfo) : void
        {
            if (this._batchUse == null)
            {
                this._batchUse = new BatchUsePanel();
                Global.popManager.addPop(this._batchUse, true, false, true, true, false, true);
            }
            this._batchUse.info = param1;
            this._batchUse.open();
            return;
        }// end function

        public function openorcloseBackpack() : void
        {
            if (this._backpackPanel == null)
            {
                this._backpackPanel = new BackPackPanel();
                Global.popManager.addPop(this._backpackPanel);
            }
            this._backpackPanel.openOrClose();
            if (this._backpackPanel.isOpen == false)
            {
                ShopController.getInstance().closeShop();
            }
            return;
        }// end function

        public function delItem(param1:PropInfo) : void
        {
            this._backpackprotocol.dropItem(param1.gridId);
            return;
        }// end function

        public function updateBox() : void
        {
            var _loc_3:* = false;
            if (this._backpackPanel && this._backpackPanel.isOpen)
            {
                this._backpackPanel.updateBox();
            }
            BackpackObj.getInstance().checkFull();
            var _loc_1:* = BackpackObj.getInstance().info.items;
            var _loc_2:* = 0;
            while (_loc_1 && _loc_2 < _loc_1.length)
            {
                
                _loc_3 = ProtectControl.getInstance().setHighLock(_loc_1[_loc_2]);
                if (_loc_3)
                {
                    _loc_1[_loc_2].dispatchEvt(new GameEvent("HIGH_LOCK_UPDE"));
                }
                _loc_2++;
            }
            return;
        }// end function

        public function equipConfirm() : void
        {
            var _loc_1:* = null;
            if (this.readyToEquip == null || this._talentPoints == null)
            {
                return;
            }
            _loc_1 = this.createTalentLabel(this.readyToEquip, this._talentPoints);
            Global.popManager.cue(_loc_1, "", null, this.equipAndClear, this.clearTalentsForTalent, 1);
            return;
        }// end function

        private function equipAndClear() : void
        {
            this.equip(this.readyToEquip);
            this.clearTalentsForTalent();
            return;
        }// end function

        private function createTalentLabel(param1:EquipmentInfo, param2:Array) : String
        {
            var _loc_3:* = LanguageCfgObj.getInstance().getByIndex("10331");
            var _loc_4:* = false;
            if (param2[3] > 0)
            {
                _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11908"), [param2[3]]);
                _loc_4 = true;
            }
            if (param2[2] > 0)
            {
                _loc_3 = _loc_3 + (_loc_4 == true ? ("，") : (""));
                _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11909"), [param2[2]]);
                _loc_4 = true;
            }
            if (param2[0])
            {
                _loc_3 = _loc_3 + (_loc_4 == true ? ("，") : (""));
                _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11910"), [param2[0]]);
                _loc_4 = true;
            }
            if (param2[1])
            {
                _loc_3 = _loc_3 + (_loc_4 == true ? ("，") : (""));
                _loc_3 = _loc_3 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11911"), [param2[1]]);
            }
            _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11912");
            _loc_3 = _loc_3 + LanguageCfgObj.getInstance().getByIndex("11913");
            var _loc_5:* = PropUtil.getEquipColor(param1);
            var _loc_6:* = PropUtil.getEquipName(param1, false, true);
            _loc_3 = _loc_3 + ("<font color = \'#" + _loc_5.toString(16) + "\'><u>" + _loc_6 + "</u></font>");
            return _loc_3;
        }// end function

        public function setLock(param1:long, param2:Boolean) : void
        {
            this._backpackPanel.setLock(param1, param2);
            return;
        }// end function

        public function changeToTransaction() : void
        {
            this.mode = TRANSCATION;
            this.fastSelect = true;
            if (this._backpackPanel == null)
            {
                this._backpackPanel = new BackPackPanel();
                Global.popManager.addPop(this._backpackPanel);
            }
            this._backpackPanel.open();
            this._backpackPanel.changeToTranscation();
            return;
        }// end function

        public function inStalls() : void
        {
            this.mode = ADDTOSTALLS;
            this.lockToBind();
            return;
        }// end function

        public function changeToAddedStalls() : void
        {
            this.mode = ADDTOSTALLS;
            this.fastSelect = true;
            if (this._backpackPanel == null)
            {
                this._backpackPanel = new BackPackPanel();
                Global.popManager.addPop(this._backpackPanel);
            }
            this._backpackPanel.open();
            this._backpackPanel.changeToAddedStalls();
            return;
        }// end function

        public function addToStalls(param1:PropInfo) : void
        {
            AuctionControl.getInstance().addToStalls(param1);
            return;
        }// end function

        public function showOpenItemrenderer() : void
        {
            if (this._backpackPanel)
            {
                this._isShowingOpenItemrender = false;
                this._backpackPanel.showOpenItemrenderer();
            }
            return;
        }// end function

        public function releaseLock() : void
        {
            this.mode = NORMAL;
            if (this._backpackPanel)
            {
                this._backpackPanel.releaseLock();
            }
            return;
        }// end function

        public function lockToBind() : void
        {
            if (this._backpackPanel)
            {
                this._backpackPanel.lockToBind();
            }
            return;
        }// end function

        public function moveToTranscation(param1:PropInfo) : void
        {
            TransactionControl.getInstance().moveToTranscation(param1);
            return;
        }// end function

        public function returnOtherToNormal() : void
        {
            if (this.mode == ADDTOSTALLS)
            {
                AuctionControl.getInstance().cancelSelectFromBackpack();
            }
            if (this.mode == SELL)
            {
                ShopController.getInstance().cancelSell();
            }
            if (this.mode == TRANSCATION)
            {
                TransactionControl.getInstance().cancelSelectFromBackpack();
            }
            this.fastSelect = false;
            return;
        }// end function

        public function changeToSell() : void
        {
            this.mode = SELL;
            this.fastSelect = true;
            if (this._backpackPanel == null)
            {
                this._backpackPanel = new BackPackPanel();
                Global.popManager.addPop(this._backpackPanel);
            }
            this._backpackPanel.open();
            this._backpackPanel.changeToSell();
            return;
        }// end function

        public function closeSell(param1:String) : void
        {
            if (this.mode == param1)
            {
                this.releaseLock();
                this.closeSelectStatus();
            }
            return;
        }// end function

        public function closeSelectStatus() : void
        {
            this.fastSelect = false;
            if (this._backpackPanel)
            {
                this._backpackPanel.closeSelectStatus();
            }
            return;
        }// end function

        public function arrange() : void
        {
            this._backpackprotocol.arrange();
            return;
        }// end function

        public function openShop() : void
        {
            if (UserObj.getInstance().playerInfo.pkValue > 0)
            {
                PlayerControl.getInstance().openBannerTips();
            }
            else
            {
                ShopController.getInstance().openorcloseShop();
            }
            return;
        }// end function

        public function isAddToStalls() : Boolean
        {
            return this.mode == ADDTOSTALLS;
        }// end function

        public function isSell() : Boolean
        {
            return this.mode == SELL;
        }// end function

        public function isTranscation() : Boolean
        {
            return this.mode == TRANSCATION;
        }// end function

        public function openDepot() : void
        {
            StoreControl.getInstance().openStoragePayGold();
            return;
        }// end function

        public function openBooth() : void
        {
            AuctionControl.getInstance().openStalls();
            return;
        }// end function

        public function recharge() : void
        {
            return;
        }// end function

        public function closeBackpack() : void
        {
            this._backpackPanel.close();
            return;
        }// end function

        public function reqCellTime(param1:int) : void
        {
            this._backpackprotocol.reqCellTime(param1);
            return;
        }// end function

        public function itemPopUp(param1:PropInfo, param2:DisplayObject, param3:int = 0, param4:int = 0) : void
        {
            this._menu.show(param1, param2, param3, param4);
            return;
        }// end function

        public function soldItem(param1:PropInfo) : void
        {
            var info:* = param1;
            var callback:* = function () : void
            {
                doSoldItem(info);
                return;
            }// end function
            ;
            if (!info.q_sell)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10332"));
                return;
            }
            if (!this.soldPreciousItemAutoConfirm && ProtectData.getInstance().isPreciousItem(info))
            {
                Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11914"), LanguageCfgObj.getInstance().getByIndex("11915"), null, callback, null, 2, null, false, true, function (param1:Boolean) : void
            {
                soldPreciousItemAutoConfirm = param1;
                return;
            }// end function
            );
            }
            else
            {
                this.callback();
            }
            return;
        }// end function

        private function doSoldItem(param1:PropInfo) : void
        {
            var _loc_2:* = new Vector.<long>;
            _loc_2.push(param1.itemId);
            ShopController.getInstance().sell(_loc_2);
            return;
        }// end function

        public function spilt(param1:long, param2:int) : void
        {
            this._backpackprotocol.spilt(param1, param2);
            return;
        }// end function

        public function cellTimeRes() : void
        {
            clearTimeout(this._beforeEndCDReqTimeId);
            if (BackpackObj.getInstance().info.cellTime - 10 > 5)
            {
                this._beforeEndCDReqTimeId = setTimeout(this.reqCellTime, (BackpackObj.getInstance().info.cellTime - 10) * 1000, BackpackObj.getInstance().info.openningGridId);
            }
            return;
        }// end function

        public function useItem(param1:PropInfo, param2:int = 1) : Boolean
        {
            var cds:Array;
            var buffs:Array;
            var addBuffInfo:BuffInfo;
            var buffModelId:int;
            var buffInfo:BuffInfo;
            var info:* = param1;
            var num:* = param2;
            if (info.q_ui)
            {
                BackPackControl.getInstance().openUI(info);
                if (info.q_ui != 43)
                {
                    return true;
                }
            }
            if (info.q_type == ItemType.MEDICINE)
            {
                cds = CDManager.getInstance().getCD(CDTypes.DRUG, info.itemModelId, info.q_cooldown_level);
                if (cds[0] > 0)
                {
                    return false;
                }
            }
            var buffStr:* = info.q_buff;
            if (buffStr != null && buffStr != "" && buffStr != "0")
            {
                buffs = buffStr.split(";");
                var _loc_4:* = 0;
                var _loc_5:* = buffs;
                while (_loc_5 in _loc_4)
                {
                    
                    buffModelId = _loc_5[_loc_4];
                    addBuffInfo = BuffCfgObj.getInstance().getBuffInfo(buffModelId);
                    if (!addBuffInfo.q_buff_warning)
                    {
                        continue;
                    }
                    var _loc_6:* = 0;
                    var _loc_7:* = UserObj.getInstance().playerInfo.buffs;
                    while (_loc_7 in _loc_6)
                    {
                        
                        buffInfo = _loc_7[_loc_6];
                        if (addBuffInfo.q_overlay == buffInfo.q_overlay && addBuffInfo.q_replace_level == buffInfo.q_replace_level && addBuffInfo.q_buff_id != buffInfo.q_buff_id)
                        {
                            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11916"), "", null, function () : void
            {
                _backpackprotocol.uses(info.itemId, num);
                return;
            }// end function
            , null);
                            return true;
                        }
                    }
                }
            }
            switch(info.itemModelId)
            {
                default:
                {
                    break;
                }
            }
            if (info.q_type == ItemType.TITLE)
            {
                this._backpackprotocol.getTitle(info.itemId);
            }
            else
            {
                this._backpackprotocol.uses(info.itemId, num);
            }
            return true;
        }// end function

        public function useItemId(param1:long, param2:int) : void
        {
            this._backpackprotocol.uses(param1, param2);
            return;
        }// end function

        public function useItems(param1:PropInfo) : void
        {
            this.openUseBatch(param1);
            return;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            ChatController.getInstance().linkToChat(param1);
            return;
        }// end function

        public function removeItemHandler(param1:ResItemRemoveMessage) : void
        {
            this._backpackObj.removeItem(param1.itemId);
            return;
        }// end function

        public function removEquipHandler(param1:UnwearEquipItemMessage) : void
        {
            EquipsObj.getInstance().removeEquip(param1.itemId, (param1.pos + 1));
            return;
        }// end function

        public function moveItem(param1:long, param2:int, param3:int) : void
        {
            this._backpackprotocol.moveItem(param1, param2, param3);
            return;
        }// end function

        public function updateItem(param1:PropInfo) : void
        {
            this._backpackObj.updateItem(param1);
            return;
        }// end function

        public function updateItemByItemInfo(param1:ItemInfo) : void
        {
            this._backpackObj.updateItemByItemInfo(param1);
            return;
        }// end function

        public function addItem(param1:PropInfo) : void
        {
            this._backpackObj.addItem(param1);
            return;
        }// end function

        public function takeOff(param1:long) : void
        {
            this._backpackprotocol.takeoff(param1);
            return;
        }// end function

        public function equip(param1:EquipmentInfo) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            param1.isUsing = true;
            if (param1.q_kind == Params.PET && PropUtil.checkItemExpire(param1))
            {
                ExpireGuideControl.getInstance().showByEquipInfo(param1);
                return;
            }
            var _loc_2:* = this.isCanEquip(param1);
            if (!_loc_2)
            {
                return;
            }
            var _loc_3:* = UserObj.getInstance().playerInfo;
            if (param1.q_kind == Params.LEFT_WEAPON || param1.q_kind == Params.RIGHT_WEAPON)
            {
                _loc_5 = EquipsObj.getInstance().getEquipBy(Params.LEFT_WEAPON);
                _loc_6 = EquipsObj.getInstance().getEquipBy(Params.RIGHT_WEAPON);
                if (long.isZero(_loc_5.itemId) || _loc_5.q_secondary_type != 2)
                {
                    if (param1.q_secondary_type == 2)
                    {
                        _loc_7 = 0;
                        if (!long.isZero(_loc_5.itemId))
                        {
                            _loc_7++;
                        }
                        if (!long.isZero(_loc_6.itemId))
                        {
                            _loc_7++;
                        }
                        if (_loc_7 > BackpackObj.getInstance().getIdle())
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10333"));
                            return;
                        }
                        this._backpackprotocol.equip(param1.itemId, Params.LEFT_WEAPON);
                    }
                    else if (param1.q_third_type == 1)
                    {
                        this._backpackprotocol.equip(param1.itemId, Params.LEFT_WEAPON);
                    }
                    else if (param1.q_kind == 2)
                    {
                        this._backpackprotocol.equip(param1.itemId, Params.RIGHT_WEAPON);
                    }
                    else
                    {
                        _loc_8 = _loc_5.fightNumber > _loc_6.fightNumber ? (_loc_5) : (_loc_6);
                        _loc_9 = _loc_5.fightNumber > _loc_6.fightNumber ? (_loc_6) : (_loc_5);
                        if (_loc_8.itemId)
                        {
                            if (param1.fightNumber > _loc_8.fightNumber)
                            {
                                if (_loc_6 != _loc_8)
                                {
                                    this._backpackprotocol.equip(_loc_8.itemId, Params.RIGHT_WEAPON);
                                }
                                this._backpackprotocol.equip(param1.itemId, Params.LEFT_WEAPON);
                            }
                            else
                            {
                                if (_loc_5 != _loc_8)
                                {
                                    this._backpackprotocol.equip(_loc_8.itemId, Params.LEFT_WEAPON);
                                }
                                this._backpackprotocol.equip(param1.itemId, Params.RIGHT_WEAPON);
                            }
                        }
                        else
                        {
                            this._backpackprotocol.equip(param1.itemId, Params.LEFT_WEAPON);
                        }
                    }
                }
                else
                {
                    this._backpackprotocol.equip(param1.itemId, param1.q_kind);
                }
            }
            else if (param1.q_kind == Params.RING1 || param1.q_kind == Params.RING2)
            {
                _loc_10 = EquipsObj.getInstance().getEquipBy(Params.RING1);
                _loc_11 = EquipsObj.getInstance().getEquipBy(Params.RING2);
                if (long.isZero(_loc_10.itemId))
                {
                    this._backpackprotocol.equip(param1.itemId, Params.RING1);
                }
                else if (long.isZero(_loc_11.itemId))
                {
                    this._backpackprotocol.equip(param1.itemId, Params.RING2);
                }
                else if (_loc_10.fightNumber < _loc_11.fightNumber)
                {
                    this._backpackprotocol.equip(param1.itemId, Params.RING1);
                }
                else
                {
                    this._backpackprotocol.equip(param1.itemId, Params.RING2);
                }
            }
            else
            {
                this._backpackprotocol.equip(param1.itemId, param1.q_kind);
            }
            return;
        }// end function

        private function isCanEquip(param1:EquipmentInfo) : Boolean
        {
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_9:* = 0;
            var _loc_11:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = false;
            if (param1 == null)
            {
                return false;
            }
            if (!UserObj.getInstance().playerInfo.alive())
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10334"));
                return false;
            }
            var _loc_2:* = UserObj.getInstance().playerInfo.job;
            var _loc_3:* = param1.isUseForJob(_loc_2);
            if (!_loc_3)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10335"));
                return false;
            }
            if (UserObj.getInstance().playerInfo.level < param1.q_level)
            {
                Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11917"), [param1.q_level]));
                return false;
            }
            var _loc_4:* = UserObj.getInstance().playerInfo.strength;
            if (UserObj.getInstance().playerInfo.strength < param1.q_str_limit)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10336"));
                _loc_5 = param1.q_str_limit - _loc_4;
            }
            var _loc_6:* = UserObj.getInstance().playerInfo.vitality;
            if (UserObj.getInstance().playerInfo.vitality < param1.q_vit_limit)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10337"));
                _loc_7 = param1.q_vit_limit - _loc_6;
            }
            var _loc_8:* = UserObj.getInstance().playerInfo.agile;
            if (UserObj.getInstance().playerInfo.agile < param1.q_agile_limit)
            {
                _loc_9 = param1.q_agile_limit - _loc_8;
            }
            var _loc_10:* = UserObj.getInstance().playerInfo.intelligence;
            if (UserObj.getInstance().playerInfo.intelligence < param1.q_int_limit)
            {
                _loc_11 = param1.q_int_limit - _loc_10;
            }
            var _loc_12:* = _loc_5 + _loc_7 + _loc_9 + _loc_11;
            if (_loc_5 + _loc_7 + _loc_9 + _loc_11 > 0)
            {
                if (_loc_12 <= UserObj.getInstance().playerInfo.unallocatedTalent)
                {
                    if (this._readyToEquip != null)
                    {
                        this._waitArr.push(param1);
                        return false;
                    }
                    _loc_13 = LanguageCfgObj.getInstance().getByIndex("10338");
                    if (param1.q_str_limit)
                    {
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11908"), [param1.q_str_limit]);
                        _loc_14 = true;
                    }
                    if (param1.q_vit_limit)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11909"), [param1.q_vit_limit]);
                        _loc_14 = true;
                    }
                    if (param1.q_agile_limit)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11910"), [param1.q_agile_limit]);
                        _loc_14 = true;
                    }
                    if (param1.q_int_limit)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11911"), [param1.q_int_limit]);
                    }
                    _loc_13 = _loc_13 + "。";
                    _loc_13 = _loc_13 + ("<br>" + LanguageCfgObj.getInstance().getByIndex("11918") + "<br><font color = \'#ffeab7\'>" + LanguageCfgObj.getInstance().getByIndex("11919"));
                    _loc_14 = false;
                    if (_loc_5 > 0)
                    {
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11908"), [_loc_5]);
                        _loc_14 = true;
                    }
                    if (_loc_7 > 0)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11909"), [_loc_7]);
                        _loc_14 = true;
                    }
                    if (_loc_9 > 0)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11910"), [_loc_9]);
                        _loc_14 = true;
                    }
                    if (_loc_11)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11911"), [_loc_11]);
                    }
                    _loc_13 = _loc_13 + LanguageCfgObj.getInstance().getByIndex("11912");
                    _loc_13 = _loc_13 + (LanguageCfgObj.getInstance().getByIndex("11920") + "</font>");
                    this._talentPoints = [_loc_9, _loc_7, _loc_11, _loc_5];
                    this._readyToEquip = param1;
                    Global.popManager.cue(_loc_13, LanguageCfgObj.getInstance().getByIndex("10339"), this._talentPoints, this.callForTalent, this.clearTalentsForTalent);
                }
                else
                {
                    _loc_13 = LanguageCfgObj.getInstance().getByIndex("10340");
                    if (_loc_5 > 0)
                    {
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11908"), [_loc_5]);
                        _loc_14 = true;
                    }
                    if (_loc_7 > 0)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11909"), [_loc_7]);
                        _loc_14 = true;
                    }
                    if (_loc_9 > 0)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11910"), [_loc_9]);
                        _loc_14 = true;
                    }
                    if (_loc_11)
                    {
                        _loc_13 = _loc_13 + (_loc_14 == true ? ("，") : (""));
                        _loc_13 = _loc_13 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11911"), [_loc_11]);
                    }
                    _loc_13 = _loc_13 + ("</font>" + LanguageCfgObj.getInstance().getByIndex("11912") + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11921"), [this.getNeedLevel(_loc_12)]));
                    Global.popManager.cue(_loc_13, LanguageCfgObj.getInstance().getByIndex("10339"));
                }
                return false;
            }
            return true;
        }// end function

        public function getNeedLevel(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_2:* = param1 - UserObj.getInstance().playerInfo.unallocatedTalent;
            if (_loc_2 < 0)
            {
                return 0;
            }
            _loc_3 = UserObj.getInstance().playerInfo.level;
            _loc_4 = 220;
            if (_loc_3 < _loc_4)
            {
                _loc_5 = (_loc_4 - _loc_3) * 5;
                if (_loc_2 <= _loc_5)
                {
                    return Math.ceil(_loc_2 / 5);
                }
                _loc_2 = _loc_2 - _loc_5;
                return _loc_4 - _loc_3 + Math.ceil(_loc_2 / 6);
            }
            else
            {
                return Math.ceil(_loc_2 / 6);
            }
        }// end function

        private function clearTalentsForTalent() : void
        {
            var _loc_1:* = null;
            this._talentPoints = null;
            this._readyToEquip = null;
            if (this.readyToEquip)
            {
                this.readyToEquip.isUsing = false;
            }
            if (this._waitArr.length > 0)
            {
                _loc_1 = this._waitArr.shift();
                this.equip(_loc_1);
            }
            return;
        }// end function

        private function callForTalent(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
        {
            PrimaryRoleControl.getInstance().addPoint(param1, param2, param3, param4);
            return;
        }// end function

        public function get readyToEquip() : EquipmentInfo
        {
            return this._readyToEquip;
        }// end function

        public function addCD() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._cellId = this._backpackObj.info.openningGridId;
            if (this._cellId == 0)
            {
                this._cellId = BackpackObj.CAPACITY;
            }
            if (this._backpackObj.info.cellTime == 0)
            {
                return;
            }
            clearTimeout(this._openTimeid);
            this._cellEndTime = this._backpackObj.info.cellTime * 1000;
            if (this._cellId != 0 || this._cellEndTime != 0)
            {
                _loc_1 = "1_" + this._cellId;
                _loc_2 = BackpackOpenCfgObj.getInstance().getCost(_loc_1);
                if (_loc_2 && _loc_2.q_time && this._cellEndTime > 0)
                {
                    this._openTimeid = setTimeout(this.endCD, this._cellEndTime);
                    CDManager.getInstance().addCD(CDTypes.BACKPACK_OPEN, this._cellEndTime, _loc_2.q_time * 1000);
                    _loc_3 = CDManager.getInstance().getCD(CDTypes.BACKPACK_OPEN);
                    this.timer = getTimer();
                }
            }
            return;
        }// end function

        public function openItemChange() : void
        {
            if (this._backpackPanel)
            {
                this._backpackPanel.openItemChange();
            }
            return;
        }// end function

        public function endCD() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            clearTimeout(this._openTimeid);
            clearTimeout(this._endCDAfterReqTimeId);
            clearTimeout(this._beforeEndCDReqTimeId);
            (this._cellId + 1);
            if (this._cellId < BackpackObj.CAPACITY)
            {
                BackpackObj.getInstance().info.openningGridId = this._cellId;
                _loc_1 = "1_" + BackpackObj.getInstance().info.openningGridId;
                _loc_2 = BackpackOpenCfgObj.getInstance().getCost(_loc_1);
                BackpackObj.getInstance().info.cellTime = _loc_2.q_time;
                BackPackControl.getInstance().addCD();
                BackPackControl.getInstance().openItemChange();
                this._endCDAfterReqTimeId = setTimeout(this.reqCellTime, 120000, BackpackObj.getInstance().info.openningGridId);
                if (BackpackObj.getInstance().info.cellTime - 10 > 5)
                {
                    this._beforeEndCDReqTimeId = setTimeout(this.reqCellTime, (BackpackObj.getInstance().info.cellTime - 10) * 1000, BackpackObj.getInstance().info.openningGridId);
                }
            }
            return;
        }// end function

        public function checkItemenough(param1:int, param2:int, param3:Function, param4:Array = null, param5:String = "") : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_6:* = BackpackObj.getInstance().getItemCount(param1);
            if (BackpackObj.getInstance().getItemCount(param1) >= param2)
            {
                if (param3 != null)
                {
                    param3.apply(this, param4);
                }
            }
            else
            {
                _loc_7 = ShopCfgObj.getInstance().getShopItemInfoFromInside(param1);
                if (_loc_7)
                {
                    if (param5 != "")
                    {
                        if (ConfirmObj.isNeedConfirm(param5))
                        {
                            this.yesToBuy(_loc_7);
                            return;
                        }
                    }
                    _loc_8 = PropUtil.getEquipNameAndColor(_loc_7.prop);
                    Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11922"), ["<font color = \'#" + _loc_8[1].toString(16) + "\'>" + _loc_8[0] + "</font>", param2]), "", [_loc_7], this.yesToBuy);
                }
                else
                {
                    throw new Error(LanguageCfgObj.getInstance().getByIndex("10342"));
                }
            }
            return;
        }// end function

        private function yesToBuy(param1:ShopItemInfo) : void
        {
            if (param1)
            {
                ShopController.getInstance().openBuyItem(param1);
            }
            return;
        }// end function

        public function checkItemCount(param1:int, param2:int, param3:Function, param4:Array = null, param5:String = "") : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_6:* = BackpackObj.getInstance().getItemCount(param1);
            if (BackpackObj.getInstance().getItemCount(param1) >= param2)
            {
                if (param3 != null)
                {
                    param3.apply(this, param4);
                }
            }
            else
            {
                _loc_7 = ShopCfgObj.getInstance().getShopItemInfoFromInside(param1);
                if (_loc_7 == null)
                {
                    throw new Error(LanguageCfgObj.getInstance().getByIndex("10342"));
                }
                _loc_6 = param2 - _loc_6;
                if (param5 != "" && !ConfirmObj.isNeedConfirm(param5))
                {
                    ShopController.getInstance().openBuyItem(_loc_7);
                }
                else
                {
                    _loc_8 = ShopUtils.isCanBuy(_loc_7, _loc_6);
                    if (_loc_8[0])
                    {
                        ShopController.getInstance().buy(_loc_7, _loc_8[1], _loc_7.npc, _loc_6);
                    }
                    else
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                }
            }
            return;
        }// end function

        public function isFullForItemModelId(param1:int) : Boolean
        {
            return this._backpackObj.isFullForItemModelId(param1);
        }// end function

        public function openCell(param1:int) : void
        {
            this._backpackprotocol.openCell(param1);
            return;
        }// end function

        public function openCellRes(param1:int) : void
        {
            this._backpackPanel.openCellRes(param1);
            BackpackObj.getInstance().checkFull();
            clearTimeout(this._endCDAfterReqTimeId);
            if (this._cellId < BackpackObj.CAPACITY)
            {
                this._endCDAfterReqTimeId = setTimeout(this.reqCellTime, 120000, BackpackObj.getInstance().info.openningGridId);
            }
            return;
        }// end function

        public function getOneKeyitems() : Array
        {
            return BackpackObj.getInstance().getOneKeyItems();
        }// end function

        public function openUI(param1:PropInfo) : void
        {
            if (param1.q_ui == 18)
            {
                ShopController.getInstance().openSupervaluePanel(param1);
            }
            else
            {
                PromptControl.getInstance().openOtherPanel(param1.q_ui);
            }
            return;
        }// end function

        public function getBackpackView() : BackPackPanel
        {
            var _loc_1:* = new BackPackPanel();
            this._backpackPanel = new BackPackPanel();
            return this._backpackPanel || _loc_1;
        }// end function

        public static function getInstance() : BackPackControl
        {
            var _loc_1:* = new BackPackControl;
            _instance = new BackPackControl;
            return _instance || _loc_1;
        }// end function

    }
}
