package com.view.tipcell
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.container.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.equip.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class EquipTips extends BaseTips
    {
        private var _info:EquipmentInfo;
        private var _backImg:Sprite;
        private var _extraTips:ExtraTips;
        private var _iconBg:Sprite;
        private var _nameTxt:TextField;
        private var _typeTxt:TextField;
        private var _bindItem:BindItem;
        private var _icon:IconItem;
        private var _describeItem:DescribeItem;
        private var _remarkAttribute:RemarkItem;
        private var _dropItem:DropItem;
        private var _professionTxt:TextField;
        private var _box:HBox;
        private var _fightContainer:Sprite;
        private var _iconFight:Bitmap;
        private var _fightNumber:ImgNumber;
        public var compareTip:EquipTips;
        private var _equipedImg:Bitmap;
        private var _priceItem:PriceItem;
        private var _excisionLine:Bitmap;
        private var _content:Sprite;
        private var _basicAttributeTxt:TextField;
        private var qualityEffect:VMCView;
        private var _limitAttribute:LimitItem;
        private var _skillAttribute:SkillItem;
        private var _addAttribute:AddAttribute;
        private var _luckyAttribute:LuckyItem;
        private var _tiemItem:TimeItem;
        private var _intensifyEffect:VMCView;
        private var _ignoreAttribute:IgnoreItem;
        private var _suitItem:SuitItem;
        private var _count:int;
        private var _points:Array;
        private var _lines:Array;
        private var _gap:int = 8;
        private var _steplvTxt:TextField;
        private var _lockedtimeTxt:TextField;
        private var _highLockIcon:Bitmap;
        private var _highLockSp:Sprite;
        private var _preFightNumberItem:PreFightNumberItem;
        public var isvice:Boolean;
        private var _lockedCount:int;

        public function EquipTips()
        {
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this._nameTxt = new TextField();
            this._nameTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._nameTxt.width = 215;
            this._nameTxt.height = 20;
            var _loc_1:* = this._nameTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            _loc_1.size = 14;
            _loc_1.color = 16748800;
            _loc_1.align = "left";
            this._nameTxt.defaultTextFormat = _loc_1;
            this._content.addChild(this._nameTxt);
            this._excisionLine = ToolKit.getNewDO("excisionLine") as Bitmap;
            this._excisionLine.x = 0;
            this._excisionLine.y = this._nameTxt.y + this._nameTxt.height + 5;
            this._content.addChild(this._excisionLine);
            this._iconBg = ToolKit.getNew("itemtipsborder");
            this._iconBg.x = 0;
            this._iconBg.y = this._excisionLine.y + this._excisionLine.height + 10;
            this._content.addChild(this._iconBg);
            this._icon = new IconItem(null);
            this._icon.setWH(56, 56);
            this._icon.setImageSize(56, 56);
            this._icon.x = this._iconBg.x + 3;
            this._icon.y = this._iconBg.y + 3;
            this._content.addChild(this._icon);
            this._fightContainer = new Sprite();
            this._iconFight = ToolKit.getNewDO("equip_fight_num") as Bitmap;
            this._iconFight.y = 1;
            this._fightContainer.addChild(this._iconFight);
            this._fightNumber = new ImgNumber();
            this._fightNumber.x = this._iconFight.x + this._iconFight.width + 5;
            this._fightContainer.addChild(this._fightNumber);
            this._fightContainer.x = this._iconBg.x + this._iconBg.width + 20;
            this._fightContainer.y = this._excisionLine.y + this._excisionLine.height + 5;
            this._content.addChild(this._fightContainer);
            this._typeTxt = new TextField();
            _loc_1 = this._typeTxt.defaultTextFormat;
            _loc_1.align = "right";
            _loc_1.font = "SimSun";
            this._typeTxt.autoSize = "right";
            this._typeTxt.defaultTextFormat = _loc_1;
            this._typeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._typeTxt.x = 232;
            this._typeTxt.y = this._fightContainer.y - 2;
            this._typeTxt.textColor = PropUtil.GREEN;
            this._content.addChild(this._typeTxt);
            this._bindItem = new BindItem();
            this._professionTxt = new TextField();
            _loc_1 = this._professionTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._professionTxt.defaultTextFormat = _loc_1;
            this._professionTxt.textColor = 16777215;
            this._professionTxt.autoSize = "left";
            this._content.addChild(this._professionTxt);
            this._lockedtimeTxt = new TextField();
            _loc_1 = this._lockedtimeTxt.defaultTextFormat;
            _loc_1.leading = 3;
            _loc_1.font = "SimSun";
            this._lockedtimeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._lockedtimeTxt.autoSize = TextFieldAutoSize.NONE;
            this._lockedtimeTxt.multiline = true;
            this._lockedtimeTxt.wordWrap = true;
            this._lockedtimeTxt.autoSize = "left";
            this._lockedtimeTxt.width = 231;
            this._lockedtimeTxt.defaultTextFormat = _loc_1;
            this._lockedtimeTxt.selectable = false;
            this._highLockSp = new Sprite();
            this._highLockSp.addChild(this._lockedtimeTxt);
            this._highLockIcon = ToolKit.getNewDO("protectHighItemMark") as Bitmap;
            this._highLockIcon.x = 0;
            this._highLockIcon.y = 4;
            this._lockedtimeTxt.x = this._highLockIcon.width;
            this._highLockSp.addChild(this._highLockIcon);
            this._box = new HBox();
            this._box.x = 15;
            this._box.intervalY = this._gap;
            this._content.addChild(this._box);
            this._limitAttribute = new LimitItem();
            this._skillAttribute = new SkillItem();
            this._tiemItem = new TimeItem();
            this._steplvTxt = new TextField();
            _loc_1 = this._steplvTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._steplvTxt.autoSize = "left";
            this._steplvTxt.defaultTextFormat = _loc_1;
            this._steplvTxt.textColor = PropUtil.PURPLE_S;
            this._content.addChild(this._steplvTxt);
            this._basicAttributeTxt = new TextField();
            _loc_1 = this._basicAttributeTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            _loc_1.leading = 2;
            this._basicAttributeTxt.x = this._fightContainer.x;
            this._basicAttributeTxt.y = this._fightContainer.y + this._fightContainer.height + 19;
            this._basicAttributeTxt.autoSize = TextFieldAutoSize.NONE;
            this._basicAttributeTxt.multiline = true;
            this._basicAttributeTxt.wordWrap = true;
            this._basicAttributeTxt.mouseEnabled = false;
            this._basicAttributeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._basicAttributeTxt.width = 140;
            this._basicAttributeTxt.defaultTextFormat = _loc_1;
            this._basicAttributeTxt.selectable = false;
            this._basicAttributeTxt.textColor = 16777215;
            this._luckyAttribute = new LuckyItem();
            this._ignoreAttribute = new IgnoreItem();
            this._remarkAttribute = new RemarkItem();
            this._addAttribute = new AddAttribute();
            this._suitItem = new SuitItem();
            this._describeItem = new DescribeItem();
            this._dropItem = new DropItem();
            this._priceItem = new PriceItem();
            this._preFightNumberItem = new PreFightNumberItem();
            this.qualityEffect = new VMCView();
            this.qualityEffect.auto = true;
            this.qualityEffect.updatePose("90", true);
            this._content.addChild(this.qualityEffect);
            this._intensifyEffect = new VMCView();
            this._intensifyEffect.auto = true;
            this._intensifyEffect.updatePose("90", true);
            this._content.addChild(this._intensifyEffect);
            this._points = [];
            this._lines = [];
            return;
        }// end function

        private function repaintBasicAttribute(param1:EquipmentInfo) : void
        {
            var _loc_2:* = "";
            if (param1.q_max_physicattack)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11789") + param1.q_min_physicattack + "-" + param1.q_max_physicattack + "<br>");
            }
            if (param1.q_max_magicattack)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11790") + param1.q_min_magicattack + "-" + param1.q_max_magicattack + "<br>");
            }
            if (param1.q_physicattack_Percent)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11791") + param1.q_physicattack_Percent + "%<br>");
            }
            if (param1.q_magicattack_Percent)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11792") + param1.q_magicattack_Percent + "%<br>");
            }
            if (param1.q_defence)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11793") + param1.q_defence + "<br>");
            }
            if (param1.q_hit)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11794") + param1.q_hit + "<br>");
            }
            if (param1.q_dodge)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11795") + param1.q_dodge + "<br>");
            }
            if (param1.q_max_hp)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11796") + param1.q_max_hp + "<br>");
            }
            if (param1.q_max_mp)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11797") + param1.q_max_mp + "<br>");
            }
            if (param1.q_attackspeed)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11798") + param1.q_attackspeed + "<br>");
            }
            if (param1.q_speed)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11799") + param1.q_speed + "<br>");
            }
            if (param1.q_element_attack1)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11800") + param1.q_element_attack1 + "<br>");
            }
            if (param1.q_element_attack2)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11801") + param1.q_element_attack2 + "<br>");
            }
            if (param1.q_element_attack3)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11802") + param1.q_element_attack3 + "<br>");
            }
            if (param1.q_element_defence1)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11803") + param1.q_element_defence1 + "<br>");
            }
            if (param1.q_element_defence2)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11804") + param1.q_element_defence2 + "<br>");
            }
            if (param1.q_element_defence3)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11805") + param1.q_element_defence3 + "<br>");
            }
            if (param1.q_add_injure)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11806") + param1.q_add_injure / 100 + "%<br>");
            }
            if (param1.q_reduce_injure)
            {
                _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11807") + param1.q_reduce_injure / 100 + "%<br>");
            }
            this._basicAttributeTxt.htmlText = _loc_2;
            this._basicAttributeTxt.height = this._basicAttributeTxt.textHeight + 4;
            if (_loc_2 != "")
            {
                if (!this._basicAttributeTxt.parent)
                {
                    this._content.addChild(this._basicAttributeTxt);
                }
            }
            else if (this._basicAttributeTxt.parent)
            {
                this._content.removeChild(this._basicAttributeTxt);
            }
            return;
        }// end function

        private function repaintFightNumber(param1:EquipmentInfo) : void
        {
            this._fightNumber.setNumber(param1.fightNumber.toString(), 7, -1);
            return;
        }// end function

        public function removeFightNumber() : void
        {
            if (this._fightContainer && this._fightContainer.parent)
            {
                this._fightContainer.parent.removeChild(this._fightContainer);
            }
            return;
        }// end function

        public function removeLimitContainer() : void
        {
            this._box.remove(this._limitAttribute);
            return;
        }// end function

        override public function remove() : void
        {
            this._tiemItem.remove();
            this.qualityEffect.finalize();
            this._intensifyEffect.finalize();
            this._lines.splice(0);
            this._points.splice(0);
            if (this.compareTip)
            {
                if (this.compareTip.parent)
                {
                    this.compareTip.parent.removeChild(this.compareTip);
                }
                this.compareTip.remove();
            }
            Ticker.killTimer(this.updateLockedEffectTime);
            return;
        }// end function

        public function removeFromStage(event:Event) : void
        {
            this.remove();
            return;
        }// end function

        protected function addGapPoint(param1:int, param2:int = 1) : void
        {
            var _loc_4:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < param2)
            {
                
                _loc_4 = ToolKit.getNew("generalTextPoint") as Sprite;
                _loc_4.x = 0;
                _loc_4.y = (param1 + 1) + _loc_3 * 16;
                this._content.addChild(_loc_4);
                this._points.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        protected function addGapLine(param1:int) : void
        {
            var _loc_2:* = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = 10;
            _loc_2.y = param1 + this._gap;
            this._content.addChild(_loc_2);
            this._lines.push(_loc_2);
            return;
        }// end function

        private function repaintStepLv(param1:EquipmentInfo, param2:uint) : void
        {
            this._steplvTxt.x = this._fightContainer.x;
            this._steplvTxt.y = this._fightContainer.y + this._fightContainer.height + 2;
            this._steplvTxt.textColor = param2;
            var _loc_3:* = ToolKit.NumArr;
            this._steplvTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11808"), [_loc_3[(param1.q_equip_steplv - 1)]]);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_7:* = 0;
            var _loc_8:* = undefined;
            var _loc_2:* = param1 as EquipmentInfo;
            this._info = _loc_2;
            if (_loc_2 == null || _loc_2.itemModelId == 0)
            {
                return;
            }
            _loc_2.calFightNumber();
            var _loc_3:* = PropUtil.getEquipNameAndColor(_loc_2);
            this._nameTxt.htmlText = "<b>" + _loc_3[0] + "</b>";
            this._nameTxt.width = this._nameTxt.textWidth + 5;
            this._nameTxt.textColor = _loc_3[1];
            var _loc_4:* = this._nameTxt.textColor;
            this._icon.setInfo(_loc_2);
            if (_loc_2.pos > 0 && this.isvice == true)
            {
                this._equipedImg = ToolKit.getNewDO("equip_equiped") as Bitmap;
                this._equipedImg.x = this._icon.x + 12;
                this._equipedImg.y = this._icon.y + 20;
                this._content.addChild(this._equipedImg);
            }
            var _loc_5:* = PropUtil.getQualityColor(_loc_2);
            if (PropUtil.getQualityColor(_loc_2) != "")
            {
            }
            else
            {
                this.qualityEffect.finalize();
            }
            if (_loc_2.q_kind != Params.SHOW)
            {
                if (_loc_2.q_kind == Params.LEFT_WEAPON)
                {
                    if (_loc_2.q_secondary_type == 1)
                    {
                        this._typeTxt.text = LanguageCfgObj.getInstance().getByIndex("10136");
                    }
                    else if (_loc_2.q_secondary_type == 2)
                    {
                        this._typeTxt.text = LanguageCfgObj.getInstance().getByIndex("10137");
                    }
                }
                else if (_loc_2.q_kind == Params.RIGHT_WEAPON)
                {
                    this._typeTxt.text = LanguageCfgObj.getInstance().getByIndex("10138");
                }
                else
                {
                    this._typeTxt.text = "(" + PropUtil.getEquipType(_loc_2.q_kind) + ")";
                }
            }
            else
            {
                this._typeTxt.text = "";
            }
            if (_loc_2.q_kind != Params.SHOW)
            {
                this.repaintFightNumber(_loc_2);
                this.repaintStepLv(_loc_2, _loc_4);
                this.repaintBasicAttribute(_loc_2);
                _loc_7 = Math.max(this._iconBg.y + this._iconBg.height + 8, this._basicAttributeTxt.y + this._basicAttributeTxt.height + 8);
                this._box.y = _loc_7 + 16;
                this.addGapLine(_loc_7);
                this._addAttribute.repaintAddAttribute(_loc_2, this._box);
                this._luckyAttribute.repaintLuck(_loc_2, this._box);
                this._skillAttribute.repaintSkill(_loc_2, this._box);
                this._remarkAttribute.repaintRemark(_loc_2, this._box);
                this._ignoreAttribute.repaintIgnore(_loc_2, this._box);
                this._limitAttribute.initLimitContainer(_loc_2, this._box);
            }
            else
            {
                this.removeFightNumber();
                this.repaintStepLv(_loc_2, _loc_4);
                this.repaintBasicAttribute(_loc_2);
                _loc_7 = Math.max(this._iconBg.y + this._iconBg.height + 10, this._basicAttributeTxt.y + this._basicAttributeTxt.height + 10);
                this._box.y = _loc_7 + 16;
                this.addGapLine(_loc_7);
                this.removeLimitContainer();
                this._luckyAttribute.repaintLuckCount(this._box);
                this._addAttribute.repaintAddAttributeCount(this._box);
                this._remarkAttribute.repaintRemarkCount(_loc_2.q_set_uniquelevel, this._box);
            }
            this._suitItem.setSuit(_loc_2, this._box);
            this._describeItem.updateDesc(_loc_2.q_describe, this._box);
            if (_loc_2.isbind > 0)
            {
                this._box.add(this._bindItem);
            }
            else
            {
                this._box.remove(this._bindItem);
            }
            this._dropItem.repaintDrop(_loc_2, this._box);
            this.showHighLockedTime(_loc_2);
            this._priceItem.initPriceSp(_loc_2, this._box);
            this._tiemItem.repaintEffectTime(_loc_2, this._box);
            this._preFightNumberItem.repaintIntensify(_loc_2, this._box);
            this._box.update();
            var _loc_6:* = FrameworkGlobal.stageH;
            _loc_6 = FrameworkGlobal.stageH < 200 ? (200) : (_loc_6);
            while (this._content.height > _loc_6)
            {
                
                if (this._extraTips == null)
                {
                    this._extraTips = new ExtraTips();
                }
                _loc_8 = this._box.getContent((this._box.contents.length - 1));
                this._box.remove(_loc_8);
                this._extraTips.addItem(_loc_8);
            }
            if (this._extraTips)
            {
                this._extraTips.update();
                this._box.update();
            }
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 24 + this._content.height;
            if (this._extraTips)
            {
                this._extraTips.x = this._backImg.width;
                this._extraTips.y = this._backImg.height - this._extraTips.height;
                addChild(this._extraTips);
            }
            addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            return;
        }// end function

        private function endHighLockedCount() : void
        {
            this.showHighLockedTime(this._info);
            return;
        }// end function

        private function updateLockedEffectTime() : void
        {
            var _loc_1:* = LanguageCfgObj.getInstance().getByIndex("10000", "lang_highlock");
            var _loc_2:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10001", "lang_highlock"), [ToolKit.second3CountDown(this._lockedCount)]);
            this._lockedtimeTxt.htmlText = _loc_1 + "\n<font color=\'#ff0000\'>" + _loc_2 + "</font>";
            var _loc_3:* = this;
            var _loc_4:* = this._lockedCount - 1;
            _loc_3._lockedCount = _loc_4;
            return;
        }// end function

        protected function showHighLockedTime(param1:PropInfo) : void
        {
            var _loc_2:* = 0;
            if (param1.lockedEndTime > 0)
            {
                _loc_2 = param1.lockedEndTime - ToolKit.getServerTime() * 0.001;
                Ticker.killTimer(this.updateLockedEffectTime);
                if (_loc_2 > 0)
                {
                    Ticker.registerTimer(1, this.updateLockedEffectTime, this.endHighLockedCount, _loc_2);
                    this._lockedtimeTxt.textColor = 16187136;
                    this._lockedCount = _loc_2;
                    this.updateLockedEffectTime();
                }
                else
                {
                    this._lockedtimeTxt.textColor = 16187136;
                    this._lockedtimeTxt.text = LanguageCfgObj.getInstance().getByIndex("10002", "lang_highlock");
                    this._lockedCount = 0;
                    param1.lockedEndTime = 0;
                    param1.dispatchEvt(new GameEvent("HIGH_LOCK_UPDE"));
                }
                this._lockedtimeTxt.height = this._lockedtimeTxt.textHeight + 4;
                if (!this._highLockSp.parent)
                {
                    this._box.add(this._highLockSp);
                    this._box.update();
                    this.addGapLine(this._box.y + this._box.height - 3);
                }
            }
            else if (param1.lockedEndTime == -1)
            {
                this._lockedtimeTxt.textColor = 65280;
                this._lockedtimeTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10000", "lang_highlock");
                this._lockedtimeTxt.height = this._lockedtimeTxt.textHeight + 4;
                if (!this._highLockSp.parent)
                {
                    this._box.add(this._highLockSp);
                    this._box.update();
                    this.addGapLine(this._box.y + this._box.height - 3);
                }
                this._lockedCount = 0;
            }
            else
            {
                if (this._highLockSp.parent)
                {
                    this._highLockSp.parent.removeChild(this._highLockSp);
                }
                this._lockedCount = 0;
            }
            return;
        }// end function

    }
}
