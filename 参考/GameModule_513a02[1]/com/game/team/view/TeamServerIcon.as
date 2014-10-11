package com.game.team.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.utils.cue.*;
    import com.game.role.util.*;
    import com.game.team.bean.*;
    import com.game.team.control.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class TeamServerIcon extends ServerHitIcon
    {
        private var back:MovieClip;
        private var countBack:Sprite;

        public function TeamServerIcon(param1:String)
        {
            super("teamServerHit");
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
            if (param1 == TeamServerPanel.TYPE_INVITE)
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
            var _loc_2:* = TeamMemberInfo(info);
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

        private function getTipsStr(param1:TeamMemberInfo) : String
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.type == TeamServerPanel.TYPE_JOIN)
            {
                if (this.count > 1)
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11362");
                }
                else
                {
                    _loc_3 = RoleLevelUtil.getMasterLevel(param1.memberlevel);
                    _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12263"), [param1.membername, _loc_3, RoleInfo.getJobName(param1.memberJob)]);
                }
            }
            else if (this.count > 1)
            {
                _loc_2 = LanguageCfgObj.getInstance().getByIndex("11363");
            }
            else
            {
                _loc_3 = RoleLevelUtil.getMasterLevel(param1.memberlevel);
                _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12264"), [param1.membername, _loc_3, RoleInfo.getJobName(param1.memberJob)]);
            }
            return _loc_2;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            TeamControl.getInstance().openTeamServerPanel(this.type);
            return;
        }// end function

    }
}
