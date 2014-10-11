package com.game.team.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.player.control.*;
    import com.game.team.bean.*;
    import com.game.team.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.model.*;
    import flash.events.*;

    public class TeamFunList extends Component
    {
        private var btnScanDetail:BaseButton;
        private var btnDeliverCaptain:BaseButton;
        private var _info:TeamMemberInfo;
        private static var _instance:TeamFunList;

        public function TeamFunList()
        {
            super("teamFunctionList");
            this.initUI();
            this.addEvents();
            return;
        }// end function

        public function get info() : TeamMemberInfo
        {
            return this._info;
        }// end function

        public function set info(param1:TeamMemberInfo) : void
        {
            this._info = param1;
            this.setList();
            return;
        }// end function

        private function setList() : void
        {
            var _loc_1:* = TeamModel.getInstance().captainId;
            var _loc_2:* = UserObj.getInstance().playerInfo.personId;
            if (_loc_1.equal(_loc_2))
            {
                this.btnDeliverCaptain.visible = true;
            }
            else
            {
                this.btnDeliverCaptain.visible = false;
            }
            return;
        }// end function

        private function initUI() : void
        {
            this.btnScanDetail = new BaseButton(getDisplayChildByName("btnScanDetail"));
            this.btnScanDetail.setText(LanguageCfgObj.getInstance().getByIndex("11345"));
            this.btnDeliverCaptain = new BaseButton(getDisplayChildByName("btnDeliverCaptain"));
            this.btnDeliverCaptain.setText(LanguageCfgObj.getInstance().getByIndex("11346"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.btnDeliverCaptain:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.teamId;
                    TeamControl.getInstance().reqAppointGame(_loc_2, this.info.memberid);
                    break;
                }
                case this.btnScanDetail:
                {
                    PlayerControl.getInstance().reqForPlayer(this.info.memberid);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : TeamFunList
        {
            if (!_instance)
            {
                _instance = new TeamFunList;
            }
            return _instance;
        }// end function

    }
}
