package com.game.skill.view
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.skill.model.*;
    import com.model.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.text.*;

    public class SkillLostUpTips extends BaseTips
    {
        private var _ruleX:Number = 17;
        private var _ruleY:Number = 16;
        private var _back:Sprite;
        private var _txtSkillName:TextField;
        private var _txtSkillNeedLabel:TextField;
        private var _txtSkillNeedInfo:TextField;
        private var _line1:DisplayObject;
        private var _txtActLevel:TextField;
        private var _txtActEffect:TextField;
        private var _info:Object;

        public function SkillLostUpTips()
        {
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            this._back = ToolKit.getNew("generalHoverWndBg");
            this.addChild(this._back);
            this._txtSkillName = new TextField();
            this.addChild(this._txtSkillName);
            this._txtSkillNeedLabel = new TextField();
            this.addChild(this._txtSkillNeedLabel);
            this._txtSkillNeedInfo = new TextField();
            this.addChild(this._txtSkillNeedInfo);
            this._line1 = ToolKit.getNewDO("excisionLine") as Bitmap;
            this.addChild(this._line1);
            this._txtActLevel = new TextField();
            this.addChild(this._txtActLevel);
            this._txtActEffect = new TextField();
            this.addChild(this._txtActEffect);
            return;
        }// end function

        private function drawSkillName(param1:String) : void
        {
            this._txtSkillName.width = 215;
            this._txtSkillName.htmlText = param1;
            this._txtSkillName.height = this._txtSkillName.textHeight + 5;
            this._txtSkillName.x = this._ruleX;
            this._txtSkillName.y = this._ruleY;
            this._ruleY = this._ruleY + this._txtSkillName.height;
            return;
        }// end function

        private function drawSkillNeedLabel(param1:String) : void
        {
            this._txtSkillNeedLabel.width = 215;
            this._txtSkillNeedLabel.htmlText = param1;
            this._txtSkillNeedLabel.height = this._txtSkillNeedLabel.textHeight + 5;
            this._txtSkillNeedLabel.x = this._ruleX;
            this._txtSkillNeedLabel.y = this._ruleY;
            this._ruleY = this._ruleY + this._txtSkillNeedLabel.height + 3;
            this._ruleX = 41;
            return;
        }// end function

        private function drawSkillNeedInfo(param1:String) : void
        {
            this._txtSkillNeedInfo.multiline = true;
            this._txtSkillNeedInfo.wordWrap = true;
            this._txtSkillNeedInfo.width = 215 - 24;
            this._txtSkillNeedInfo.htmlText = param1;
            this._txtSkillNeedInfo.height = this._txtSkillNeedInfo.textHeight + 5;
            this._txtSkillNeedInfo.x = this._ruleX;
            this._txtSkillNeedInfo.y = this._ruleY;
            this._ruleY = this._ruleY + this._txtSkillNeedInfo.height + 5;
            this._ruleX = 10;
            return;
        }// end function

        private function drawLine1() : void
        {
            this._line1.x = this._ruleX;
            this._line1.y = this._ruleY;
            this._ruleX = 17;
            this._ruleY = this._ruleY + this._line1.height + 5;
            return;
        }// end function

        private function drawActLevel(param1:String) : void
        {
            this._txtActLevel.width = 215;
            this._txtActLevel.htmlText = param1;
            this._txtActLevel.height = this._txtSkillNeedLabel.textHeight + 5;
            this._txtActLevel.x = this._ruleX;
            this._txtActLevel.y = this._ruleY;
            this._ruleY = this._ruleY + this._txtActLevel.height;
            this._ruleX = 17;
            return;
        }// end function

        private function drawActEffect(param1:String) : void
        {
            this._txtActEffect.multiline = true;
            this._txtActEffect.wordWrap = true;
            this._txtActEffect.width = 215;
            this._txtActEffect.htmlText = param1;
            this._txtActEffect.height = this._txtSkillNeedLabel.textHeight + 5;
            this._txtActEffect.x = this._ruleX;
            this._txtActEffect.y = this._ruleY;
            this._ruleY = this._ruleY + this._txtActEffect.height;
            this._ruleX = 17;
            return;
        }// end function

        private function drawBack() : void
        {
            this._back.width = 240;
            this._back.height = this._ruleY + 10;
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this._info = param1;
            var _loc_2:* = param1 as SkillPassiveInfo;
            var _loc_4:* = SkillCfgObj.getInstance().getskillLostInfo((param1.q_skill_id + 1));
            if (SkillCfgObj.getInstance().getskillLostInfo((param1.q_skill_id + 1)))
            {
                _loc_3 = new SkillPassiveInfo();
                _loc_3.parse(_loc_4);
            }
            var _loc_5:* = LanguageCfgObj.getInstance().getByIndex("11171");
            var _loc_6:* = _loc_5.replace("^_^", _loc_2.q_skill_name);
            _loc_6 = _loc_6.replace("v_v", "Lv." + _loc_2.skillLevel);
            this.drawSkillName(_loc_6);
            if (_loc_3)
            {
                _loc_7 = LanguageCfgObj.getInstance().getByIndex("11172");
                this.drawSkillNeedLabel(_loc_7);
                _loc_8 = this.getNeedStr(_loc_3);
                _loc_8 = "<TextFormat leading = \'3\'>" + _loc_8 + "</TextFormat>";
                this.drawSkillNeedInfo(_loc_8);
            }
            this.drawLine1();
            if (_loc_3)
            {
                _loc_9 = LanguageCfgObj.getInstance().getByIndex("11173");
                _loc_10 = "Lv." + _loc_3.q_skill_level + "/" + _loc_3.q_skill_levelmax;
                _loc_10 = _loc_9.replace("^_^", _loc_10);
                this.drawActLevel(_loc_10);
                _loc_11 = _loc_3.q_info;
                this.drawActEffect(_loc_11);
            }
            this.drawBack();
            this._ruleX = 17;
            this._ruleY = 16;
            return;
        }// end function

        private function getNeedStr(param1:SkillPassiveInfo) : String
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_2:* = "";
            var _loc_3:* = UserObj.getInstance().playerInfo.level;
            if (_loc_3 >= param1.q_need_level)
            {
                _loc_2 = "<font color = \'#66cc00\'>" + LanguageCfgObj.getInstance().getByIndex("12198") + param1.q_need_level + LanguageCfgObj.getInstance().getByIndex("11516") + "</font><br>";
            }
            else
            {
                _loc_2 = "<font color = \'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12198") + param1.q_need_level + LanguageCfgObj.getInstance().getByIndex("11517") + "</font><br>";
            }
            var _loc_4:* = param1.q_need_info;
            var _loc_5:* = _loc_4.split(";");
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5.length)
            {
                
                _loc_7 = String(_loc_5[_loc_6]).split("_");
                if (_loc_7[0] == "-1")
                {
                    _loc_8 = UserObj.getInstance().playerInfo.money;
                    if (_loc_8 < int(_loc_7[1]))
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12199") + _loc_7[1] + LanguageCfgObj.getInstance().getByIndex("11517") + "</font><br>");
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#66cc00\'>" + LanguageCfgObj.getInstance().getByIndex("12199") + _loc_7[1] + LanguageCfgObj.getInstance().getByIndex("11516") + "</font><br>");
                    }
                }
                if (_loc_7[0] == "-6")
                {
                    _loc_9 = UserObj.getInstance().playerInfo.spirit;
                    if (_loc_9 < int(_loc_7[1]))
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12200") + _loc_7[1] + LanguageCfgObj.getInstance().getByIndex("11517") + "</font><br>");
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#66cc00\'>" + LanguageCfgObj.getInstance().getByIndex("12200") + _loc_7[1] + LanguageCfgObj.getInstance().getByIndex("11516") + "</font><br>");
                    }
                }
                if (int(_loc_7[0]) > 0)
                {
                    _loc_10 = ItemCfgObj.getInstance().getItemCfg(int(_loc_7[0]));
                    _loc_11 = BackpackObj.getInstance().getItemCount(_loc_10.q_id);
                    if (_loc_11 < int(_loc_7[1]))
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12201") + _loc_10.q_name + LanguageCfgObj.getInstance().getByIndex("11517") + "</font><br>");
                    }
                    else
                    {
                        _loc_2 = _loc_2 + ("<font color = \'#66cc00\'>" + LanguageCfgObj.getInstance().getByIndex("12201") + _loc_10.q_name + LanguageCfgObj.getInstance().getByIndex("11516") + "</font><br>");
                    }
                }
                _loc_6++;
            }
            return _loc_2;
        }// end function

        public function updateInfo(param1:Object) : void
        {
            if (param1 && this._info)
            {
                if (SkillPassiveInfo(param1).q_skill_type == SkillPassiveInfo(this._info).q_skill_type)
                {
                    this.repaint(param1);
                }
            }
            return;
        }// end function

    }
}
