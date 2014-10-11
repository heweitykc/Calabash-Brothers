package com.game.guild.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.guild.control.*;
    import com.game.guild.message.*;
    import com.game.role.util.*;
    import flash.display.*;
    import flash.events.*;
    import net.*;

    public class GuildServerIcon extends ServerHitIcon
    {
        private var back:MovieClip;
        private var countBack:Sprite;

        public function GuildServerIcon(param1:String)
        {
            super("guildServerHit");
            this.type = param1;
            return;
        }// end function

        override protected function getComp() : void
        {
            super.getComp();
            this.back = _content.getChildByName("back") as MovieClip;
            this.countBack = _content.getChildByName("countBack") as Sprite;
            return;
        }// end function

        override public function set type(param1:String) : void
        {
            _type = param1;
            if (param1 == GuildServerPanel.TYPE_INVITE)
            {
                this.back.gotoAndStop(1);
            }
            else
            {
                this.back.gotoAndStop(2);
            }
            return;
        }// end function

        override public function set count(param1:int) : void
        {
            _count = param1;
            _txtCount.text = param1.toString();
            if (param1 > 1)
            {
                _txtCount.visible = true;
                this.countBack.visible = true;
            }
            else
            {
                _txtCount.visible = false;
                this.countBack.visible = false;
            }
            var _loc_2:* = info;
            if (_loc_2)
            {
                this.tipsStr = this.getTipsStr(_loc_2);
            }
            return;
        }// end function

        override public function set tipsStr(param1:String) : void
        {
            _tipsStr = param1;
            StringTip.dispose(this);
            if (_tipsStr && _tipsStr != "")
            {
                StringTip.create(this, tipsStr);
            }
            return;
        }// end function

        private function getTipsStr(param1:Message) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.type == GuildServerPanel.TYPE_JOIN)
            {
                if (this.count > 1)
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10851");
                }
                else
                {
                    _loc_3 = RoleLevelUtil.getMasterLevel(ResGuildApplyAddDoingToClientMessage(param1).applyLevel);
                    _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12081"), [ResGuildApplyAddDoingToClientMessage(param1).applyName, _loc_3]);
                }
            }
            else if (this.count > 1)
            {
                _loc_2 = LanguageCfgObj.getInstance().getByIndex("10852");
            }
            else
            {
                _loc_3 = RoleLevelUtil.getMasterLevel(ResGuildInviteAddDoingToClientMessage(param1).inviteLevel);
                _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12082"), [ResGuildInviteAddDoingToClientMessage(param1).inviteName, _loc_3]);
            }
            return _loc_2;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            GuildControl.getInstance().openGuildServerPanel(this.type);
            return;
        }// end function

    }
}
