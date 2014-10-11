package com.game.guild.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.pop.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.chat.control.*;
    import com.game.chat.view.*;
    import com.game.guild.bean.*;
    import com.game.guild.control.*;
    import com.game.guild.events.*;
    import com.game.guild.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildInfoView extends Component
    {
        private var mc_level:MovieClip;
        private var mc_bannerLevel2:MovieClip;
        private var txt_guildName:TextField;
        private var txt_rank:TextField;
        private var txt_contrbution:TextField;
        private var txt_bangZhuName:TextField;
        private var txt_memberNumber:TextField;
        private var txt_fightValue:TextField;
        private var txt_guildBulletin:TextField;
        private var check_btn4:BaseButton;
        private var btn_chat:BaseButton;
        private var btn_opt:BaseButton;
        private var mc_opt:MovieClip;
        private var btn_guildDelete:BaseButton;
        private var btn_exit:BaseButton;
        private var btn_addbullet:BaseButton;
        private var btn_recruit:BaseButton;
        private var btn_delate:BaseButton;
        private var bg_opt:DisplayObject;
        private var btnArray:Array;
        private var mc_GuildStateOne:MovieClip;
        private var mc_List1:MovieClip;
        private var _list1:List;
        private var _guildMemberInfoItem:GuildMemberInfoItem;
        private var btn1_state1:BaseButton;
        private var btn2_state1:BaseButton;
        private var btn3_state1:BaseButton;
        private var btn4_state1:BaseButton;
        private var btn5_state1:BaseButton;
        private var btn6_state1:BaseButton;
        private var btnStateArray:Array;
        private var btnStateNameArray:Array;
        private var sortAttrArray:Array;
        private var upSort:Array;
        private var lastSortClick:int = -1;
        private var _curSelectItem:GuildMemberInfoItem;
        private var _curSelectID:long;
        private var _isSelectPlayer:Boolean = false;
        private var funArray:Array;
        public var _guildInfo:GuildInfo;
        private var _memberList:Vector.<MemberInfo>;
        private var _sortType:String = "userName";

        public function GuildInfoView()
        {
            this.btnArray = [];
            this.btnStateArray = [];
            this.btnStateNameArray = [LanguageCfgObj.getInstance().getByIndex("10000", "lang_guild"), LanguageCfgObj.getInstance().getByIndex("10001", "lang_guild"), LanguageCfgObj.getInstance().getByIndex("10002", "lang_guild"), LanguageCfgObj.getInstance().getByIndex("10003", "lang_guild"), LanguageCfgObj.getInstance().getByIndex("10004", "lang_guild"), LanguageCfgObj.getInstance().getByIndex("10005", "lang_guild")];
            this.sortAttrArray = ["userName", "level", "guildPowerLevel", "fightPower", "contributionPointWeek", "lastOnlineTime"];
            this.upSort = ["level", "fightPower", "contributionPointWeek"];
            this.funArray = [];
            initComponentUI("guildInfoPanel");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        public function get curSelectItem() : GuildMemberInfoItem
        {
            return this._curSelectItem;
        }// end function

        public function reset() : void
        {
            this._isSelectPlayer = false;
            this._curSelectID = null;
            this._curSelectItem = null;
            return;
        }// end function

        private function initUI() : void
        {
            this.mc_level = getDisplayChildByName("mc_level");
            this.mc_bannerLevel2 = getDisplayChildByName("mc_bannerLevel2");
            this.txt_guildName = getDisplayChildByName("txt_guildName");
            this.txt_guildName.selectable = false;
            this.txt_rank = getDisplayChildByName("txt_rank");
            this.txt_rank.selectable = false;
            this.txt_contrbution = getDisplayChildByName("txt_contrbution");
            this.txt_contrbution.selectable = false;
            this.txt_bangZhuName = getDisplayChildByName("txt_bangZhuName");
            this.txt_bangZhuName.selectable = false;
            this.txt_memberNumber = getDisplayChildByName("txt_memberNumber");
            this.txt_memberNumber.selectable = false;
            this.txt_fightValue = getDisplayChildByName("txt_fightValue");
            this.txt_fightValue.selectable = false;
            this.txt_guildBulletin = getDisplayChildByName("txt_guildBulletin");
            this.txt_guildBulletin.selectable = false;
            this.check_btn4 = new BaseButton(getDisplayChildByName("check_btn4"), true);
            this.check_btn4.selected = true;
            this.check_btn4.setText(LanguageCfgObj.getInstance().getByIndex("10823"));
            this.btn_chat = new BaseButton(getDisplayChildByName("btn_chat"));
            this.btn_opt = new BaseButton(getDisplayChildByName("btn_opt"));
            this.btn_opt.setText(LanguageCfgObj.getInstance().getByIndex("10824"));
            this.mc_opt = getDisplayChildByName("mc_opt");
            this.mc_opt.visible = false;
            this.btn_guildDelete = new BaseButton(this.mc_opt.getChildByName("btn_guildDelete"));
            this.btn_guildDelete.setText(LanguageCfgObj.getInstance().getByIndex("10825"));
            this.btn_exit = new BaseButton(this.mc_opt.getChildByName("btn_exit"));
            this.btn_exit.setText(LanguageCfgObj.getInstance().getByIndex("10826"));
            this.btn_addbullet = new BaseButton(this.mc_opt.getChildByName("btn_addbullet"));
            this.btn_addbullet.setText(LanguageCfgObj.getInstance().getByIndex("10827"));
            this.btn_recruit = new BaseButton(this.mc_opt.getChildByName("btn_recruit"));
            this.btn_recruit.setText(LanguageCfgObj.getInstance().getByIndex("10828"));
            this.btn_delate = new BaseButton(this.mc_opt.getChildByName("btn_delate"));
            this.btn_delate.setText(LanguageCfgObj.getInstance().getByIndex("12417"));
            this.bg_opt = this.mc_opt.getChildByName("bg") as DisplayObject;
            this.btnArray.push(this.btn_delate, this.btn_guildDelete, this.btn_exit, this.btn_addbullet, this.btn_recruit);
            this.mc_GuildStateOne = getDisplayChildByName("mc_GuildStateOne");
            this.mc_List1 = this.mc_GuildStateOne.getChildByName("mc_List") as MovieClip;
            this._list1 = new List(715, 255);
            this.mc_List1.addChild(this._list1);
            this.btn1_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn1"));
            this.btn2_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn2"));
            this.btn3_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn3"));
            this.btn4_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn4"));
            this.btn5_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn5"));
            this.btn6_state1 = new BaseButton(this.mc_GuildStateOne.getChildByName("btn6"));
            this.btnStateArray.push(this.btn1_state1, this.btn2_state1, this.btn3_state1, this.btn4_state1, this.btn5_state1, this.btn6_state1);
            var _loc_1:* = 0;
            while (_loc_1 < this.btnStateArray.length)
            {
                
                this.btnStateArray[_loc_1].setText(this.btnStateNameArray[_loc_1]);
                _loc_1++;
            }
            this.funArray.push(this.refreshState1);
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.check_btn4.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_chat.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_opt.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_guildDelete.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_exit.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_addbullet.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_recruit.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            this.btn_delate.addEventListener(MouseEvent.CLICK, this.__click2, false, 0, true);
            var _loc_1:* = 0;
            while (_loc_1 < this.btnStateArray.length)
            {
                
                this.btnStateArray[_loc_1].addEventListener(MouseEvent.CLICK, this.__click3, false, 0, true);
                _loc_1++;
            }
            GuildData.getInstance().addEvtListener(GuildEvent.GUILD_INFO_CHANGE, this.updateGuildInfo);
            GuildData.getInstance().addEvtListener(GuildEvent.MEMBER_INFO_CHANGE, this.update);
            GuildData.getInstance().addEvtListener(GuildEvent.OTHER_MEMBER_INFO_CHANGE, this.updateOtherMemberInfo);
            return;
        }// end function

        private function __click2(event:MouseEvent = null) : void
        {
            var e:* = event;
            switch(e.target)
            {
                case this.check_btn4:
                {
                    this._sortType = "lastOnlineTime";
                    this.filterOnline();
                    break;
                }
                case this.btn_chat:
                {
                    GuildControl.getInstance().openGuildChatBox();
                    break;
                }
                case this.btn_opt:
                {
                    this.updateBtn();
                    this.mc_opt.visible = !this.mc_opt.visible;
                    break;
                }
                case this.btn_guildDelete:
                {
                    this.mc_opt.visible = false;
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1)
                    {
                        Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12072"), "", null, function () : void
            {
                GuildControl.getInstance().reqGuildDeleteGuild(GuildData.getInstance().myMemberInfo.guildId);
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10829"));
                    }
                    break;
                }
                case this.btn_exit:
                {
                    this.mc_opt.visible = false;
                    if (GuildData.getInstance().myMemberInfo.guildPowerLevel == 1)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10830"));
                        return;
                    }
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12073"), "", null, function () : void
            {
                GuildControl.getInstance().reqGuildQuit(UserObj.getInstance().playerInfo.guildId);
                if (GuildControl.getInstance().guildBox.isOpen)
                {
                    GuildControl.getInstance().guildBox.close();
                }
                return;
            }// end function
            , null, 2, LanguageCfgObj.getInstance().getByIndex("10831"));
                    break;
                }
                case this.btn_addbullet:
                {
                    if (GuildData.getInstance().guildInfo.bannerLevel < 3)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("12423"));
                    }
                    else
                    {
                        this.mc_opt.visible = false;
                        GuildControl.getInstance().openGuildChangeBullet();
                    }
                    break;
                }
                case this.btn_recruit:
                {
                    this.mc_opt.visible = false;
                    ChatController.getInstance().openLookList(ChatSearchList.GUILD);
                    break;
                }
                case this.btn_delate:
                {
                    this.mc_opt.visible = false;
                    Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12418"), LanguageCfgObj.getInstance().getByIndex("12419"), null, function () : void
            {
                GuildControl.getInstance().reqGuildImpeach(UserObj.getInstance().playerInfo.guildId);
                return;
            }// end function
            , null, 2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __click3(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnStateArray.indexOf(event.target);
            if (this.lastSortClick == _loc_2)
            {
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.btnStateArray.length)
            {
                
                if (this.btnStateArray[_loc_3] == event.target)
                {
                    this.btnStateArray[_loc_3].selected = true;
                    this.sort(this.sortAttrArray[_loc_3]);
                    this.funArray[0].call();
                }
                else
                {
                    this.btnStateArray[_loc_3].selected = false;
                }
                _loc_3++;
            }
            this.lastSortClick = _loc_2;
            return;
        }// end function

        private function refreshState1() : void
        {
            this._list1.reset();
            var _loc_1:* = 0;
            while (this._memberList && _loc_1 < this._memberList.length)
            {
                
                this._guildMemberInfoItem = new GuildMemberInfoItem();
                this._guildMemberInfoItem.addEventListener(MouseEvent.CLICK, this.__selectItem);
                this._guildMemberInfoItem.obj = this._memberList[_loc_1];
                this._guildMemberInfoItem.selected = false;
                this._guildMemberInfoItem.index = _loc_1;
                this._list1.add(this._guildMemberInfoItem);
                if (this._isSelectPlayer)
                {
                    this.setLastSelect();
                }
                _loc_1++;
            }
            return;
        }// end function

        private function setLastSelect() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this._list1.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = GuildMemberInfoItem(this._list1.getContent(_loc_2));
                if (this._curSelectID && _loc_3.info.userId.equal(this._curSelectID))
                {
                    _loc_3.selected = true;
                    this._curSelectItem = _loc_3;
                    return;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function updateOtherMemberInfo(event:GuildEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!stage)
            {
                return;
            }
            var _loc_2:* = 0;
            while (this._list1 && _loc_2 < this._list1.length)
            {
                
                _loc_3 = this._list1.getContent(_loc_2) as GuildMemberInfoItem;
                _loc_4 = _loc_3.info as MemberInfo;
                if (_loc_4 && _loc_4.userId.equal(event.data.userId))
                {
                    _loc_3.obj = event.data;
                }
                _loc_2++;
            }
            return;
        }// end function

        public function updateGuildInfo(event:Event = null) : void
        {
            if (!stage)
            {
                return;
            }
            this.getData();
            this.refreshText();
            this.updateBtn();
            return;
        }// end function

        public function __selectItem(event:MouseEvent = null) : void
        {
            if (this._curSelectItem)
            {
                this._curSelectItem.selected = false;
            }
            this._curSelectItem = event.currentTarget as GuildMemberInfoItem;
            this._curSelectID = this._curSelectItem.info.userId;
            this._isSelectPlayer = true;
            event.currentTarget.selected = true;
            var _loc_2:* = new PlayerInfo();
            _loc_2.personId = event.currentTarget.info.userId;
            _loc_2.name = event.currentTarget.info.userName;
            GuildPlayerOptPopMenu.getInstance().show(_loc_2, this, GuildPlayerOptPopMenu.GUILD);
            GuildData.getInstance().openOrigin = 1;
            return;
        }// end function

        public function update(event:Event = null) : void
        {
            if (!UILoaded)
            {
                return;
            }
            if (event && !stage)
            {
                return;
            }
            this.getData();
            this.refreshText();
            this.refreshState1();
            var _loc_2:* = (Global.popManager as PopManager).cueBox;
            if (_loc_2 && _loc_2.stage && (_loc_2 as SysCueBox).titleLabel == LanguageCfgObj.getInstance().getByIndex("12419"))
            {
                this.showBtn();
            }
            else
            {
                this.mc_opt.visible = false;
                this.updateBtn();
            }
            return;
        }// end function

        private function getData() : void
        {
            this._guildInfo = GuildData.getInstance().guildInfo;
            this._memberList = GuildData.getInstance().memberList;
            if (this.check_btn4.selected)
            {
                this._memberList = GuildData.getInstance().memberList;
            }
            else
            {
                this._memberList = this._memberList.filter(this.callback);
            }
            return;
        }// end function

        private function sort(param1:String) : void
        {
            this._sortType = param1;
            if (this.upSort.indexOf(param1) != -1)
            {
                this._memberList.sort(this.compare2);
            }
            else
            {
                this._memberList.sort(this.compare1);
            }
            return;
        }// end function

        private function compare1(param1:MemberInfo, param2:MemberInfo) : int
        {
            if (param1[this._sortType] < param2[this._sortType])
            {
                return -1;
            }
            if (param1[this._sortType] > param2[this._sortType])
            {
                return 1;
            }
            return 0;
        }// end function

        private function compare2(param1:MemberInfo, param2:MemberInfo) : int
        {
            if (param1[this._sortType] < param2[this._sortType])
            {
                return 1;
            }
            if (param1[this._sortType] > param2[this._sortType])
            {
                return -1;
            }
            return 0;
        }// end function

        private function filterOnline() : void
        {
            if (this.check_btn4.selected)
            {
                this._memberList = GuildData.getInstance().memberList;
            }
            else
            {
                this._memberList = this._memberList.filter(this.callback);
            }
            this.sort(this._sortType);
            this.refreshState1();
            return;
        }// end function

        private function callback(param1, param2:int, param3:Vector.<MemberInfo>) : Boolean
        {
            if (param1.lastOnlineTime == 0)
            {
                return true;
            }
            return false;
        }// end function

        private function refreshText() : void
        {
            if (!this._guildInfo)
            {
                return;
            }
            var _loc_1:* = GuildData.getInstance().guildInfo.bannerLevel;
            var _loc_2:* = BannerCfgObj.getInstance().getGuildBannerinfoByLev(_loc_1);
            var _loc_3:* = _loc_2.levelup.split("_");
            this.txt_guildName.text = this._guildInfo.guildName;
            this.txt_rank.text = "" + this._guildInfo.guildRank;
            this.txt_contrbution.text = "" + this._guildInfo.guildContribution;
            this.txt_bangZhuName.text = this._guildInfo.bangZhuName;
            this.txt_memberNumber.text = this._guildInfo.memberNum + "/" + String(_loc_3[6] ? (_loc_3[6]) : (30));
            this.txt_fightValue.text = "" + this._guildInfo.memberFightPower;
            var _loc_4:* = this._guildInfo.guildBulletin;
            this.txt_guildBulletin.text = _loc_4;
            this.txt_guildBulletin.width = this.txt_guildBulletin.textWidth + 5;
            this.txt_guildBulletin.x = 70;
            var _loc_5:* = this.txt_guildBulletin.width;
            Ticker.killTimer(this.txtAnimation);
            if (_loc_4.length < 30)
            {
            }
            else
            {
                Ticker.registerTimer(0.1, this.txtAnimation, this.txtAnimationCompelete, _loc_5 + 5);
            }
            if (this._guildInfo.bannerLevel >= 10)
            {
                this.mc_level.gotoAndStop((int(this._guildInfo.bannerLevel / 10) + 1));
                this.mc_bannerLevel2.gotoAndStop(int(this._guildInfo.bannerLevel % 10));
                this.mc_level.visible = true;
                this.mc_bannerLevel2.visible = true;
            }
            else
            {
                this.mc_level.gotoAndStop((this._guildInfo.bannerLevel + 1));
                this.mc_level.visible = true;
                this.mc_bannerLevel2.visible = false;
            }
            return;
        }// end function

        public function showBtn(param1:Boolean = true) : void
        {
            if (UILoaded)
            {
                this.mc_opt.visible = param1;
                this.updateBtn();
            }
            return;
        }// end function

        public function updateBtn() : void
        {
            if (!UILoaded)
            {
                return;
            }
            this.btn_guildDelete.visible = false;
            this.btn_exit.visible = false;
            this.btn_addbullet.visible = false;
            this.btn_recruit.visible = false;
            this.btn_delate.visible = Boolean(GuildData.getInstance().isImpeach);
            if (GuildData.getInstance().myMemberInfo && GuildData.getInstance().myMemberInfo.guildPowerLevel == 1)
            {
                this.btn_guildDelete.visible = true;
                this.btn_exit.visible = true;
                this.btn_addbullet.visible = true;
                this.btn_recruit.visible = true;
            }
            else if (GuildData.getInstance().myMemberInfo && GuildData.getInstance().myMemberInfo.guildPowerLevel == 2)
            {
                this.btn_exit.visible = true;
                this.btn_addbullet.visible = true;
                this.btn_recruit.visible = true;
            }
            else
            {
                this.btn_exit.visible = true;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this.btnArray.length)
            {
                
                if (this.btnArray[_loc_2].visible)
                {
                    this.btnArray[_loc_2].y = 5 + (this.btn_opt.height + 5) * _loc_1;
                    _loc_1++;
                }
                _loc_2++;
            }
            this.bg_opt.height = (this.btn_opt.height + 5) * _loc_1 + 5;
            this.mc_opt.y = this.btn_opt.y - this.bg_opt.height - 3;
            return;
        }// end function

        private function txtAnimationCompelete() : void
        {
            this.txt_guildBulletin.x = 70;
            var _loc_1:* = this.txt_guildBulletin.width;
            Ticker.registerTimer(0.2, this.txtAnimation, this.txtAnimationCompelete, _loc_1 + 5);
            return;
        }// end function

        private function txtAnimation() : void
        {
            (this.txt_guildBulletin.x - 1);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
