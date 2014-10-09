package com.game.team.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.game.role.util.*;
    import com.game.team.control.*;
    import com.game.team.message.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.*;

    public class TeamServerPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var txtPanelName:TextField;
        private var back:Sprite;
        private var serverList:List;
        private var _type:String;
        private var vecJoinServer:Vector.<ResApplyClientMessage>;
        private var vecInviteServer:Vector.<ResInviteClientMessage>;
        private var vecItem:Vector.<TeamServerItem>;
        public static const TYPE_JOIN:String = "teamJoin";
        public static const TYPE_INVITE:String = "teamInvite";

        public function TeamServerPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.vecJoinServer = new Vector.<ResApplyClientMessage>;
            this.vecInviteServer = new Vector.<ResInviteClientMessage>;
            this.vecItem = new Vector.<TeamServerItem>;
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
            this.txtPanelName.htmlText = param1 == TYPE_INVITE ? ("<b>" + LanguageCfgObj.getInstance().getByIndex("12265") + "</b>") : ("<b>" + LanguageCfgObj.getInstance().getByIndex("12266") + "</b>");
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
                _loc_3 = new TeamServerIcon(param2);
                if (param1 is ResInviteClientMessage)
                {
                    _loc_3.info = ResInviteClientMessage(param1).captaininfo;
                }
                else
                {
                    _loc_3.info = ResApplyClientMessage(param1).newmemberinfo;
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
                    
                    if (ResApplyClientMessage(param1).newmemberinfo.memberid.equal(ResApplyClientMessage(this.vecJoinServer[_loc_4]).newmemberinfo.memberid))
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
                    
                    if (ResInviteClientMessage(param1).captaininfo.memberid.equal(ResInviteClientMessage(this.vecInviteServer[_loc_4]).captaininfo.memberid))
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
            var teamId:long;
            callYesBack = function (param1:Message) : void
            {
                var _loc_2:* = null;
                var _loc_3:* = null;
                if (type == TeamServerPanel.TYPE_JOIN)
                {
                    _loc_2 = param1 as ResApplyClientMessage;
                    TeamControl.getInstance().reqApplyGameSelect(_loc_2.teamid, _loc_2.newmemberinfo.memberid, true);
                }
                else if (type == TeamServerPanel.TYPE_INVITE)
                {
                    _loc_3 = param1 as ResInviteClientMessage;
                    TeamControl.getInstance().reqInviteGameSelect(_loc_3.teamid, _loc_3.captaininfo.memberid, true);
                }
                return;
            }// end function
            ;
            callNoBack = function (... args) : void
            {
                args = null;
                var _loc_3:* = null;
                if (type == TeamServerPanel.TYPE_JOIN)
                {
                    args = info as ResApplyClientMessage;
                    TeamControl.getInstance().reqApplyGameSelect(args.teamid, args.newmemberinfo.memberid, false);
                }
                else if (type == TeamServerPanel.TYPE_INVITE)
                {
                    _loc_3 = info as ResInviteClientMessage;
                    TeamControl.getInstance().reqInviteGameSelect(_loc_3.teamid, _loc_3.captaininfo.memberid, false);
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
                    level = RoleLevelUtil.getMasterLevel(ResApplyClientMessage(info).newmemberinfo.memberlevel);
                    str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12267"), [ResApplyClientMessage(info).newmemberinfo.membername, level, RoleInfo.getJobName(ResApplyClientMessage(info).newmemberinfo.memberJob)]);
                }
                else
                {
                    info = this.vecInviteServer.pop();
                    level = RoleLevelUtil.getMasterLevel(ResInviteClientMessage(info).captaininfo.memberlevel);
                    str = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12267"), [ResInviteClientMessage(info).captaininfo.membername, level, RoleInfo.getJobName(ResInviteClientMessage(info).captaininfo.memberJob)]);
                    teamId = TeamModel.getInstance().teamId;
                    if (teamId && !(teamId.high == 0 && teamId.low == 0))
                    {
                        str = str + LanguageCfgObj.getInstance().getByIndex("12269");
                    }
                    str = str + ("<br>" + LanguageCfgObj.getInstance().getByIndex("12270"));
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
                    
                    _loc_3 = new TeamServerItem();
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
                    
                    _loc_3 = new TeamServerItem();
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
