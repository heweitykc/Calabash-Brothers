package com.game.backpack.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.backpack.control.*;
    import com.game.chat.control.*;
    import com.game.equipstreng.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.guild.control.*;
    import com.game.player.control.*;
    import com.game.protect.control.*;
    import com.game.team.control.*;
    import com.game.transactions.control.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ItemPopMenu extends BaseSprite
    {
        private var _backImage:Sprite;
        private var _items:Vector.<BaseButton>;
        private var _hbox:HBox;
        private var _backpackControl:BackPackControl;
        private var _operItems:Array;
        private var _oper:Array;
        private var _artifactExtractMenuItem:Object;
        private var _operGuildMenu:Array;
        private var _operTreasureItemMenu1:Array;
        private var _operTreasureItemMenu2:Array;
        private var _zhuZaoItemMenu1:Array;
        private var _roleInfo:RoleInfo;
        private var _info:PropInfo;
        private var _obj:Object;
        public static const STRENG:int = 1;
        public static const GUILD:int = 1;
        public static const TREASURE1:int = 2;
        public static const TREASURE2:int = 3;
        public static const ZHUZAO1:int = 4;
        private static const USE:String = "use";
        private static const USEBATCH:String = "useBatch";
        private static const LINK:String = "link";
        private static const SELL:String = "sell";
        private static const TAKE_OFF:String = "takeoff";
        private static const EQUIP:String = "equip";
        private static const STRENGTH:String = "streng";
        private static const APPOINT:String = "appoint";
        private static const CHAT:String = "chat";
        private static const SPILT:String = "spilt";
        private static const LOCK:String = "lock";
        private static const UNLOCK:String = "unlock";
        private static const INFO:String = "info";
        private static const DEPOT:String = "depot";
        private static const TEAM:String = "team";
        private static const EXCHANGE:String = "exchange";
        private static const FRIEND:String = "friend";
        private static const KICKOUT:String = "kickout";
        private static const TREASURE_PACK:String = "treasurePack";
        private static const TREASURE_USE:String = "treasureUse";
        public static const ZHUZAO_PICK:String = "ZHUZAO_PICK";
        public static const ZHUZAO_SELL:String = "ZHUZAO_SELL";
        public static const ZHUZAO_DECOMPOSE:String = "ZHUZAO_DECOMPOSE";
        public static const ARTIFACT_EXTRACT:String = "ARTIFACT_EXTRACT";
        private static var _instance:ItemPopMenu;

        public function ItemPopMenu()
        {
            this._items = new Vector.<BaseButton>;
            this._oper = [{label:LanguageCfgObj.getInstance().getByIndex("11658"), data:USE}, {label:LanguageCfgObj.getInstance().getByIndex("11659"), data:EQUIP}, {label:LanguageCfgObj.getInstance().getByIndex("11660"), data:TAKE_OFF}, {label:LanguageCfgObj.getInstance().getByIndex("11661"), data:LINK}, {label:LanguageCfgObj.getInstance().getByIndex("11662"), data:USEBATCH}, {label:LanguageCfgObj.getInstance().getByIndex("11663"), data:SELL}, {label:LanguageCfgObj.getInstance().getByIndex("11664"), data:STRENGTH}, {label:LanguageCfgObj.getInstance().getByIndex("11665"), data:SPILT}, {label:LanguageCfgObj.getInstance().getByIndex("10005", "lang_highlock"), data:LOCK}, {label:LanguageCfgObj.getInstance().getByIndex("10006", "lang_highlock"), data:UNLOCK}];
            this._artifactExtractMenuItem = {label:LanguageCfgObj.getInstance().getByIndex("11666"), data:ARTIFACT_EXTRACT};
            this._operGuildMenu = [{label:LanguageCfgObj.getInstance().getByIndex("11667"), data:"chat"}, {label:LanguageCfgObj.getInstance().getByIndex("11668"), data:"info"}, {label:LanguageCfgObj.getInstance().getByIndex("11669"), data:"team"}, {label:LanguageCfgObj.getInstance().getByIndex("11670"), data:"exchange"}];
            this._operTreasureItemMenu1 = [{label:LanguageCfgObj.getInstance().getByIndex("11671"), data:TREASURE_USE}, {label:LanguageCfgObj.getInstance().getByIndex("11672"), data:TREASURE_PACK}];
            this._operTreasureItemMenu2 = [{label:LanguageCfgObj.getInstance().getByIndex("11672"), data:TREASURE_PACK}];
            this._zhuZaoItemMenu1 = [{label:LanguageCfgObj.getInstance().getByIndex("11673"), data:ZHUZAO_PICK}, {label:LanguageCfgObj.getInstance().getByIndex("11674"), data:LINK}, {label:LanguageCfgObj.getInstance().getByIndex("11675"), data:ZHUZAO_SELL}];
            this._backImage = ToolKit.getNew("menu_bg");
            addChild(this._backImage);
            this._hbox = new HBox();
            this._hbox.intervalY = 2;
            this._hbox.x = 3;
            this._hbox.y = 3;
            addChild(this._hbox);
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function show(param1:PropInfo, param2:DisplayObject, param3:int = 0, param4:int = 0, param5:int = 0, param6:RoleInfo = null, param7 = null) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_11:* = null;
            this._info = param1;
            this._roleInfo = param6;
            this._operItems = this.getOperItem(param5);
            this._obj = param7;
            _loc_8 = this._hbox.length;
            _loc_9 = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_11 = this._hbox.getContent(this._hbox.length - _loc_8 + _loc_9);
                _loc_11.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                this._hbox.remove(_loc_11);
                _loc_9++;
            }
            _loc_8 = this._operItems.length;
            if (_loc_8 > 0)
            {
                _loc_9 = 0;
                while (_loc_9 < _loc_8)
                {
                    
                    if (this._operItems[_loc_9] == this._oper[8] || this._operItems[_loc_9] == this._oper[9])
                    {
                        _loc_11 = new BaseButton(ObjectPool.CheckOutByName("highLockmenu_btn"));
                    }
                    else
                    {
                        _loc_11 = new BaseButton(ObjectPool.CheckOutByName("menu_btn"));
                    }
                    this._hbox.add(_loc_11);
                    _loc_9++;
                }
            }
            _loc_9 = 0;
            while (_loc_9 < this._hbox.length)
            {
                
                _loc_11 = this._hbox.getContent(_loc_9);
                _loc_11.setText(this._operItems[_loc_9].label);
                _loc_11.width = this._hbox.width;
                _loc_11.name = this._operItems[_loc_9].data;
                _loc_11.addEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                _loc_11.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
                _loc_11.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
                _loc_9++;
            }
            this._backImage.width = this._hbox.width + 6;
            this._backImage.height = this._hbox.height + 11;
            _w = this._hbox.width + 4;
            _h = this._hbox.height + 4;
            var _loc_10:* = this.getPoints(param2, param3, param4);
            x = _loc_10.x;
            y = _loc_10.y;
            FrameworkGlobal.stage.addChild(this);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false, 0, true);
            return;
        }// end function

        private function __stageDown(event:MouseEvent) : void
        {
            if (parent)
            {
                this.parent.removeChild(this);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            this.finalize();
            return;
        }// end function

        public function getPoints(param1:DisplayObject, param2:int = 0, param3:int = 0) : Point
        {
            var _loc_5:* = null;
            if (param2 == 0 && param3 == 0)
            {
                _loc_5 = new Point(param1.mouseX, param1.mouseY);
            }
            else
            {
                _loc_5 = new Point(param2, param3);
            }
            var _loc_4:* = param1.localToGlobal(new Point(_loc_5.x, _loc_5.y));
            if (_loc_4.x + this._w > FrameworkGlobal.stage.stageWidth)
            {
                _loc_4.x = _loc_4.x - this._w;
            }
            if (_loc_4.y + this._h > FrameworkGlobal.stage.stageHeight)
            {
                _loc_4.y = _loc_4.y - this._h;
            }
            return _loc_4;
        }// end function

        private function getOperItem(param1:int = 0) : Array
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            switch(param1)
            {
                case GUILD:
                {
                    return this._operGuildMenu;
                }
                case TREASURE1:
                {
                    return this._operTreasureItemMenu1;
                }
                case TREASURE2:
                {
                    return this._operTreasureItemMenu2;
                }
                case ZHUZAO1:
                {
                    return this._zhuZaoItemMenu1;
                }
                default:
                {
                    break;
                }
            }
            if (this._info is EquipmentInfo)
            {
                switch(param1)
                {
                    case STRENG:
                    {
                        return [this._oper[6]];
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2 = this._info as EquipmentInfo;
                if (_loc_2.pos == 0)
                {
                    if (_loc_2.lockedEndTime)
                    {
                        _loc_3 = _loc_2.lockedEndTime;
                        if (_loc_3 >= 0)
                        {
                            return [this._oper[1], this._oper[3], this._oper[8]];
                        }
                        if (_loc_3 == -1)
                        {
                            return [this._oper[1], this._oper[3], this._oper[9]];
                        }
                    }
                    else if (!_loc_2.isbind)
                    {
                        return [this._oper[1], this._oper[3], this._oper[8]];
                    }
                    return this.tryAddArtifactExtractMenuItem([this._oper[1], this._oper[3]]);
                }
                else if (_loc_2.pos > 0)
                {
                    return [this._oper[2], this._oper[3]];
                }
            }
            else if (this._info is PropInfo)
            {
                _loc_4 = [];
                _loc_4.push(this._oper[0]);
                _loc_4.push(this._oper[3]);
                if (this._info.num > 1 && !this._info.isHighLocked)
                {
                    _loc_4.push(this._oper[7]);
                }
                if ((this._info as PropInfo).q_whether_batch == 1)
                {
                    _loc_4.push(this._oper[4]);
                }
                if (this._info.lockedEndTime)
                {
                    _loc_3 = this._info.lockedEndTime;
                    if (_loc_3 >= 0)
                    {
                        _loc_4.push(this._oper[8]);
                    }
                    else if (_loc_3 == -1)
                    {
                        _loc_4.push(this._oper[9]);
                    }
                }
                else if (!this._info.isbind)
                {
                    _loc_4.push(this._oper[8]);
                }
                return this.tryAddArtifactExtractMenuItem(_loc_4);
            }
            return [];
        }// end function

        private function tryAddArtifactExtractMenuItem(param1:Array) : Array
        {
            return param1;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            var evt:* = event;
            this._backpackControl = BackPackControl.getInstance();
            switch(evt.target.name)
            {
                case USE:
                {
                    this._backpackControl.useItem(this._info, 1);
                    break;
                }
                case USEBATCH:
                {
                    this._backpackControl.useItems(this._info);
                    break;
                }
                case LINK:
                {
                    this._backpackControl.linkToChat(this._info);
                    break;
                }
                case SELL:
                {
                    this._backpackControl.soldItem(this._info);
                    break;
                }
                case TAKE_OFF:
                {
                    this._backpackControl.takeOff(this._info.itemId);
                    break;
                }
                case EQUIP:
                {
                    this._backpackControl.equip(this._info as EquipmentInfo);
                    break;
                }
                case STRENGTH:
                {
                    EquipForgeControl.getInstance().__selectItem();
                    break;
                }
                case APPOINT:
                {
                    GuildControl.getInstance().openGuildAppointPanel();
                    break;
                }
                case CHAT:
                {
                    ChatController.getInstance().toRole(this._roleInfo.name);
                    break;
                }
                case INFO:
                {
                    PlayerControl.getInstance().reqForPlayer(this._roleInfo.personId);
                    break;
                }
                case DEPOT:
                {
                    break;
                }
                case TEAM:
                {
                    TeamControl.getInstance().teamInvitePlayer(this._roleInfo.personId);
                    break;
                }
                case EXCHANGE:
                {
                    TransactionControl.getInstance().launchTransactions(this._roleInfo.personId);
                    break;
                }
                case FRIEND:
                {
                    break;
                }
                case KICKOUT:
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11657"), "", null, function () : void
            {
                GuildControl.getInstance().reqGuildDeleteMember(UserObj.getInstance().playerInfo.guildId, _roleInfo.personId);
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10366"));
                    break;
                }
                case TREASURE_PACK:
                {
                    GoldRaffleControl.getInstance().reqGoldRaffleBoxUseItemToServer(this._obj, 2);
                    break;
                }
                case TREASURE_USE:
                {
                    GoldRaffleControl.getInstance().reqGoldRaffleBoxUseItemToServer(this._obj, 1);
                    break;
                }
                case ZHUZAO_PICK:
                {
                    break;
                }
                case ZHUZAO_SELL:
                {
                    break;
                }
                case SPILT:
                {
                    BackPackControl.getInstance().openSpilt(this._info);
                    break;
                }
                case LOCK:
                {
                    ProtectControl.getInstance().info = this._info;
                    ProtectControl.getInstance().showHighLockedTips();
                    break;
                }
                case UNLOCK:
                {
                    ProtectControl.getInstance().highUnlock(this._info.itemId);
                    break;
                }
                case ARTIFACT_EXTRACT:
                {
                    ArtifactControl.getInstance().extractItem(this._info);
                    break;
                }
                default:
                {
                    break;
                }
            }
            FrameworkGlobal.sendMsg(new ItemPopMenuEvent(ItemPopMenuEvent.SELECT_MENU, evt.target.name));
            evt.stopPropagation();
            if (parent)
            {
                parent.removeChild(this);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.CLICK, this.__stageDown, false);
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            event.currentTarget.labelTxt.textColor = 16766079;
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            event.currentTarget.labelTxt.textColor = 8417369;
            return;
        }// end function

        override public function finalize() : void
        {
            var _loc_2:* = null;
            this._info = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._hbox.length)
            {
                
                _loc_2 = this._hbox.getContent(_loc_1);
                _loc_2.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
                _loc_1++;
            }
            return;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public static function get instance() : ItemPopMenu
        {
            var _loc_1:* = new ItemPopMenu;
            _instance = new ItemPopMenu;
            return _instance || _loc_1;
        }// end function

    }
}
