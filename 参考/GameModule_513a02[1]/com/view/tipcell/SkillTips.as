package com.view.tipcell
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.text.*;

    public class SkillTips extends BaseTips
    {
        private var _backBmp:Sprite;
        private var _iconBgBmp:Sprite;
        private var _txtName:TextField;
        private var _txtType:TextField;
        private var _icon:Image;
        private var _txtCDTime:TextField;
        private var _txtNeed:TextField;
        private var _excisionLine:Bitmap;
        private var _txtDescribe:TextField;
        private var _content:Sprite;

        public function SkillTips()
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
            this._txtName.width = 120;
            this._txtName.height = 20;
            this._txtName.x = this._iconBgBmp.x + this._iconBgBmp.width + 5;
            this._content.addChild(this._txtName);
            this._txtType = new TextField();
            this._txtType.x = this._txtName.x + this._txtName.width + 41;
            this._txtType.y = this._txtName.y + 2;
            this._txtType.width = 40;
            this._txtType.textColor = 9633981;
            this._content.addChild(this._txtType);
            this._txtCDTime = new TextField();
            this._txtCDTime.x = this._txtName.x;
            this._txtCDTime.y = this._iconBgBmp.y + this._iconBgBmp.width - 15;
            this._txtCDTime.textColor = 16711680;
            this._content.addChild(this._txtCDTime);
            this._txtNeed = new TextField();
            this._txtNeed.width = 90;
            this._txtNeed.x = this._txtCDTime.x + this._txtCDTime.width - 10;
            this._txtNeed.y = this._txtCDTime.y;
            this._txtNeed.textColor = 16711680;
            this._content.addChild(this._txtNeed);
            this._excisionLine = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine.x = 0;
            this._excisionLine.y = this._iconBgBmp.y + this._iconBgBmp.height + 10;
            this._content.addChild(this._excisionLine);
            this._txtDescribe = new TextField();
            this._txtDescribe.defaultTextFormat = new TextFormat("SimSun", 12, 16777215);
            this._txtDescribe.multiline = true;
            this._txtDescribe.wordWrap = true;
            this._txtDescribe.width = 250;
            this._txtDescribe.y = this._excisionLine.y + 10;
            this._content.addChild(this._txtDescribe);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!param1)
            {
                return;
            }
            if (param1 is SkillInfo)
            {
                _loc_2 = param1 as SkillInfo;
                this._txtName.htmlText = "<font color = \'#fff600\' size = \'14\'><b>" + _loc_2.q_skillName + "</b></font>";
                this._icon.load(_loc_2.iconUrl);
                this._txtType.htmlText = "<p align = \'right\'>" + SkillType.getName(_loc_2.q_brief_skill_type) + "</p>";
                this._txtNeed.htmlText = "<p align = \'right\'><font color = \'#ffffff\'>" + LanguageCfgObj.getInstance().getByIndex("11820") + ": <font color = \'#3cff00\'>" + _loc_2.q_need_mp + "</font></font></p>";
                this._txtCDTime.htmlText = "<font color = \'#ffffff\'>CD: <font color = \'#3cff00\'>" + _loc_2.q_cd / 1000 + "</font> 秒</font>";
                this._txtDescribe.htmlText = "<p><textformat  leading=\'3\'>" + _loc_2.q_tips + "</textformat></p>";
                this._txtDescribe.height = this._txtDescribe.textHeight + 4;
                this._backBmp.height = this._txtDescribe.y + this._txtDescribe.height + this._content.y * 2;
                this._backBmp.width = this._content.width + 32;
            }
            else if (param1 is MagicBookSkillInfo)
            {
                _loc_3 = param1 as MagicBookSkillInfo;
                this._txtName.htmlText = "<font color = \'#fff600\' size = \'14\'><b>" + _loc_3.skillname + "</b></font>";
                this._icon.load(_loc_3.iconUrl);
                this._txtType.htmlText = "<p align = \'right\'>" + "远程" + "</p>";
                this._txtType.visible = false;
                this._txtNeed.htmlText = "<p align = \'right\'><font color = \'#ffffff\'>" + "魔法" + ": <font color = \'#3cff00\'>" + "19999" + "</font></font></p>";
                this._txtNeed.visible = false;
                this._txtCDTime.htmlText = "<font color = \'#ffffff\'>CD: <font color = \'#3cff00\'>" + _loc_3.skill_cd + "</font> 秒</font>";
                this._txtDescribe.htmlText = "<p><textformat  leading=\'3\'>" + _loc_3.tips + "</textformat></p>";
                this._txtDescribe.height = this._txtDescribe.textHeight + 4;
                this._backBmp.height = this._content.height + 13;
                this._backBmp.width = this._content.width + 32;
            }
            return;
        }// end function

    }
}
