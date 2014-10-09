package com.game.guild.chat
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.game.guild.model.*;
    import com.game.guild.view.*;
    import com.game.player.view.*;
    import com.game.role.util.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GuildChatMemberItem extends BaseButton implements IItem
    {
        private var txt_name:TextField;
        private var txt_level:TextField;
        private var mc_paopao:MovieClip;
        private var mc_vip:MovieClip;
        private var mc_highvip:MovieClip;
        private var bg:MovieClip;
        private var img:DisplayObject;
        private var _image:PlayerImage;
        private var _info:Object;

        public function GuildChatMemberItem(param1:String = "guildChatMemberItem")
        {
            super(param1);
            this.txt_name = getDisplayChildByName("txt_name");
            this.txt_name.selectable = false;
            this.txt_level = getDisplayChildByName("txt_level");
            this.txt_level.selectable = false;
            this.mc_paopao = getDisplayChildByName("mc_paopao");
            this.mc_paopao.visible = false;
            this.mc_vip = getDisplayChildByName("mc_vip");
            this.mc_highvip = getDisplayChildByName("mc_highvip");
            this.bg = getDisplayChildByName("bg");
            this.img = getDisplayChildByName("img");
            this._image = new PlayerImage();
            this._image.x = this.mc_paopao.x + 7;
            this._image.y = this.mc_paopao.y + 8;
            this.getDisplay().addChildAt(this._image, (getDisplay().getChildIndex(this.img) + 1));
            return;
        }// end function

        override public function get key()
        {
            return _obj.label;
        }// end function

        public function set select(param1:Boolean) : void
        {
            if (param1)
            {
                this.bg.gotoAndStop(3);
            }
            else
            {
                this.bg.gotoAndStop(1);
            }
            this.selected = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(obj, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    addEvtListener(MouseEvent.MOUSE_OVER, this.__moveItem);
                    addEvtListener(MouseEvent.MOUSE_OUT, this.__outItem);
                    addEvtListener(MouseEvent.CLICK, this.__click);
                    addEvtListener("rightClick", this.__click);
                    addEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                    if (this._image)
                    {
                        _loc_5 = this._info.level;
                        if (RoleLevelUtil.isMasterLevel(_loc_5))
                        {
                            _loc_4 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((this._info.job - 1) % 3 + 1) + "-4.png";
                        }
                        else
                        {
                            _loc_4 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((this._info.job - 1) % 3 + 1) + ".png";
                        }
                        this._image.setUrl(_loc_4);
                        this._image.setSize(40, 40);
                    }
                    this.txt_name.text = this._info.userName;
                    this.txt_level.text = GuildData.getInstance().getGuildPowerName(this._info.guildPowerLevel);
                    _loc_3 = this._info.vipStageLevel;
                    if (_loc_3 != VipType.NORMAL && _loc_3 < VipType.TOP_LEVEL)
                    {
                        this.mc_vip.visible = true;
                        this.mc_highvip.visible = false;
                    }
                    else if (_loc_3 == VipType.TOP_LEVEL)
                    {
                        this.mc_vip.visible = false;
                        this.mc_highvip.visible = true;
                    }
                    if (this._info.vipLevel >= 1)
                    {
                        this.mc_vip.gotoAndStop(this._info.vipLevel);
                        this.mc_highvip.gotoAndStop(this._info.vipLevel);
                        this.txt_name.x = 88;
                    }
                    else
                    {
                        this.mc_vip.visible = false;
                        this.mc_highvip.visible = false;
                        this.txt_name.x = 58;
                    }
                    if (this._info.lastOnlineTime == 0)
                    {
                        this.filters = null;
                    }
                    else
                    {
                        this.filters = [FrameworkGlobal.colorMat];
                    }
                }
                else
                {
                    removeEvtListener(MouseEvent.CLICK, this.__click);
                    removeEvtListener("rightClick", this.__click);
                    removeEvtListener(MouseEvent.DOUBLE_CLICK, this.__click);
                }
            }
            return;
        }// end function

        private function __moveItem(event:MouseEvent) : void
        {
            if (this.bg && !selected)
            {
                this.bg.gotoAndStop(2);
            }
            return;
        }// end function

        private function __outItem(event:MouseEvent) : void
        {
            if (this.bg && !selected)
            {
                this.bg.gotoAndStop(1);
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = new PlayerInfo();
            _loc_2.personId = this.info.userId;
            _loc_2.name = this.info.userName;
            GuildPlayerOptPopMenu.getInstance().show(_loc_2, this.parent.parent, GuildPlayerOptPopMenu.GUILD);
            GuildData.getInstance().openOrigin = 2;
            return;
        }// end function

    }
}
