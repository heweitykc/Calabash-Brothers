package com.game.guild.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import com.game.role.util.*;
    import com.game.role.view.*;
    import com.game.team.view.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.*;

    public class GuildServerItem extends ListItemBase implements IItem
    {
        private var headBack:Sprite;
        private var headIcon:Image;
        private var txtName:TextField;
        private var txtJob:TextField;
        private var txtLev:TextField;
        private var txtIcon:RoleLevelIcon;
        private var txtType:TextField;
        private var btnAccept:BaseButton;
        private var btnReject:BaseButton;
        private var _info:Message;
        private var type:String;
        public static const HEIGHT:int = 78;
        public static const WIDTH:int = 360;

        public function GuildServerItem()
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
            this.headIcon.move(2, 2);
            this.headBack.addChild(this.headIcon);
            this.txtName = _content.getChildByName("txtName") as TextField;
            this.txtJob = _content.getChildByName("txtJob") as TextField;
            this.txtLev = _content.getChildByName("txtLev") as TextField;
            this.txtIcon = new RoleLevelIcon();
            this.txtLev.parent.addChild(this.txtIcon);
            this.txtIcon.move(this.txtLev.x, this.txtLev.y);
            this.txtType = _content.getChildByName("txtType") as TextField;
            this.btnAccept = new BaseButton(_content.getChildByName("btnAccept")) as BaseButton;
            this.btnAccept.setText(LanguageCfgObj.getInstance().getByIndex("10853"));
            this.btnReject = new BaseButton(_content.getChildByName("btnReject")) as BaseButton;
            this.btnReject.setText(LanguageCfgObj.getInstance().getByIndex("10854"));
            return;
        }// end function

        override protected function freshItem() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (this.info is ResGuildApplyAddDoingToClientMessage)
            {
                this.type = GuildServerPanel.TYPE_JOIN;
                _loc_1 = this.info as ResGuildApplyAddDoingToClientMessage;
                this.txtJob.text = RoleInfo.getJobName(_loc_1.applyJob);
                this.txtLev.text = "";
                this.txtIcon.level = _loc_1.applyLevel;
                this.txtName.text = _loc_1.applyName;
                this.txtType.text = LanguageCfgObj.getInstance().getByIndex("10855");
                _loc_3 = _loc_1.applyJob;
                _loc_4 = _loc_1.applyLevel;
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
            if (this.info is ResGuildInviteAddDoingToClientMessage)
            {
                this.type = GuildServerPanel.TYPE_INVITE;
                _loc_5 = this.info as ResGuildInviteAddDoingToClientMessage;
                this.txtLev.text = "";
                this.txtIcon.level = _loc_5.inviteLevel;
                this.txtName.text = _loc_5.inviteName;
                this.txtType.text = LanguageCfgObj.getInstance().getByIndex("10856");
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
            var _loc_2:* = false;
            var _loc_3:* = null;
            var _loc_4:* = null;
            switch(event.target)
            {
                case this.btnAccept:
                {
                    _loc_2 = true;
                    break;
                }
                case this.btnReject:
                {
                    _loc_2 = false;
                    break;
                }
                default:
                {
                    return;
                    break;
                }
            }
            if (this.type == GuildServerPanel.TYPE_JOIN)
            {
                _loc_3 = this.info as ResGuildApplyAddDoingToClientMessage;
                GuildControl.getInstance().reqGuildAddMember(UserObj.getInstance().playerInfo.guildId, _loc_3.userId, _loc_2 ? (1) : (0));
                GuildControl.getInstance().guildServerPanel.removeInfoFromServer(this.info, this.type);
            }
            else if (this.type == GuildServerPanel.TYPE_INVITE)
            {
                _loc_4 = this.info as ResGuildInviteAddDoingToClientMessage;
                GuildControl.getInstance().reqGuildAddMember(_loc_4.guildId, _loc_4.inviteModeInfo.playerid, _loc_2 ? (1) : (0));
                GuildControl.getInstance().guildServerPanel.removeInfoFromServer(this.info, this.type);
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
