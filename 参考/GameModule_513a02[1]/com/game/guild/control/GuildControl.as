package com.game.guild.control
{
    import com.*;
    import com.game.clickstream.*;
    import com.game.country.control.*;
    import com.game.guild.bean.*;
    import com.game.guild.chat.*;
    import com.game.guild.events.*;
    import com.game.guild.message.*;
    import com.game.guild.model.*;
    import com.game.guild.protocol.*;
    import com.game.guild.view.*;
    import com.game.operationpanel.control.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.platform.*;
    import flash.events.*;

    public class GuildControl extends Object
    {
        private var _guildCreatBox:GuildCreatBox;
        private var _guildCreatPannel:GuildCreatPannel;
        private var _guildBox:GuildBox;
        private var _guildAppointPanel:GuildAppointPanel;
        private var _guildBannerChangeNamePanel:GuildBannerChangeNamePanel;
        private var _guildBannerChangeLevelPanel:GuildBannerChangeLevelPanel;
        private var _guildBannerChangeIconPanel:GuildBannerChangeIconPanel;
        private var _guildChatBox:GuildChatBox;
        private var _guildChangeBullet:GuildChangeBullet;
        private var _guildServerPanel:GuildServerPanel;
        private var _protocol:GuildProtocol;
        private var _groupArr:LoopArray;
        private static var _instance:GuildControl;

        public function GuildControl()
        {
            this._groupArr = new LoopArray(25);
            this._protocol = new GuildProtocol();
            return;
        }// end function

        public function get groupArr() : LoopArray
        {
            return this._groupArr;
        }// end function

        public function set groupArr(param1:LoopArray) : void
        {
            this._groupArr = param1;
            return;
        }// end function

        public function get guildCreatBox() : GuildCreatBox
        {
            return this._guildCreatBox;
        }// end function

        public function get guildCreatPannel() : GuildCreatPannel
        {
            return this._guildCreatPannel;
        }// end function

        public function get guildBox() : GuildBox
        {
            return this._guildBox;
        }// end function

        public function get guildAppointPanel() : GuildAppointPanel
        {
            return this._guildAppointPanel;
        }// end function

        public function get guildBannerChangeNamePanel() : GuildBannerChangeNamePanel
        {
            return this._guildBannerChangeNamePanel;
        }// end function

        public function get guildBannerChangeLevelPanel() : GuildBannerChangeLevelPanel
        {
            return this._guildBannerChangeLevelPanel;
        }// end function

        public function get guildBannerChangeIconPanel() : GuildBannerChangeIconPanel
        {
            return this._guildBannerChangeIconPanel;
        }// end function

        public function get guildChatBox() : GuildChatBox
        {
            return this._guildChatBox;
        }// end function

        public function openGuildCreatBox() : void
        {
            if (!this._guildCreatBox)
            {
                this._guildCreatBox = new GuildCreatBox();
                Global.popManager.addPop(this._guildCreatBox);
            }
            if (!this._guildCreatBox.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_ZhanMeng);
            }
            this._guildCreatBox.openOrClose();
            return;
        }// end function

        public function openGuildCreatPanel() : void
        {
            if (!this._guildCreatPannel)
            {
                this._guildCreatPannel = new GuildCreatPannel();
                Global.popManager.addPop(this._guildCreatPannel);
            }
            if (!this._guildCreatPannel.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_ZhanMeng);
            }
            this._guildCreatPannel.openOrClose();
            return;
        }// end function

        public function openGuildBox() : void
        {
            if (!this._guildBox)
            {
                this._guildBox = new GuildBox();
                Global.popManager.addPop(this._guildBox);
            }
            this._guildBox.openOrClose();
            return;
        }// end function

        public function openGuildAppointPanel() : void
        {
            if (!this._guildAppointPanel)
            {
                this._guildAppointPanel = new GuildAppointPanel();
                Global.popManager.addPop(this._guildAppointPanel);
            }
            this._guildAppointPanel.openOrClose();
            return;
        }// end function

        public function openGuildBannerChangeNamePanel(param1:String) : void
        {
            if (!this._guildBannerChangeNamePanel)
            {
                this._guildBannerChangeNamePanel = new GuildBannerChangeNamePanel();
                Global.popManager.addPop(this._guildBannerChangeNamePanel);
            }
            this._guildBannerChangeNamePanel.newName = param1;
            this._guildBannerChangeNamePanel.openOrClose();
            return;
        }// end function

        public function openGuildBannerChangeLevelPanel() : void
        {
            if (!this._guildBannerChangeLevelPanel)
            {
                this._guildBannerChangeLevelPanel = new GuildBannerChangeLevelPanel();
                Global.popManager.addPop(this._guildBannerChangeLevelPanel);
            }
            this._guildBannerChangeLevelPanel.openOrClose();
            return;
        }// end function

        public function openGuildBannerChangeIconPanel(param1:int) : void
        {
            if (!this._guildBannerChangeIconPanel)
            {
                this._guildBannerChangeIconPanel = new GuildBannerChangeIconPanel();
                Global.popManager.addPop(this._guildBannerChangeIconPanel);
            }
            this._guildBannerChangeIconPanel.curBannerIcon = param1;
            this._guildBannerChangeIconPanel.openOrClose();
            return;
        }// end function

        public function openGuildChatBox() : void
        {
            if (!this._guildChatBox)
            {
                this._guildChatBox = new GuildChatBox();
                Global.popManager.addPop(this._guildChatBox);
            }
            this._guildChatBox.openOrClose();
            return;
        }// end function

        public function acceptChat(param1:ChatInfo) : void
        {
            this._groupArr.push(param1);
            if (this._guildChatBox && this._guildChatBox.isOpen)
            {
                this._guildChatBox.addOutTxt(param1);
            }
            return;
        }// end function

        public function addToFace(param1:String) : void
        {
            if (this._guildChatBox && this._guildChatBox.isOpen)
            {
                this._guildChatBox.addFace(param1);
            }
            return;
        }// end function

        public function isGuildChatBoxOpen() : Boolean
        {
            if (this._guildChatBox && this._guildChatBox.isOpen)
            {
                return true;
            }
            return false;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            if (this._guildChatBox && this._guildChatBox.isOpen)
            {
                this._guildChatBox.linkToChat(param1);
            }
            return;
        }// end function

        public function openGuildChangeBullet() : void
        {
            if (!this._guildChangeBullet)
            {
                this._guildChangeBullet = new GuildChangeBullet();
                Global.popManager.addPop(this._guildChangeBullet);
            }
            this._guildChangeBullet.openOrClose();
            return;
        }// end function

        public function get guildServerPanel() : GuildServerPanel
        {
            if (!this._guildServerPanel)
            {
                this._guildServerPanel = new GuildServerPanel();
                Global.popManager.addPop(this._guildServerPanel);
            }
            return this._guildServerPanel;
        }// end function

        public function openGuildServerPanel(param1:String) : void
        {
            this._guildServerPanel.type = param1;
            this._guildServerPanel.open();
            return;
        }// end function

        public function reqCreateGuild(param1:String, param2:String, param3:int) : void
        {
            this._protocol.reqCreateGuild(param1, param2, param3);
            return;
        }// end function

        public function resCreateGuildHandler(param1:ResGuildCreateToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                if (this.guildCreatBox.isOpen)
                {
                    this.guildCreatBox.close();
                }
                if (this.guildCreatPannel.isOpen)
                {
                    this.guildCreatPannel.close();
                }
                this.openGuildBox();
                if (this.guildBox.btn)
                {
                    this.guildBox.btn.dispatchEvt(new MouseEvent(MouseEvent.CLICK));
                }
            }
            return;
        }// end function

        public function resAloneGuildInfoHandler(param1:ResGuildAloneGuildInfoToClientMessage) : void
        {
            var _loc_2:* = param1.notifyType;
            GuildData.getInstance().guildInfo = param1.guildInfo;
            switch(_loc_2)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    GuildData.getInstance().guildInfo = null;
                    GuildData.getInstance().memberInfo = null;
                    GuildData.getInstance().memberList = null;
                    UserObj.getInstance().playerInfo.guildId = null;
                    if (this.guildBox && this.guildBox.isOpen)
                    {
                        this.guildBox.close();
                    }
                    if (this._guildChatBox && this._guildChatBox.isOpen)
                    {
                        this._guildChatBox.close();
                    }
                    OperationPanelControl.getInstance().showOrHideGuildChatIcon(false);
                    break;
                }
                case 4:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function resAloneMemberInfoHandler(param1:ResGuildAloneMemberInfoToClientMessage) : void
        {
            var _loc_2:* = param1.notifyType;
            GuildData.getInstance().memberInfo = param1.memberInfo;
            switch(_loc_2)
            {
                case 0:
                {
                    GuildData.getInstance().memberList = new Vector.<MemberInfo>;
                    GuildData.getInstance().memberList.push(GuildData.getInstance().memberInfo);
                    GuildData.getInstance().dispatchEvt(new GuildEvent(GuildEvent.MEMBER_INFO_CHANGE));
                    break;
                }
                case 1:
                {
                    GuildData.getInstance().updateMemberList(param1.memberInfo);
                    break;
                }
                case 2:
                {
                    GuildData.getInstance().deleteMember(param1.memberInfo.userId);
                    break;
                }
                case 4:
                {
                    this.reqGuildGetMemberList();
                    if (GuildControl.getInstance().guildCreatBox && GuildControl.getInstance().guildCreatBox.isOpen)
                    {
                        GuildControl.getInstance().guildCreatBox.close();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function resGuildShortInfoHandler(param1:ResGuildGetGuildShortInfoListToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            GuildData.getInstance().guildShortInfoList = param1.guildShortInfoList;
            GuildControl.getInstance().reqGuildAutoArgeeAddGuild(0);
            return;
        }// end function

        public function resGuildMemberListHandler(param1:ResGuildGetMemberListToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            GuildData.getInstance().memberList = param1.memberList;
            return;
        }// end function

        public function reqGuildList(param1:int = 1, param2:int = 1, param3:String = "") : void
        {
            this._protocol.reqGuildList(param1, param2, param3);
            return;
        }// end function

        public function reqGuildGetMemberList() : void
        {
            this._protocol.reqGuildGetMemberList(UserObj.getInstance().playerInfo.guildId);
            return;
        }// end function

        public function resGuildListHandler(param1:ResGuildGetGuildListToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            GuildApplyView.totalPage = param1.totalPage;
            GuildListView.totalPage = param1.totalPage;
            GuildData.getInstance().guildList = param1.guildList;
            return;
        }// end function

        public function reqGuildApplyAdd(param1:long) : void
        {
            this._protocol.reqGuildApplyAdd(param1);
            return;
        }// end function

        public function resGuildApplyAddDoingHandler(param1:ResGuildApplyAddDoingToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            this.guildServerPanel.addInfoToServer(param1, GuildServerPanel.TYPE_JOIN);
            return;
        }// end function

        public function reqGuildAddMember(param1:long, param2:long, param3:int) : void
        {
            this._protocol.reqGuildAddMember(param1, param2, param3);
            return;
        }// end function

        public function reqGuildDeleteMember(param1:long, param2:long) : void
        {
            this._protocol.reqGuildDeleteMember(param1, param2);
            return;
        }// end function

        public function reqGuildDeleteGuild(param1:long) : void
        {
            this._protocol.reqGuildDeleteGuild(param1);
            return;
        }// end function

        public function reqGuildQuit(param1:long) : void
        {
            this._protocol.reqGuildQuit(param1);
            return;
        }// end function

        public function resGuildDeleteInfoRoundHandler(param1:ResGuildDeleteInfoRoundToClientMessage) : void
        {
            var _loc_2:* = param1.playerid;
            var _loc_3:* = param1.guildid;
            GuildData.getInstance().deleteMember(_loc_2);
            return;
        }// end function

        public function reqGuildInviteAdd(param1:long, param2:long) : void
        {
            this._protocol.reqGuildInviteAdd(param1, param2);
            return;
        }// end function

        public function resGuildInviteAddDoingHandler(param1:ResGuildInviteAddDoingToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            this.guildServerPanel.addInfoToServer(param1, GuildServerPanel.TYPE_INVITE);
            return;
        }// end function

        public function reqGuildAutoGuildArgeeAdd(param1:long, param2:int) : void
        {
            this._protocol.reqGuildAutoGuildArgeeAdd(param1, param2);
            return;
        }// end function

        public function reqGuildAutoArgeeAddGuild(param1:int) : void
        {
            this._protocol.reqGuildAutoArgeeAddGuild(param1);
            return;
        }// end function

        public function reqGuildChangePowerLevel(param1:long, param2:long, param3:int) : void
        {
            this._protocol.reqGuildChangePowerLevel(param1, param2, param3);
            return;
        }// end function

        public function resGuildChangePowerLevelHandler(param1:ResGuildChangePowerLevelToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                if (GuildControl.getInstance().guildAppointPanel && GuildControl.getInstance().guildAppointPanel.isOpen)
                {
                    GuildControl.getInstance().guildAppointPanel.close();
                }
            }
            return;
        }// end function

        public function reqGuildImpeach(param1:long) : void
        {
            this._protocol.reqGuildImpeach(param1);
            return;
        }// end function

        public function resGuildImpeachToClientHandler(param1:ResGuildImpeachToClientMessage) : void
        {
            GuildData.getInstance().isImpeach = param1.isImpeach;
            return;
        }// end function

        public function resGuildImpeachInfoToClientHandler(param1:ResGuildImpeachInfoToClientMessage) : void
        {
            var _loc_2:* = new GuildDelateServerIcon();
            _loc_2.show();
            return;
        }// end function

        public function reqGuildChangeBulletin(param1:long, param2:String) : void
        {
            this._protocol.reqGuildChangeBulletin(param1, param2);
            return;
        }// end function

        public function reqGuildSubmitItem(param1:long, param2:int, param3:int) : void
        {
            this._protocol.reqGuildSubmitItem(param1, param2, param3);
            return;
        }// end function

        public function reqGuildChangeBannerName(param1:long, param2:String) : void
        {
            this._protocol.reqGuildChangeBannerName(param1, param2);
            return;
        }// end function

        public function resGuildChangeBannerNameHandler(param1:ResGuildChangeBannerNameToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                if (this.guildBannerChangeNamePanel && this.guildBannerChangeNamePanel.isOpen)
                {
                    this.guildBannerChangeNamePanel.close();
                }
            }
            return;
        }// end function

        public function reqGuildBannerLevelUp(param1:long) : void
        {
            this._protocol.reqGuildBannerLevelUp(param1);
            return;
        }// end function

        public function resGuildBannerLevelUpHandler(param1:ResGuildBannerLevelUpToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                if (this.guildBannerChangeLevelPanel && this.guildBannerChangeLevelPanel.isOpen)
                {
                    this.guildBannerChangeLevelPanel.close();
                }
            }
            return;
        }// end function

        public function reqGuildChangeBannerIcon(param1:long, param2:int) : void
        {
            this._protocol.reqGuildChangeBannerIcon(param1, param2);
            return;
        }// end function

        public function resGuildChangeBannerIconHandler(param1:ResGuildChangeBannerIconToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                if (this.guildBannerChangeIconPanel && this.guildBannerChangeIconPanel.isOpen)
                {
                    this.guildBannerChangeIconPanel.close();
                }
            }
            return;
        }// end function

        public function reqGuildGetEventList(param1:long) : void
        {
            this._protocol.reqGuildGetEventList(param1);
            return;
        }// end function

        public function resGuildGetEventListHandler(param1:ResGuildGetEventListToClientMessage) : void
        {
            var _loc_2:* = param1.btErrorCode;
            if (_loc_2 == 0)
            {
                GuildData.getInstance().eventList = param1.eventList;
                GuildData.getInstance().contributionList = param1.contributionList;
            }
            return;
        }// end function

        private function __updateGuildBannerBuff(event:GuildEvent = null) : void
        {
            var _loc_2:* = GuildData.getInstance().guildInfo;
            if (_loc_2)
            {
                CountryControl.getInstance().removeBuff();
                CountryControl.getInstance().createBuff(1077 + _loc_2.bannerLevel);
            }
            else
            {
                CountryControl.getInstance().removeBuff();
            }
            return;
        }// end function

        public function kugouGuildMemberListNotify(param1:ResGuildMemberListToKugooClientMessage) : void
        {
            Platform.instance.guildMemberListNotify(param1);
            return;
        }// end function

        public function kugouGuildLeaveNotify(param1:ResGuildLeaveToKugooClientMessage) : void
        {
            Platform.instance.guildLeaveNotify(param1);
            return;
        }// end function

        public function kugouGuildInfoChange(param1:ResGuildBulletinToKugooClientMessage) : void
        {
            Platform.instance.guildInfoChange(param1);
            return;
        }// end function

        public function kugouGuildDeleteNotify(param1:ResGuildDeleteToKugooClientMessage) : void
        {
            Platform.instance.guildDeleteNotify(param1);
            return;
        }// end function

        public static function getInstance() : GuildControl
        {
            if (_instance == null)
            {
                _instance = new GuildControl;
            }
            return _instance;
        }// end function

    }
}
