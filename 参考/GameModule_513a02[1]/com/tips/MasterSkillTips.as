package com.tips
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class MasterSkillTips extends BaseTips
    {
        private var _backBmp:Sprite;
        private var _iconBgBmp:Sprite;
        private var _txtName:TextField;
        private var _txtType:TextField;
        private var _icon:Image;
        private var _levelTxt:TextField;
        private var _excisionLine0:Bitmap;
        private var _txtDescribe:TextField;
        private var _excisionLine1:Bitmap;
        private var _nextLevelTxt:TextField;
        private var _nextDescribeTxt:TextField;
        private var _content:Sprite;

        public function MasterSkillTips()
        {
            this._backBmp = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backBmp);
            this._content = new Sprite();
            this._content.x = 13;
            this._content.y = 15;
            addChild(this._content);
            this._iconBgBmp = ToolKit.getNew("itemtipsborder");
            this._iconBgBmp.x = 0;
            this._iconBgBmp.y = 0;
            this._content.addChild(this._iconBgBmp);
            this._icon = new Image();
            this._icon.smoothing = true;
            this._icon.x = this._iconBgBmp.x + 3;
            this._icon.y = this._iconBgBmp.y + 3;
            this._content.addChild(this._icon);
            this._txtName = new TextField();
            this._txtName.width = 150;
            this._txtName.height = 20;
            this._txtName.x = this._iconBgBmp.x + this._iconBgBmp.width + 5;
            this._content.addChild(this._txtName);
            this._txtType = new TextField();
            this._txtType.defaultTextFormat = new TextFormat("SimSun", 12, 16711680);
            this._txtType.x = 196;
            this._txtType.y = 28;
            this._txtType.width = 40;
            this._txtType.text = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1405993150", "lang_masterSkill");
            this._content.addChild(this._txtType);
            this._levelTxt = new TextField();
            this._levelTxt.defaultTextFormat = new TextFormat("SimSun", 12, 16766079);
            this._levelTxt.x = 85;
            this._levelTxt.y = 40;
            this._levelTxt.width = 80;
            this._levelTxt.height = 21;
            this._content.addChild(this._levelTxt);
            this._excisionLine0 = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine0.x = 0;
            this._excisionLine0.y = this._iconBgBmp.y + this._iconBgBmp.height + 10;
            this._content.addChild(this._excisionLine0);
            this._txtDescribe = new TextField();
            this._txtDescribe.defaultTextFormat = new TextFormat("SimSun", 12, 16777215, null, null, null, null, null, null, null, null, null, 5);
            this._txtDescribe.multiline = true;
            this._txtDescribe.wordWrap = true;
            this._txtDescribe.width = 250;
            this._txtDescribe.x = 5;
            this._txtDescribe.y = this._excisionLine0.y + 10;
            this._content.addChild(this._txtDescribe);
            this._excisionLine1 = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine1.x = 0;
            this._excisionLine1.y = this._txtDescribe.y + this._txtDescribe.textHeight + 10;
            this._content.addChild(this._excisionLine1);
            this._nextLevelTxt = new TextField();
            this._nextLevelTxt.defaultTextFormat = new TextFormat("SimSun", 12, 16766079);
            this._nextLevelTxt.x = 5;
            this._nextLevelTxt.y = this._excisionLine1.y + 10;
            this._nextLevelTxt.width = 150;
            this._nextLevelTxt.height = 20;
            this._content.addChild(this._nextLevelTxt);
            this._nextDescribeTxt = new TextField();
            this._nextDescribeTxt.defaultTextFormat = new TextFormat("SimSun", 12, 16777215, null, null, null, null, null, null, null, null, null, 5);
            this._nextDescribeTxt.multiline = true;
            this._nextDescribeTxt.wordWrap = true;
            this._nextDescribeTxt.width = 250;
            this._nextDescribeTxt.x = 5;
            this._nextDescribeTxt.y = this._nextLevelTxt.y + 30;
            this._content.addChild(this._nextDescribeTxt);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = 0;
            var _loc_5:* = null;
            var _loc_2:* = param1 as MasterSkillVO;
            if (!_loc_2)
            {
                return;
            }
            _loc_3 = 0;
            this._txtName.htmlText = "<font color = \'#fff600\' size = \'14\'><b>" + _loc_2.cfg.q_name + "</b></font>";
            this._icon.load(_loc_2.url);
            if (_loc_2.level == 0)
            {
                this._levelTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1405993169", "lang_masterSkill");
            }
            else
            {
                this._levelTxt.htmlText = StringUtil.formatString("LV: {0}/{1}", _loc_2.level, _loc_2.cfg.q_max_level);
            }
            if (_loc_2.level == 0)
            {
                _loc_5 = MasterSkillObj.instance.getInfoByIdAndLevel(_loc_2.skillId, _loc_2.cfg.q_max_level);
                this._txtDescribe.htmlText = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1405993174", "lang_masterSkill") + _loc_5.q_desc;
            }
            else
            {
                this._txtDescribe.htmlText = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1407570314", "lang_masterSkill") + _loc_2.cfg.q_desc;
            }
            this._txtDescribe.height = this._txtDescribe.textHeight + 4;
            _loc_3 = this._txtDescribe.y + this._txtDescribe.height;
            _loc_3 = _loc_3 + 5;
            this._excisionLine1.y = _loc_3;
            _loc_3 = _loc_3 + 10;
            var _loc_4:* = MasterSkillObj.instance.getInfoByIdAndLevel(_loc_2.skillId, (_loc_2.level + 1));
            this._nextLevelTxt.y = _loc_3;
            if (_loc_4)
            {
                this._nextLevelTxt.htmlText = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1405993180", "lang_masterSkill"), StringUtil.formatString("<font color=\'#00ff00\'>LV:{0}/{1}</font>", (_loc_2.level + 1), _loc_2.cfg.q_max_level));
            }
            else
            {
                this._nextLevelTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1405993187", "lang_masterSkill");
            }
            _loc_3 = _loc_3 + this._nextLevelTxt.height;
            _loc_3 = _loc_3 + 5;
            this._nextDescribeTxt.y = _loc_3;
            if (_loc_4)
            {
                this._nextDescribeTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("MasterSkillTips_1407570314", "lang_masterSkill") + _loc_4.q_desc;
            }
            else
            {
                this._nextDescribeTxt.text = "";
            }
            this._nextDescribeTxt.height = this._nextDescribeTxt.textHeight + 4;
            this._backBmp.height = this._content.height + 24;
            this._backBmp.width = this._content.width + 32;
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            return;
        }// end function

    }
}
