package com.game.guild.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import com.game.role.util.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.*;

    public class GuildServerPanel extends BaseBox
    {
        private const BASE_HEIGHT:int = 48;
        private var btnClose:BaseButton;
        private var txtPanelName:TextField;
        private var back:Sprite;
        private var serverList:List;
        private var _type:String;
        private var vecJoinServer:Vector.<ResGuildApplyAddDoingToClientMessage>;
        private var vecInviteServer:Vector.<ResGuildInviteAddDoingToClientMessage>;
        private var vecItem:Vector.<GuildServerItem>;
        public static const TYPE_JOIN:String = "guildJoin";
        public static const TYPE_INVITE:String = "guildInvite";

        public function GuildServerPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.vecJoinServer = new Vector.<ResGuildApplyAddDoingToClientMessage>;
            this.vecInviteServer = new Vector.<ResGuildInviteAddDoingToClientMessage>;
            this.vecItem = new Vector.<GuildServerItem>;
            super(param1);
            loadDisplay("res/teamServer.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("teamServerView");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            this.txtPanelName.text = param1 == TYPE_INVITE ? (LanguageCfgObj.getInstance().getByIndex("12083")) : (LanguageCfgObj.getInstance().getByIndex("12084"));
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.txtPanelName = getDisplayChildByName("txtPanelName") as TextField;
            this.back = getDisplayChildByName("back") as Sprite;
            this.serverList = new List(363, 389);
            this.serverList.move(12, 49);
            this.addChild(this.serverList);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removFromStage);
            return;
        }// end function

        protected function removFromStage(event:Event) : void
        {
            this.cleanItemList();
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            this.updateServer();
            return;
        }// end function

        private function updateServer() : void
        {
            return;
        }// end function

        public function addInfoToServer(param1:Message, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case TYPE_JOIN:
                {
                    if (!this.checkHas(param1, TYPE_JOIN))
                    {
                        this.vecJoinServer.push(param1);
                    }
                    break;
                }
                case TYPE_INVITE:
                {
                    if (!this.checkHas(param1, TYPE_INVITE))
                    {
                        this.vecInviteServer.push(param1);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.parent && param2 == this.type)
            {
                this.freshItem();
            }
            else
            {
                _loc_3 = new GuildServerIcon(param2);
                if (param1 is ResGuildInviteAddDoingToClientMessage)
                {
                    _loc_3.info = ResGuildInviteAddDoingToClientMessage(param1);
                }
                else
                {
                    _loc_3.info = ResGuildApplyAddDoingToClientMessage(param1);
                }
                _loc_3.count = 1;
                Global.popManager.addedServerToCue(_loc_3);
            }
            return;
        }// end function

        private function checkHas(param1:Message, param2:String) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param2 == TYPE_JOIN)
            {
                _loc_4 = 0;
                while (_loc_4 < this.vecJoinServer.length)
                {
                    
                    if (ResGuildApplyAddDoingToClientMessage(param1).userId.equal(ResGuildApplyAddDoingToClientMessage(this.vecJoinServer[_loc_4]).userId))
                    {
                        return true;
                    }
                    _loc_4++;
                }
                return false;
            }
            else
            {
                _loc_4 = 0;
                while (_loc_4 < this.vecInviteServer.length)
                {
                    
                    if (ResGuildInviteAddDoingToClientMessage(param1).inviteModeInfo.playerid.equal(ResGuildInviteAddDoingToClientMessage(this.vecInviteServer[_loc_4]).inviteModeInfo.playerid))
                    {
                        return true;
                    }
                    _loc_4++;
                }
            }
            return false;
        }// end function

        public function removeInfoFromServer(param1:Message, param2:String) : void
        {
            this.removeItemFromList(param1, param2);
            if (this.parent && this.type == param2)
            {
                this.freshItem();
            }
            return;
        }// end function

        private function updatePanel() : void
        {
            var callYesBack:Function;
            var callNoBack:Function;
            var info:Message;
            var str:String;
            var level:String;
            callYesBack = function (param1:Message) : void
            {
                var _loc_2:* = null;
                var _loc_3:* = null;
                if (type == GuildServerPanel.TYPE_JOIN)
                {
                    _loc_2 = param1 as ResGuildApplyAddDoingToClientMessage;
                    if (UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildAddMember(UserObj.getInstance().playerInfo.guildId, _loc_2.userId, 1);
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10857"));
                    }
                }
                else if (type == GuildServerPanel.TYPE_INVITE)
                {
                    _loc_3 = param1 as ResGuildInviteAddDoingToClientMessage;
                    GuildControl.getInstance().reqGuildAddMember(_loc_3.guildId, _loc_3.inviteModeInfo.playerid, 1);
                }
                return;
            }// end function
            ;
            callNoBack = function (... args) : void
            {
                args = null;
                var _loc_3:* = null;
                if (type == GuildServerPanel.TYPE_JOIN)
                {
                    args = info as ResGuildApplyAddDoingToClientMessage;
                    if (UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildAddMember(UserObj.getInstance().playerInfo.guildId, args.userId, 0);
                    }
                    else
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10857"));
                    }
                }
                else if (type == GuildServerPanel.TYPE_INVITE)
                {
                    _loc_3 = info as ResGuildInviteAddDoingToClientMessage;
                    GuildControl.getInstance().reqGuildAddMember(_loc_3.guildId, _loc_3.inviteModeInfo.playerid, 0);
                }
                return;
            }// end function
            ;
            var count:* = this.type == TYPE_JOIN ? (this.vecJoinServer.length) : (this.vecInviteServer.length);
            if (count == 1)
            {
                str;
                if (this.type == TYPE_JOIN)
                {
                    info = this.vecJoinServer.pop();
                    level = RoleLevelUtil.getMasterLevel(ResGuildApplyAddDoingToClientMessage(info).applyLevel);
                    str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12085"), [ResGuildApplyAddDoingToClientMessage(info).applyName, level]);
                }
                else
                {
                    info = this.vecInviteServer.pop();
                    level = RoleLevelUtil.getMasterLevel(ResGuildInviteAddDoingToClientMessage(info).inviteLevel);
                    str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12086"), [ResGuildInviteAddDoingToClientMessage(info).inviteName, level, ResGuildInviteAddDoingToClientMessage(info).guildName]);
                }
                Global.popManager.cue(str, "", [info], callYesBack, callNoBack, 2, [LanguageCfgObj.getInstance().getByIndex("12087"), LanguageCfgObj.getInstance().getByIndex("11365")]);
            }
            else
            {
                this.freshItem();
            }
            return;
        }// end function

        private function freshItem() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = this.type == TYPE_JOIN ? (this.vecJoinServer.length) : (this.vecInviteServer.length);
            this.cleanItemList();
            if (this.type == TYPE_JOIN)
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = new GuildServerItem();
                    _loc_3.info = this.vecJoinServer[_loc_2];
                    this.vecItem.push(_loc_3);
                    this.serverList.add(_loc_3);
                    _loc_2++;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    _loc_3 = new GuildServerItem();
                    _loc_3.info = this.vecInviteServer[_loc_2];
                    this.vecItem.push(_loc_3);
                    this.serverList.add(_loc_3);
                    _loc_2++;
                }
            }
            if (this.vecItem.length <= 0 && this.parent)
            {
                this.close();
            }
            return;
        }// end function

        private function removeItemFromList(param1:Message, param2:String) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.type == TYPE_JOIN)
            {
                _loc_4 = this.vecJoinServer.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (this.vecJoinServer[_loc_5] == param1)
                    {
                        _loc_3 = _loc_5;
                        break;
                    }
                    _loc_5++;
                }
                this.vecJoinServer.splice(_loc_3, 1);
            }
            else
            {
                _loc_4 = this.vecInviteServer.length;
                _loc_5 = 0;
                while (_loc_5 < _loc_4)
                {
                    
                    if (this.vecInviteServer[_loc_5] == param1)
                    {
                        _loc_3 = _loc_5;
                        break;
                    }
                    _loc_5++;
                }
                this.vecInviteServer.splice(_loc_3, 1);
            }
            this.freshItem();
            return;
        }// end function

        override public function open() : void
        {
            this.updatePanel();
            var _loc_1:* = this.type == TYPE_JOIN ? (this.vecJoinServer.length) : (this.vecInviteServer.length);
            if (_loc_1 > 1)
            {
                super.open();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.cleanItemList();
            this.cleaServerInfo();
            return;
        }// end function

        private function cleanItemList() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            _loc_1 = this.vecItem.length;
            while (this.vecItem.length > 0)
            {
                
                _loc_3 = this.vecItem.pop();
                if (_loc_3.parent)
                {
                    _loc_3.parent.removeChild(_loc_3);
                }
            }
            this.serverList.reset();
            return;
        }// end function

        private function cleaServerInfo() : void
        {
            while (this.vecInviteServer.length > 0)
            {
                
                this.vecInviteServer.pop();
            }
            while (this.vecJoinServer.length > 0)
            {
                
                this.vecJoinServer.pop();
            }
            return;
        }// end function

    }
}
