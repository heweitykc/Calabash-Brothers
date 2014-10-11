package com.game.team.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.role.*;
    import com.game.role.util.*;
    import com.game.role.view.*;
    import com.game.team.bean.*;
    import com.game.team.control.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import interfaces.role.*;

    public class TeamPhotoItem extends ListItemBase
    {
        private var txtPlayerName:TextField;
        private var txtPlayerJob:TextField;
        private var captainSign:Sprite;
        private var btnFun:BaseButton;
        private var _info:TeamMemberInfo;
        private var _state:String = "none";
        private var playerPhoto:RoleView;
        private var player:PlayerInfo;
        private var delayFly:uint;
        private var isICaptain:Boolean;
        private var mcPlayerFar:Sprite;
        private var txtPlayerLine:TextField;
        private var txtLevIcon:RoleLevelIcon;
        public static const STATE_NONE:String = "none";
        public static const STATE_SELF:String = "self";
        public static const STATE_OTHER:String = "other";

        public function TeamPhotoItem()
        {
            super("memberPhotoCue");
            this.mouseEnabled = false;
            this.mouseChildren = true;
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            super.index = param1;
            this.setCaptainSign(param1 == 0 ? (true) : (false));
            return;
        }// end function

        private function get state() : String
        {
            return this._state;
        }// end function

        private function set state(param1:String) : void
        {
            this._state = param1;
            this.freshState();
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            this.freshItem();
            return;
        }// end function

        override protected function addEvents() : void
        {
            super.addEvents();
            this.btnFun.addEventListener(MouseEvent.CLICK, this.clickBtnFun);
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (this.playerPhoto)
            {
                this.playerPhoto.unShine();
            }
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (this.playerPhoto)
            {
                this.playerPhoto.shine();
            }
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txtPlayerJob = _content.getChildByName("playerJob") as TextField;
            this.txtPlayerName = _content.getChildByName("playerName") as TextField;
            this.mcPlayerFar = _content.getChildByName("mc_player_far") as Sprite;
            this.txtPlayerLine = _content.getChildByName("txt_player_line") as TextField;
            this.captainSign = _content["captainSign"] as Sprite;
            this.btnFun = new BaseButton(_content.getChildByName("btnFun"));
            this.mcPlayerFar.visible = false;
            this.txtLevIcon = new RoleLevelIcon();
            this.txtLevIcon.x = this.txtPlayerJob.x + 32;
            this.txtLevIcon.y = this.txtPlayerJob.y + 25;
            this.txtLevIcon.afterLv = "级";
            this.txtPlayerJob.parent.addChild(this.txtLevIcon);
            return;
        }// end function

        override protected function freshItem() : void
        {
            if (!this.info)
            {
                this.state = STATE_NONE;
                this.clean();
                return;
            }
            this.txtPlayerName.text = this.info.membername;
            var _loc_1:* = this.info.memberlevel;
            if (RoleLevelUtil.isMasterLevel(_loc_1))
            {
                this.txtLevIcon.level = _loc_1;
            }
            else
            {
                this.txtLevIcon.level = 0;
            }
            var _loc_2:* = RoleLevelUtil.isMasterLevel(this.info.memberlevel) ? (400) : (this.info.memberlevel);
            this.txtPlayerJob.text = RoleInfo.getJobName(this.info.memberJob) + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11817"), [_loc_2]);
            var _loc_3:* = UserObj.getInstance().playerInfo.personId;
            if (this.info.memberid.equal(_loc_3))
            {
                this.state = STATE_SELF;
            }
            else
            {
                this.state = STATE_OTHER;
            }
            this.setPhoto();
            var _loc_4:* = TeamModel.getInstance().getSelfInfo();
            if (TeamModel.getInstance().getSelfInfo())
            {
                if (this._info.memberline != _loc_4.memberline)
                {
                    this.txtPlayerLine.text = "【" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12262"), [this._info.memberline]) + "】";
                    this.mcPlayerFar.visible = true;
                    this.playerPhoto.filters = [ColorFilter.getGrayFilter()];
                }
                else
                {
                    this.txtPlayerLine.text = "";
                    if (this.isInScreen())
                    {
                        this.playerPhoto.filters = [];
                        this.mcPlayerFar.visible = false;
                    }
                    else
                    {
                        this.playerPhoto.filters = [ColorFilter.getGrayFilter()];
                        this.mcPlayerFar.visible = true;
                    }
                }
            }
            return;
        }// end function

        private function isInScreen() : Boolean
        {
            var _loc_1:* = null;
            if (this._info && RoleList.getInstance().roles)
            {
                if (this._info.memberid.equal(UserObj.getInstance().playerInfo.personId))
                {
                    return true;
                }
                _loc_1 = RoleList.getInstance().getRole(this._info.memberid);
                if (_loc_1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        private function setPhoto() : void
        {
            if (!this.info)
            {
                return;
            }
            if (!this.player)
            {
                this.player = new PlayerInfo();
            }
            this.player.setTeamInfo(this.info);
            if (!this.playerPhoto)
            {
                this.playerPhoto = Global.roleFactory.creatRoleView(this.player) as RoleView;
                this.playerPhoto.move(83, 250);
                this.playerPhoto.auto = true;
                this.playerPhoto.direct = 135;
            }
            this.playerPhoto.setAct(Params.ACTION_SIMPLE_ATTACK_ID);
            if (!this.playerPhoto.parent)
            {
                this.addChild(this.playerPhoto);
                this.setChildIndex(this.playerPhoto, 0);
            }
            return;
        }// end function

        private function clickBtnFun(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(this._state)
            {
                case STATE_NONE:
                {
                    TeamControl.getInstance().openTeamInvitePanel();
                    break;
                }
                case STATE_OTHER:
                {
                    _loc_2 = this.info.memberid;
                    TeamControl.getInstance().reqToLeaveGame(_loc_2, 0);
                    break;
                }
                case STATE_SELF:
                {
                    _loc_2 = UserObj.getInstance().playerInfo.personId;
                    TeamControl.getInstance().reqToLeaveGame(_loc_2, 1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function freshState() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this.btnFun.visible = true;
            switch(this._state)
            {
                case STATE_NONE:
                {
                    this.btnFun.setText(LanguageCfgObj.getInstance().getByIndex("11359"), true);
                    break;
                }
                case STATE_OTHER:
                {
                    _loc_1 = TeamModel.getInstance().captainId;
                    _loc_2 = UserObj.getInstance().playerInfo.personId;
                    if (_loc_1.equal(_loc_2))
                    {
                        this.btnFun.setText(LanguageCfgObj.getInstance().getByIndex("11360"), true);
                    }
                    else
                    {
                        this.btnFun.visible = false;
                    }
                    break;
                }
                case STATE_SELF:
                {
                    this.btnFun.setText(LanguageCfgObj.getInstance().getByIndex("11361"), true);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setCaptainSign(param1:Boolean = false) : void
        {
            if (param1)
            {
                this.captainSign.visible = true;
            }
            else
            {
                this.captainSign.visible = false;
            }
            return;
        }// end function

        public function playPlayerFly() : void
        {
            this.delayFly = setTimeout(this.await, 3);
            return;
        }// end function

        private function await() : void
        {
            clearTimeout(this.delayFly);
            return;
        }// end function

        override public function clean() : void
        {
            this.txtPlayerName.text = "";
            this.txtPlayerJob.text = "";
            this.txtPlayerLine.text = "";
            this.txtLevIcon.level = 0;
            this.mcPlayerFar.visible = false;
            this._info = null;
            if (this.playerPhoto)
            {
                this.playerPhoto.finalize();
                this.playerPhoto = null;
            }
            return;
        }// end function

    }
}
