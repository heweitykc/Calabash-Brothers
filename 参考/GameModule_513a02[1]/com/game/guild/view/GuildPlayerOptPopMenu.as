package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import com.game.player.control.*;
    import com.game.team.control.*;
    import com.game.transactions.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.desktop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class GuildPlayerOptPopMenu extends BaseSprite
    {
        private var _hbox:HBox;
        private var _backImage:Sprite;
        private var _info:RoleInfo;
        private var _operGuildMenu:Array;
        private var _curItems:Array;
        private static const MOUSE_ADJUST:uint = 25;
        public static const GUILD:int = 3;
        private static const CHAT:String = "chat";
        private static const FRIEND:String = "friend";
        private static const COPYNAME:String = "copyname";
        private static const LOOK:String = "info";
        private static const TEAM:String = "team";
        private static const TRANSACTION:String = "transaction";
        private static const DEPOT:String = "depot";
        private static const APPOINT:String = "appoint";
        private static const INFO:String = "info";
        private static const EXCHANGE:String = "exchange";
        private static const KICKOUT:String = "kickout";
        private static var _instance:GuildPlayerOptPopMenu;

        public function GuildPlayerOptPopMenu()
        {
            this._operGuildMenu = [{label:LanguageCfgObj.getInstance().getByIndex("11690"), data:"appoint"}, {label:LanguageCfgObj.getInstance().getByIndex("11691"), data:"chat"}, {label:LanguageCfgObj.getInstance().getByIndex("11692"), data:"info"}, {label:LanguageCfgObj.getInstance().getByIndex("11693"), data:"team"}, {label:LanguageCfgObj.getInstance().getByIndex("11694"), data:"exchange"}, {label:LanguageCfgObj.getInstance().getByIndex("11695"), data:"kickout"}];
            this._backImage = ToolKit.getNew("menu_bg");
            addChild(this._backImage);
            this._hbox = new HBox();
            this._hbox.intervalY = 2;
            addChild(this._hbox);
            return;
        }// end function

        public function show(param1:RoleInfo, param2:DisplayObjectContainer, param3:int = 1) : void
        {
            var _loc_6:* = 0;
            var _loc_8:* = null;
            this._info = param1;
            var _loc_4:* = false;
            switch(param3)
            {
                case GUILD:
                {
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1 || GuildData.getInstance().myMemberInfo.guildPowerLevel == 2)
                    {
                        this._curItems = this._operGuildMenu;
                        _loc_4 = true;
                    }
                    else
                    {
                        this._curItems = this._operGuildMenu.slice(1, (this._operGuildMenu.length - 1));
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._hbox.reset();
            var _loc_5:* = this._curItems.length - this._hbox.length;
            if (this._curItems.length - this._hbox.length > 0)
            {
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    if (_loc_4 && _loc_6 == 0)
                    {
                        _loc_8 = new BaseButton(ToolKit.getNew("btn_guildoperation"));
                    }
                    else
                    {
                        _loc_8 = new BaseButton(ObjectPool.CheckOutByName("playermenu_btn"));
                    }
                    _loc_8.addEventListener(MouseEvent.MOUSE_OVER, this.__over);
                    _loc_8.addEventListener(MouseEvent.MOUSE_OUT, this.__out);
                    this._hbox.add(_loc_8);
                    _loc_6++;
                }
            }
            else
            {
                _loc_5 = -_loc_5;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_8 = this._hbox.getContent(this._hbox.length - _loc_5 + _loc_6);
                    _loc_8.removeEvtListener(MouseEvent.CLICK, this.__btnClick);
                    this._hbox.remove(_loc_8);
                    _loc_6++;
                }
            }
            _loc_6 = 0;
            while (_loc_6 < this._hbox.length)
            {
                
                _loc_8 = this._hbox.getContent(_loc_6);
                _loc_8.setText(this._curItems[_loc_6].label);
                _loc_8.name = this._curItems[_loc_6].data;
                _loc_8.addEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                _loc_6++;
            }
            this._backImage.width = this._hbox.width;
            this._backImage.height = this._hbox.height + 11;
            if (_loc_4)
            {
                this._backImage.y = this._hbox.getContent(0).height;
                this._backImage.height = this._hbox.height - this._hbox.getContent(0).height + 4;
                this._hbox.y = 0;
            }
            else
            {
                this._backImage.y = 0;
                this._hbox.y = 3;
            }
            _w = this._hbox.width;
            _h = this._hbox.height - this._hbox.getContent(0).height + 4;
            var _loc_7:* = this.getPoints(param2);
            x = _loc_7.x;
            y = _loc_7.y;
            param2.addChild(this);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false, 0, true);
            return;
        }// end function

        private function __stageDown(event:MouseEvent) : void
        {
            this.parent.removeChild(this);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            this.finalize();
            return;
        }// end function

        public function getPoints(param1:DisplayObjectContainer) : Point
        {
            var _loc_2:* = new Point(param1.mouseX, param1.mouseY);
            var _loc_3:* = param1.localToGlobal(new Point(_loc_2.x, _loc_2.y));
            if (_loc_3.x + this._w > FrameworkGlobal.stage.stageWidth)
            {
                _loc_2.x = _loc_2.x - this._w;
            }
            if (_loc_3.y + this._h > FrameworkGlobal.stage.stageHeight)
            {
                _loc_2.y = _loc_2.y - this._h;
            }
            return _loc_2;
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

        private function __btnClick(event:MouseEvent) : void
        {
            var evt:* = event;
            switch(evt.target.name)
            {
                case COPYNAME:
                {
                    Clipboard.generalClipboard.clear();
                    Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._info.name);
                    break;
                }
                case CHAT:
                {
                    ChatController.getInstance().toRole(this._info.name);
                    break;
                }
                case LOOK:
                {
                    this.lookOtherPlayer(this._info.personId);
                    break;
                }
                case TEAM:
                {
                    this.inviteToTeam(this._info.personId);
                    break;
                }
                case TRANSACTION:
                {
                    TransactionControl.getInstance().launchTransactions(this._info.personId);
                    break;
                }
                case DEPOT:
                {
                    break;
                }
                case APPOINT:
                {
                    GuildControl.getInstance().openGuildAppointPanel();
                    break;
                }
                case INFO:
                {
                    PlayerControl.getInstance().reqForPlayer(this._info.personId);
                    break;
                }
                case EXCHANGE:
                {
                    break;
                }
                case KICKOUT:
                {
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("11657"), "", null, function () : void
            {
                GuildControl.getInstance().reqGuildDeleteMember(UserObj.getInstance().playerInfo.guildId, _info.personId);
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10366"));
                    break;
                }
                default:
                {
                    break;
                }
            }
            evt.stopPropagation();
            if (parent)
            {
                parent.removeChild(this);
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            this.finalize();
            return;
        }// end function

        private function inviteToTeam(param1:long) : void
        {
            TeamControl.getInstance().teamInvitePlayer(param1);
            return;
        }// end function

        public function lookOtherPlayer(param1:long) : void
        {
            PlayerControl.getInstance().reqForPlayer(param1);
            return;
        }// end function

        override public function finalize() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._hbox.length)
            {
                
                _loc_2 = this._hbox.getContent(_loc_1);
                _loc_2.removeEvtListener(MouseEvent.MOUSE_DOWN, this.__btnClick);
                _loc_1++;
            }
            return;
        }// end function

        public static function getInstance() : GuildPlayerOptPopMenu
        {
            var _loc_1:* = new GuildPlayerOptPopMenu;
            _instance = new GuildPlayerOptPopMenu;
            return _instance || _loc_1;
        }// end function

    }
}
