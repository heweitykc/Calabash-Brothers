package com.game.team.view
{
    import com.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.game.role.util.*;
    import com.game.role.view.*;
    import com.game.team.control.*;
    import com.game.team.message.*;
    import com.game.team.model.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.*;

    public class TeamServerItem extends ListItemBase implements IItem
    {
        private var headBack:Sprite;
        private var headIcon:Image;
        private var txtName:TextField;
        private var txtJob:TextField;
        private var txtLev:TextField;
        private var txtLevIcon:RoleLevelIcon;
        private var txtType:TextField;
        private var btnAccept:BaseButton;
        private var btnReject:BaseButton;
        private var _info:Message;
        private var type:String;
        public static const HEIGHT:int = 78;
        public static const WIDTH:int = 360;

        public function TeamServerItem()
        {
            super("teamServerCue");
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

        override protected function getComp() : void
        {
            this.headIcon = new Image();
            this.headBack = _content.getChildByName("headBack") as Sprite;
            this.headBack.addChild(this.headIcon);
            this.txtName = _content.getChildByName("txtName") as TextField;
            this.txtJob = _content.getChildByName("txtJob") as TextField;
            this.txtLev = _content.getChildByName("txtLev") as TextField;
            this.txtLevIcon = new RoleLevelIcon();
            this.txtLevIcon.x = this.txtLev.x;
            this.txtLevIcon.y = this.txtLev.y;
            this.txtLevIcon.textColor = this.txtLev.textColor;
            _content.addChild(this.txtLevIcon);
            this.txtType = _content.getChildByName("txtType") as TextField;
            this.btnAccept = new BaseButton(_content.getChildByName("btnAccept")) as BaseButton;
            this.btnAccept.setText(LanguageCfgObj.getInstance().getByIndex("11364"));
            this.btnReject = new BaseButton(_content.getChildByName("btnReject")) as BaseButton;
            this.btnReject.setText(LanguageCfgObj.getInstance().getByIndex("11365"));
            return;
        }// end function

        override protected function freshItem() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (this.info is ResApplyClientMessage)
            {
                this.type = TeamServerPanel.TYPE_JOIN;
                _loc_1 = this.info as ResApplyClientMessage;
                this.txtJob.text = RoleInfo.getJobName(_loc_1.newmemberinfo.memberJob);
                this.txtLev.text = "";
                this.txtLevIcon.level = _loc_1.newmemberinfo.memberlevel;
                this.txtName.text = _loc_1.newmemberinfo.membername;
                this.txtType.text = LanguageCfgObj.getInstance().getByIndex("11366");
                _loc_2 = Params.ROLE_HEAD_PANEL_PATH + "job" + _loc_1.newmemberinfo.memberJob + ".png";
                _loc_3 = _loc_1.newmemberinfo.memberJob;
                _loc_4 = _loc_1.newmemberinfo.memberlevel;
                if (RoleLevelUtil.isMasterLevel(_loc_4))
                {
                    _loc_2 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((_loc_3 - 1) % 3 + 1) + "-4.png";
                }
                else
                {
                    _loc_2 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((_loc_3 - 1) % 3 + 1) + ".png";
                }
                this.headIcon.load(_loc_2);
                this.headIcon.setSize(58, 58);
            }
            if (this.info is ResInviteClientMessage)
            {
                this.type = TeamServerPanel.TYPE_INVITE;
                _loc_5 = this.info as ResInviteClientMessage;
                this.txtJob.text = RoleInfo.getJobName(_loc_5.captaininfo.memberJob);
                this.txtLev.text = "";
                this.txtLevIcon.level = _loc_5.captaininfo.memberlevel;
                this.txtName.text = _loc_5.captaininfo.membername;
                this.txtType.text = LanguageCfgObj.getInstance().getByIndex("11367");
                _loc_4 = _loc_5.captaininfo.memberlevel;
                _loc_3 = _loc_5.captaininfo.memberJob;
                if (RoleLevelUtil.isMasterLevel(_loc_4))
                {
                    _loc_2 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((_loc_3 - 1) % 3 + 1) + "-4.png";
                }
                else
                {
                    _loc_2 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((_loc_3 - 1) % 3 + 1) + ".png";
                }
                this.headIcon.load(_loc_2);
                this.headIcon.setSize(58, 58);
            }
            return;
        }// end function

        override protected function addEvents() : void
        {
            super.addEvents();
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnAccept:
                {
                    this.sendMessage(true);
                    break;
                }
                case this.btnReject:
                {
                    this.sendMessage(false);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function sendMessage(param1:Boolean) : void
        {
            var callYesBack:Function;
            var callNoBack:Function;
            var msg1:ResApplyClientMessage;
            var teamId:long;
            var str:String;
            var msg2:ResInviteClientMessage;
            var isAgree:* = param1;
            callYesBack = function (... args) : void
            {
                args = info as ResInviteClientMessage;
                TeamControl.getInstance().reqInviteGameSelect(args.teamid, args.captaininfo.memberid, true);
                TeamControl.getInstance().removeInfoFromServer(info, type);
                return;
            }// end function
            ;
            callNoBack = function (... args) : void
            {
                args = info as ResInviteClientMessage;
                TeamControl.getInstance().reqInviteGameSelect(args.teamid, args.captaininfo.memberid, false);
                TeamControl.getInstance().removeInfoFromServer(info, type);
                return;
            }// end function
            ;
            if (this.type == TeamServerPanel.TYPE_JOIN)
            {
                msg1 = this.info as ResApplyClientMessage;
                TeamControl.getInstance().reqApplyGameSelect(msg1.teamid, msg1.newmemberinfo.memberid, isAgree);
                TeamControl.getInstance().removeInfoFromServer(this.info, this.type);
            }
            else if (this.type == TeamServerPanel.TYPE_INVITE)
            {
                teamId = TeamModel.getInstance().teamId;
                if (teamId && !(teamId.high == 0 && teamId.low == 0) && isAgree)
                {
                    str = LanguageCfgObj.getInstance().getByIndex("11368");
                    Global.popManager.cue(str, "", [this.info], callYesBack, callNoBack, 2, [LanguageCfgObj.getInstance().getByIndex("12087"), LanguageCfgObj.getInstance().getByIndex("11365")]);
                }
                else
                {
                    msg2 = this.info as ResInviteClientMessage;
                    TeamControl.getInstance().reqInviteGameSelect(msg2.teamid, msg2.captaininfo.memberid, isAgree);
                    TeamControl.getInstance().removeInfoFromServer(this.info, this.type);
                }
            }
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
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
