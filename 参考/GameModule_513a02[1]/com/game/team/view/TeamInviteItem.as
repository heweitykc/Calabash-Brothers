package com.game.team.view
{
    import com.f1.interfaces.ui.list.*;
    import com.game.role.view.*;
    import com.game.team.bean.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.text.*;

    public class TeamInviteItem extends ListItemBase implements IItem
    {
        private var txtPlayerName:TextField;
        private var txtPlayerJob:TextField;
        private var txtPlayerLev:TextField;
        private var txtPlayerLevIcon:RoleLevelIcon;
        private var _info:MapPlayerInfo;
        private var hasTeamSign:Sprite;
        private var _hasTeam:Boolean;

        public function TeamInviteItem()
        {
            super("inviteMemberCue");
            return;
        }// end function

        public function get hasTeam() : Boolean
        {
            return this._hasTeam;
        }// end function

        public function set hasTeam(param1:Boolean) : void
        {
            this._hasTeam = param1;
            this.showOrHideSign();
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            if (this._info)
            {
                this.freshItem();
            }
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txtPlayerJob = _content.getChildByName("txtPlayerJob") as TextField;
            this.txtPlayerLev = _content.getChildByName("txtPlayerLev") as TextField;
            this.txtPlayerLev.visible = false;
            this.txtPlayerLevIcon = new RoleLevelIcon();
            this.txtPlayerLevIcon.x = this.txtPlayerLev.x - 17;
            this.txtPlayerLevIcon.y = this.txtPlayerLev.y;
            this.txtPlayerLevIcon.textColor = this.txtPlayerLev.textColor;
            _content.addChild(this.txtPlayerLevIcon);
            this.txtPlayerName = _content.getChildByName("txtPlayerName") as TextField;
            this.hasTeamSign = _content.getChildByName("hasTeamSign") as Sprite;
            mcBack = _content.getChildByName("back") as MovieClip;
            return;
        }// end function

        override protected function freshItem() : void
        {
            this.txtPlayerName.text = this.info.playername.toString();
            this.txtPlayerLev.text = this.info.playerlv.toString();
            this.txtPlayerLevIcon.level = this.info.playerlv;
            this.txtPlayerJob.text = RoleInfo.getJobName(this.info.playerJob);
            this.hasTeam = this.info.teamstate == 1 ? (true) : (false);
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            this.txtPlayerJob.textColor = param1;
            this.txtPlayerLev.textColor = param1;
            this.txtPlayerLevIcon.textColor = param1;
            this.txtPlayerName.textColor = param1;
            return;
        }// end function

        private function showOrHideSign() : void
        {
            if (this._hasTeam)
            {
                this.hasTeamSign.visible = true;
            }
            else
            {
                this.hasTeamSign.visible = false;
            }
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function set obj(param1) : void
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
