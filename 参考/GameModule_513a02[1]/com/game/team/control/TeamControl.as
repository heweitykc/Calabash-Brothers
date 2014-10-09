package com.game.team.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.role.*;
    import com.game.team.message.*;
    import com.game.team.model.*;
    import com.game.team.protocol.*;
    import com.game.team.view.*;
    import com.game.utils.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.utils.*;
    import net.*;

    public class TeamControl extends Object
    {
        private var _model:TeamModel;
        private var _protocol:TeamProtocol;
        private var _teamPanel:TeamPanel;
        private var _teamInvitePanel:TeamInvitePanel;
        private var _teamServerPanel:TeamServerPanel;
        private var _iconTeamScreen:TeamIconScreen;
        private static var _instance:TeamControl;

        public function TeamControl()
        {
            this._protocol = new TeamProtocol();
            this._model = TeamModel.getInstance();
            this.initView();
            return;
        }// end function

        public function get teamPanel() : TeamPanel
        {
            if (!this._teamPanel)
            {
                this._teamPanel = new TeamPanel();
                Global.popManager.addPop(this._teamPanel);
            }
            return this._teamPanel;
        }// end function

        public function get teamInvitePanel() : TeamInvitePanel
        {
            if (!this._teamInvitePanel)
            {
                this._teamInvitePanel = new TeamInvitePanel();
                Global.popManager.addPop(this._teamInvitePanel);
            }
            return this._teamInvitePanel;
        }// end function

        public function get teamServerPanel() : TeamServerPanel
        {
            if (!this._teamServerPanel)
            {
                this._teamServerPanel = new TeamServerPanel();
                Global.popManager.addPop(this._teamServerPanel);
            }
            return this._teamServerPanel;
        }// end function

        public function get iconTeamScreen() : TeamIconScreen
        {
            if (!this._iconTeamScreen)
            {
                this._iconTeamScreen = new TeamIconScreen();
                ItemTips.create(this._iconTeamScreen, {}, TeamIconScreenTips);
            }
            return this._iconTeamScreen;
        }// end function

        private function initView() : void
        {
            return;
        }// end function

        public function openOrCloseTeam() : void
        {
            if (!this.teamPanel.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_DuiWu);
            }
            this.teamPanel.openOrClose();
            return;
        }// end function

        public function openTeamInvitePanel() : void
        {
            this.teamInvitePanel.open();
            return;
        }// end function

        public function openTeamServerPanel(param1:String) : void
        {
            this.teamServerPanel.type = param1;
            this.teamServerPanel.open();
            return;
        }// end function

        public function showOrHideTeamMemberArea(param1:Boolean) : void
        {
            if (param1)
            {
                if (!this.iconTeamScreen.parent)
                {
                    Global.mainUIManager.addUI(this.iconTeamScreen);
                    this.iconTeamScreen.parent.setChildIndex(this.iconTeamScreen, 0);
                    this.iconTeamScreen.x = 138;
                    this.iconTeamScreen.y = 157;
                }
            }
            else if (this.iconTeamScreen.parent)
            {
                Global.mainUIManager.removeUI(this.iconTeamScreen);
            }
            return;
        }// end function

        public function removeInfoFromServer(param1:Message, param2:String) : void
        {
            this.teamServerPanel.removeInfoFromServer(param1, param2);
            return;
        }// end function

        public function applyClientBack(param1:ResApplyClientMessage) : void
        {
            this.teamServerPanel.addInfoToServer(param1, TeamServerPanel.TYPE_JOIN);
            return;
        }// end function

        public function autoIntoTeamApplyClientBack(param1:ResAutoIntoTeamApplyClientMessage) : void
        {
            var _loc_2:* = param1.autointoteamapply == 1 ? (true) : (false);
            this._teamPanel.setAutoAgreeJoin(_loc_2);
            return;
        }// end function

        public function autoTeamInvitedClientBack(param1:ResAutoTeaminvitedClientMessage) : void
        {
            var _loc_2:* = param1.autoTeaminvited == 1 ? (true) : (false);
            this._teamPanel.setAutoAgreeInvite(_loc_2);
            return;
        }// end function

        public function InviteClientBack(param1:ResInviteClientMessage) : void
        {
            this.teamServerPanel.addInfoToServer(param1, TeamServerPanel.TYPE_INVITE);
            return;
        }// end function

        public function mapSearchMemberNameClientBack(param1:ResMapSearchMemberNameClientMessage) : void
        {
            return;
        }// end function

        public function teamClientRefreshBack(param1:ResTeamClientRefreshMessage) : void
        {
            var _loc_5:* = null;
            MapControl.getInstance().teamMemberUpdate(param1);
            var _loc_2:* = param1.teamid;
            var _loc_3:* = param1.memberinfo;
            UserObj.getInstance().playerInfo.teamId = _loc_2;
            this._model.vecTeamInfo = _loc_3;
            if (_loc_3.length > 0)
            {
                this._model.captainId = _loc_3[0].memberid;
                this.showOrHideTeamMemberArea(true);
                this.iconTeamScreen.setCount(_loc_3.length);
                if (this._teamServerPanel)
                {
                    if (!UserObj.getInstance().playerInfo.personId.equal(this._model.captainId))
                    {
                        this._teamServerPanel.close();
                    }
                }
            }
            else
            {
                this.showOrHideTeamMemberArea(false);
                this._model.captainId = null;
            }
            if (this._teamPanel)
            {
                this.teamPanel.updateTeamMemberInfo();
            }
            if (this._teamInvitePanel)
            {
                this._teamInvitePanel.setSearchResult(_loc_3);
            }
            var _loc_4:* = RoleList.getInstance().roles;
            for each (_loc_5 in _loc_4)
            {
                
                _loc_5.showIsCommonTeam();
            }
            return;
        }// end function

        public function teamSetToClientBack(param1:ResTeamSetToClientMessage) : void
        {
            var _loc_2:* = param1.autoTeaminvited == 1 ? (true) : (false);
            var _loc_3:* = param1.autoIntoteamapply == 1 ? (true) : (false);
            this._teamPanel.setAutoAgreeJoin(_loc_3);
            this._teamPanel.setAutoAgreeInvite(_loc_2);
            return;
        }// end function

        public function mapSearchTeamTeamInfoClientBack(param1:ResMapSearchTeamInfoClientMessage) : void
        {
            if (this._teamPanel)
            {
                this._teamPanel.updateTeamListInfo(param1.mapteaminfo);
                this.teamInvitePanel.close();
            }
            return;
        }// end function

        public function mapSearchPlayerInfoClientBack(param1:ResMapSearchPlayerInfoClientMessage) : void
        {
            this._teamInvitePanel.updatePlayerList(param1.mapplayerinfo);
            return;
        }// end function

        public function teamExteriorClientBack(param1:ResTeamExteriorClientMessage) : void
        {
            return;
        }// end function

        public function teammateMoveToClientBack(param1:ResTeammateMoveToClientMessage) : void
        {
            this._model.updateTeamPos(param1);
            MapControl.getInstance().teamMemberPosUpdate(param1);
            return;
        }// end function

        public function reqApplyGame(param1:long) : void
        {
            this._protocol.reqApplyGame(param1);
            return;
        }// end function

        public function reqApplyGameSelect(param1:long, param2:long, param3:Boolean) : void
        {
            this._protocol.reqApplyGameSelect(param1, param2, param3);
            return;
        }// end function

        public function reqAppointGame(param1:long, param2:long) : void
        {
            this._protocol.reqAppointGame(param1, param2);
            return;
        }// end function

        public function reqAutoIntoTeamApplyGame(param1:Boolean) : void
        {
            this._protocol.reqAutoIntoTeamApplyGame(param1);
            return;
        }// end function

        public function reqAutoTeaminvitedGame(param1:Boolean) : void
        {
            this._protocol.reqAutoTeaminvitedGame(param1);
            return;
        }// end function

        public function reqCreateateamGame() : void
        {
            this._protocol.reqCreateateamGame();
            return;
        }// end function

        private function reqGenericSearchToGame() : void
        {
            return;
        }// end function

        private function reqIntoTeamToGame(param1:long) : void
        {
            this._protocol.reqIntoTeamToGame(param1);
            return;
        }// end function

        public function teamInvitePlayer(param1:long) : void
        {
            var _loc_2:* = null;
            if (!_loc_2)
            {
                _loc_2 = new long();
            }
            this.reqInviteGame(param1, _loc_2);
            return;
        }// end function

        public function reqInviteGame(param1:long, param2:long) : void
        {
            this._protocol.reqInviteGame(param1, param2);
            return;
        }// end function

        public function reqInviteGameSelect(param1:long, param2:long, param3:Boolean) : void
        {
            this._protocol.reqInviteGameSelect(param1, param2, param3);
            return;
        }// end function

        public function reqMapSearchPlayerInfoGame(param1:String) : void
        {
            this._protocol.reqMapSearchPlayerInfoGame(param1);
            return;
        }// end function

        public function reqMapSearchTeamInfoGame() : void
        {
            this._protocol.reqMapSearchTeamInfoGame();
            return;
        }// end function

        public function reqToLeaveGame(param1:long, param2:int) : void
        {
            this._protocol.reqToLeaveGame(param1, param2);
            return;
        }// end function

        public function reqUpdateTeamInfoGame(param1:long) : void
        {
            this._protocol.reqUpdateTeamInfoGame(param1);
            return;
        }// end function

        public static function getInstance() : TeamControl
        {
            if (!_instance)
            {
                _instance = new TeamControl;
            }
            return _instance;
        }// end function

    }
}
