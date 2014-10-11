package com.game.team.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.team.bean.*;
    import com.game.team.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class TeamPanel extends BaseBox
    {
        private const TIP_HELP_STRING:String = "视野内每多一个队员，经验加成10%";
        private var TIP_BUFF_STRING:String;
        private var viewTeamList:Sprite;
        private var viewMember:Sprite;
        private var btnClose:BaseButton;
        private var btnApply:BaseButton;
        private var btnCreat:BaseButton;
        private var btnHelp:BaseButton;
        private var btnAutoAgreeJoin:BaseButton;
        private var btnAutoAgreeInvite:BaseButton;
        private var teamList:List;
        private var _hasTeam:Boolean;
        private var selectTeam:TeamInfoItem;
        private var delayHandler:uint;
        private var isCanSearch:Boolean = true;
        private var vecTeamItem:Vector.<TeamInfoItem>;
        private var vecTeamMemberList:Vector.<TeamPhotoItem>;
        private var memberHbox:HBox;
        private var buffIcon:Sprite;
        private var funList:TeamFunList;

        public function TeamPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.TIP_BUFF_STRING = LanguageCfgObj.getInstance().getByIndex("11354");
            this.vecTeamItem = new Vector.<TeamInfoItem>;
            super(param1, param2, param3, param4);
            _combinedBox = ["com.game.team.view::TeamInvitePanel", "com.game.team.view::TeamServerPanel"];
            loadDisplay("res/team.swf");
            return;
        }// end function

        public function get hasTeam() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = UserObj.getInstance().playerInfo.teamId;
            if (_loc_2)
            {
                _loc_1 = _loc_2.low == 0 && _loc_2.high == 0 ? (false) : (true);
            }
            else
            {
                _loc_1 = false;
            }
            return _loc_1;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("team");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.initViewTeamList();
            this.initViewMember();
            this.funList = TeamFunList.getInstance();
            this.buffIcon = getDisplayChildByName("buffIcon");
            this.btnApply = new BaseButton(this.viewTeamList["btnApply"]);
            this.btnApply.setText(LanguageCfgObj.getInstance().getByIndex("11355"));
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.btnCreat = new BaseButton(this.viewTeamList["btnCreat"]);
            this.btnCreat.setText(LanguageCfgObj.getInstance().getByIndex("11356"));
            this.btnHelp = new BaseButton(this.viewTeamList["btnHelp"]);
            this.btnAutoAgreeJoin = new BaseButton(getDisplayChildByName("btnAutoAgreeJoin"), true);
            this.btnAutoAgreeInvite = new BaseButton(getDisplayChildByName("btnAutoAgreeInvite"), true);
            this.viewMember.visible = false;
            this.setBuffIconState(false);
            StringTip.create(this.btnHelp, this.TIP_HELP_STRING);
            return;
        }// end function

        private function initViewTeamList() : void
        {
            this.viewTeamList = getDisplayChildByName("viewTeamList");
            this.teamList = new List(673, 280);
            this.teamList.move(19, 100);
            this.viewTeamList.addChild(this.teamList);
            return;
        }// end function

        private function initViewMember() : void
        {
            this.viewMember = getDisplayChildByName("viewMember");
            this.memberHbox = new HBox();
            this.memberHbox.horizontal = true;
            this.viewMember.addChild(this.memberHbox);
            this.memberHbox.move(5, 0);
            this.creatItemPhoto();
            return;
        }// end function

        public function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEvtListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEvtListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            var event:* = event;
            this.transPanel();
            if (this.hasTeam)
            {
                if (this.isCanSearch)
                {
                    this.isCanSearch = false;
                    this.delayHandler = setTimeout(function () : void
            {
                isCanSearch = true;
                clearTimeout(delayHandler);
                return;
            }// end function
            , 3);
                    this.updateTeamMemberInfo();
                    TeamControl.getInstance().reqUpdateTeamInfoGame(UserObj.getInstance().playerInfo.teamId);
                }
            }
            else if (this.isCanSearch)
            {
                this.isCanSearch = false;
                this.delayHandler = setTimeout(function () : void
            {
                isCanSearch = true;
                clearTimeout(delayHandler);
                return;
            }// end function
            , 3000);
                TeamControl.getInstance().reqMapSearchTeamInfoGame();
            }
            return;
        }// end function

        public function mouseClickHandler(event:MouseEvent) : void
        {
            this.removeFunList();
            if (event.target is TeamInfoItem)
            {
                this.clickItem(event.target as TeamInfoItem);
                return;
            }
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.btnApply:
                {
                    this.applyTeam();
                    break;
                }
                case this.btnCreat:
                {
                    this.creatTeam();
                    break;
                }
                case this.btnAutoAgreeInvite:
                {
                    this.autoAgreeInvite();
                    break;
                }
                case this.btnAutoAgreeJoin:
                {
                    this.autoAgreeJoin();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function mouseOverHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        private function mouseOutHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        private function autoAgreeInvite() : void
        {
            var _loc_1:* = this.btnAutoAgreeInvite.selected;
            TeamControl.getInstance().reqAutoTeaminvitedGame(_loc_1);
            return;
        }// end function

        private function autoAgreeJoin() : void
        {
            var _loc_1:* = this.btnAutoAgreeJoin.selected;
            TeamControl.getInstance().reqAutoIntoTeamApplyGame(_loc_1);
            return;
        }// end function

        private function applyTeam() : void
        {
            if (this.selectTeam)
            {
                TeamControl.getInstance().reqApplyGame(this.selectTeam.info.teamid);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11357"));
            }
            return;
        }// end function

        private function creatTeam() : void
        {
            if (this.hasTeam)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("11358"));
                return;
            }
            TeamControl.getInstance().reqCreateateamGame();
            return;
        }// end function

        private function clickItem(param1:TeamInfoItem) : void
        {
            if (this.selectTeam)
            {
                this.selectTeam.selected = false;
            }
            this.selectTeam = param1;
            this.selectTeam.selected = true;
            return;
        }// end function

        public function setAutoAgreeInvite(param1:Boolean) : void
        {
            this.btnAutoAgreeInvite.selected = param1;
            return;
        }// end function

        public function setAutoAgreeJoin(param1:Boolean) : void
        {
            this.btnAutoAgreeJoin.selected = param1;
            return;
        }// end function

        public function updateTeamMemberInfo() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = TeamModel.getInstance().teamId;
            var _loc_2:* = TeamModel.getInstance().vecTeamInfo;
            var _loc_4:* = 0;
            while (_loc_4 < TeamModel.MAX_MEMBER_COUNT)
            {
                
                _loc_3 = this.vecTeamMemberList[_loc_4];
                if (_loc_2.length > _loc_4)
                {
                    _loc_3.info = _loc_2[_loc_4];
                }
                else
                {
                    _loc_3.info = null;
                }
                _loc_4++;
            }
            this.setBuffIconState(_loc_2.length > 1);
            this.transPanel();
            return;
        }// end function

        public function updateTeamListInfo(param1:Vector.<MapTeamInfo>) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.length;
            while (this.vecTeamItem.length > 0)
            {
                
                _loc_3 = this.vecTeamItem.pop();
            }
            this.teamList.reset();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = new TeamInfoItem();
                _loc_3.index = _loc_4 + 1;
                this.vecTeamItem.push(_loc_3);
                _loc_3.info = param1[_loc_4];
                this.teamList.add(_loc_3);
                _loc_4++;
            }
            if (this.vecTeamItem.length > 0)
            {
                this.vecTeamItem[0].selected = true;
                this.selectTeam = this.vecTeamItem[0];
            }
            this.setBtnApplyState(param1.length > 0);
            this.setBuffIconState(false);
            this.transPanel();
            return;
        }// end function

        private function setBtnApplyState(param1:Boolean) : void
        {
            if (param1)
            {
                this.btnApply.mouseEnabled = true;
                this.btnApply.filters = [];
            }
            else
            {
                this.btnApply.mouseEnabled = false;
                this.btnApply.filters = [ColorFilter.getGrayFilter()];
            }
            return;
        }// end function

        private function setBuffIconState(param1:Boolean) : void
        {
            if (param1)
            {
                this.buffIcon.filters = [];
            }
            else
            {
                this.buffIcon.filters = [ColorFilter.getGrayFilter()];
            }
            return;
        }// end function

        private function transPanel() : void
        {
            if (this.hasTeam)
            {
                this.viewTeamList.visible = false;
                this.viewMember.visible = true;
            }
            else
            {
                this.viewTeamList.visible = true;
                this.viewMember.visible = false;
            }
            StringTip.dispose(this.buffIcon);
            var _loc_1:* = this.getAddedRoleCount();
            _loc_1 = _loc_1 - 1;
            _loc_1 = _loc_1 < 0 ? (0) : (_loc_1);
            _loc_1 = _loc_1 * 10;
            StringTip.create(this.buffIcon, this.TIP_BUFF_STRING.replace("[1]", _loc_1 + "%"));
            return;
        }// end function

        private function creatItemPhoto() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            if (!this.vecTeamMemberList)
            {
                this.vecTeamMemberList = new Vector.<TeamPhotoItem>(TeamModel.MAX_MEMBER_COUNT, true);
                _loc_1 = 0;
                while (_loc_1 < TeamModel.MAX_MEMBER_COUNT)
                {
                    
                    _loc_2 = new TeamPhotoItem();
                    _loc_2.mouseEnabled = false;
                    _loc_2.mouseChildren = true;
                    _loc_2.index = _loc_1;
                    this.vecTeamMemberList[_loc_1] = _loc_2;
                    this.memberHbox.add(_loc_2);
                    _loc_2.addEventListener(MouseEvent.CLICK, this.clickPhotoItem, true);
                    _loc_1++;
                }
            }
            return;
        }// end function

        protected function clickPhotoItem(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.currentTarget is TeamPhotoItem && !(event.target is BaseButton))
            {
                _loc_2 = event.currentTarget as TeamPhotoItem;
                _loc_3 = UserObj.getInstance().playerInfo.personId;
                if (_loc_2.info && !_loc_3.equal(_loc_2.info.memberid))
                {
                    this.funList.info = _loc_2.info;
                    this.addChild(this.funList);
                    this.funList.x = this.mouseX;
                    this.funList.y = this.mouseY;
                    event.stopImmediatePropagation();
                }
            }
            return;
        }// end function

        private function removeFunList() : void
        {
            if (this.funList.parent)
            {
                this.funList.parent.removeChild(this.funList);
            }
            return;
        }// end function

        private function cleanTeamMemberInfo() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < TeamModel.MAX_MEMBER_COUNT)
            {
                
                _loc_1 = this.vecTeamMemberList[_loc_2];
                _loc_1.clean();
                _loc_2++;
            }
            return;
        }// end function

        override public function close() : void
        {
            this.removeFunList();
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        private function getAddedRoleCount() : int
        {
            var _loc_5:* = null;
            var _loc_1:* = TeamModel.getInstance().getSelfInfo();
            if (!_loc_1)
            {
                return 0;
            }
            var _loc_2:* = 0;
            var _loc_3:* = TeamModel.getInstance().vecTeamInfo.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = TeamModel.getInstance().vecTeamInfo[_loc_4];
                if (_loc_5.memberline == _loc_1.memberline && this.isInScreen(_loc_5))
                {
                    _loc_2++;
                    ;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        private function isInScreen(param1:TeamMemberInfo) : Boolean
        {
            var _loc_2:* = null;
            if (param1 && RoleList.getInstance().roles)
            {
                if (param1.memberid.equal(UserObj.getInstance().playerInfo.personId))
                {
                    return true;
                }
                _loc_2 = RoleList.getInstance().getRole(param1.memberid);
                if (_loc_2)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
