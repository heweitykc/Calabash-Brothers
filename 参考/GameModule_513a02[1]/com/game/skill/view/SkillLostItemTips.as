package com.game.skill.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.game.skill.model.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class SkillLostItemTips extends BaseTips
    {
        private var _content:MovieClip;
        private var _txtSkillName:TextField;
        private var _txtSkillLevel:TextField;
        private var _txtSkillState:TextField;
        private var _txtSkillEffect:TextField;
        private var _txtSkillNestLevel:TextField;
        private var _txtSkillNestEffect:TextField;
        private var _icon:Image;

        public function SkillLostItemTips()
        {
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            this._content = MovieClip(ToolKit.getNew("tips_lost_skill"));
            this.addChild(this._content);
            this._txtSkillName = TextField(this._content.getChildByName("txt_skill_name"));
            this._txtSkillLevel = TextField(this._content.getChildByName("txt_skill_level"));
            this._txtSkillState = TextField(this._content.getChildByName("txt_skill_state"));
            this._txtSkillEffect = TextField(this._content.getChildByName("txt_skill_att_added"));
            this._txtSkillNestLevel = TextField(this._content.getChildByName("txt_skill_nest_level"));
            this._txtSkillNestEffect = TextField(this._content.getChildByName("txt_skill_nest_att_added"));
            this._icon = new Image();
            this._icon.move(16, 18);
            this.addChild(this._icon);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1 as SkillPassiveInfo;
            this._icon.load(Params.SKILL_ICON_PATH + _loc_2.q_icon + ".png");
            this._txtSkillEffect.htmlText = _loc_2.q_info;
            this._txtSkillLevel.text = "Lv." + _loc_2.q_skill_level + "/" + _loc_2.q_skill_levelmax;
            this._txtSkillName.text = _loc_2.q_skill_name;
            if (_loc_2.q_skill_level < _loc_2.q_skill_levelmax)
            {
                _loc_3 = new SkillPassiveInfo();
                _loc_3.parse(SkillCfgObj.getInstance().getskillLostInfo((_loc_2.q_skill_id + 1)));
                if (_loc_3)
                {
                    this._txtSkillState.text = LanguageCfgObj.getInstance().getByIndex("11167");
                    this._txtSkillNestEffect.htmlText = _loc_3.q_info;
                    this._txtSkillNestLevel.text = "Lv." + _loc_3.q_skill_level + "/" + _loc_3.q_skill_levelmax;
                }
            }
            else
            {
                this._txtSkillNestEffect.text = LanguageCfgObj.getInstance().getByIndex("11168");
                this._txtSkillNestLevel.text = LanguageCfgObj.getInstance().getByIndex("11169");
                this._txtSkillState.text = LanguageCfgObj.getInstance().getByIndex("11169");
            }
            return;
        }// end function

    }
}
