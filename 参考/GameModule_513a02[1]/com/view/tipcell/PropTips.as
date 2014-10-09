package com.view.tipcell
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class PropTips extends BaseTips
    {
        private var _backImg:Sprite;
        private var _iconBg:Sprite;
        private var _nameTxt:TextField;
        private var _typeTxt:TextField;
        private var _bindSp:Sprite;
        private var _bindTxt:TextField;
        private var _bindIcon:Bitmap;
        private var _image:Image;
        private var _effect:VMCView;
        private var _describeTxt:TextField;
        private var qualityEffect:VMCView;
        private var _effectiveTime:TextField;
        private var _dropTxt:TextField;
        private var _professionTxt:TextField;
        private var _priceSp:Sprite;
        private var _box:HBox;
        private var _lines:Array;
        private var _priceTxt:TextField;
        private var _priceValueTxt:TextField;
        private var _excisionLine:Bitmap;
        private var _limitTxt:TextField;
        private var _goldIcon:Bitmap;
        private var _content:Sprite;
        private var _count:int;
        private var _timeTxt:TextField;
        private var _lockedtimeTxt:TextField;
        private var _highLockIcon:Bitmap;
        private var _highLockSp:Sprite;
        private var _gap:int = 8;
        private var _info:PropInfo;
        private var _lockedCount:int;
        private static const MOUSE_ADJUST:uint = 25;

        public function PropTips()
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
            _loc_1.font = "simsun";
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
            this._image = new Image();
            this._image.smoothing = true;
            this._image.x = this._iconBg.x + 3;
            this._image.y = this._iconBg.y + 3;
            this._content.addChild(this._image);
            this._typeTxt = new TextField();
            _loc_1 = this._typeTxt.defaultTextFormat;
            _loc_1.leading = 3;
            _loc_1.font = "SimSun";
            this._typeTxt.defaultTextFormat = _loc_1;
            this._typeTxt.x = this._iconBg.x + this._iconBg.width + 10;
            this._typeTxt.y = this._iconBg.y + 2;
            this._typeTxt.textColor = PropUtil.GREEN;
            this._content.addChild(this._typeTxt);
            this._bindSp = new Sprite();
            this._bindTxt = new TextField();
            this._bindTxt.textColor = 16711680;
            this._bindTxt.text = LanguageCfgObj.getInstance().getByIndex("10139");
            this._bindTxt.autoSize = "left";
            _loc_1 = this._bindTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._bindTxt.defaultTextFormat = _loc_1;
            this._bindSp.addChild(this._bindTxt);
            this._bindIcon = ToolKit.getNewDO("bindIcon") as Bitmap;
            this._bindIcon.y = 4;
            this._bindIcon.x = this._bindTxt.x + 30;
            this._bindSp.addChild(this._bindIcon);
            this._professionTxt = new TextField();
            _loc_1 = this._professionTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._professionTxt.defaultTextFormat = _loc_1;
            this._professionTxt.x = this._typeTxt.x;
            this._professionTxt.y = this._typeTxt.y + 40;
            this._professionTxt.textColor = 16777215;
            this._professionTxt.autoSize = "left";
            this._content.addChild(this._professionTxt);
            this._box = new HBox();
            this._box.x = 0;
            this._box.intervalY = this._gap * 2;
            this._content.addChild(this._box);
            this._limitTxt = new TextField();
            _loc_1 = this._limitTxt.defaultTextFormat;
            _loc_1.leading = 1;
            _loc_1.font = "SimSun";
            _loc_1.leading = 2;
            this._limitTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._limitTxt.autoSize = TextFieldAutoSize.NONE;
            this._limitTxt.multiline = true;
            this._limitTxt.wordWrap = true;
            this._limitTxt.width = 215;
            this._limitTxt.mouseEnabled = false;
            this._limitTxt.defaultTextFormat = _loc_1;
            this._limitTxt.selectable = false;
            this._timeTxt = new TextField();
            _loc_1 = this._timeTxt.defaultTextFormat;
            _loc_1.leading = 1;
            _loc_1.font = "SimSun";
            _loc_1.leading = 2;
            this._timeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._timeTxt.autoSize = TextFieldAutoSize.NONE;
            this._timeTxt.multiline = false;
            this._timeTxt.wordWrap = false;
            this._timeTxt.autoSize = "right";
            this._timeTxt.x = 216;
            this._timeTxt.defaultTextFormat = _loc_1;
            this._timeTxt.selectable = false;
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
            this._describeTxt = new TextField();
            this._describeTxt.multiline = true;
            this._describeTxt.wordWrap = true;
            this._describeTxt.width = 160;
            this._describeTxt.autoSize = "left";
            this._describeTxt.mouseEnabled = false;
            this._describeTxt.textColor = PropUtil.GRAY;
            _loc_1 = this._describeTxt.defaultTextFormat;
            _loc_1.leading = 3;
            _loc_1.font = "SimSun";
            this._describeTxt.defaultTextFormat = _loc_1;
            this._describeTxt.x = this._iconBg.x + this._iconBg.width + 20;
            this._describeTxt.y = this._iconBg.y - 2;
            this._content.addChild(this._describeTxt);
            this._effectiveTime = new TextField();
            this._effectiveTime.width = 200;
            this._dropTxt = new TextField();
            this._dropTxt.autoSize = "left";
            this._dropTxt.textColor = 16711680;
            _loc_1 = this._dropTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._dropTxt.defaultTextFormat = _loc_1;
            this._priceSp = new Sprite();
            this._priceTxt = new TextField();
            this._priceTxt.autoSize = "left";
            this._priceTxt.textColor = 16187136;
            this._priceTxt.text = LanguageCfgObj.getInstance().getByIndex("10140");
            _loc_1 = this._priceTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._priceTxt.defaultTextFormat = _loc_1;
            this._priceSp.addChild(this._priceTxt);
            this._priceValueTxt = new TextField();
            this._priceValueTxt.autoSize = "left";
            this._priceValueTxt.textColor = 16187136;
            _loc_1 = this._priceValueTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            this._priceValueTxt.defaultTextFormat = _loc_1;
            this._priceValueTxt.y = 2;
            this._priceSp.addChild(this._priceValueTxt);
            this._goldIcon = ToolKit.getNewDO("gold") as Bitmap;
            this._goldIcon.y = 3;
            this._priceSp.addChild(this._goldIcon);
            this.qualityEffect = new VMCView();
            this.qualityEffect.auto = true;
            this.qualityEffect.updatePose("90", true);
            this._content.addChild(this.qualityEffect);
            this._effect = new VMCView();
            this._effect.auto = true;
            this._effect.updatePose("90", true);
            this._effect.move(this._iconBg.x + this._iconBg.width / 2 + 17, this._iconBg.y + this._iconBg.height / 2 + 12);
            addChild(this._effect);
            this._lines = [];
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = param1 as PropInfo;
            if (_loc_2 == null)
            {
                return;
            }
            this._info = _loc_2;
            this._nameTxt.htmlText = "<b>" + _loc_2.q_name + "</b>";
            this._nameTxt.textColor = PropUtil.getPropColor(_loc_2.q_quality_lv);
            this._image.load(param1.url);
            var _loc_3:* = PropUtil.getQualityColor(_loc_2);
            if (_loc_3 != "")
            {
                this.qualityEffect.loadRes("res/effect/56/" + _loc_3 + ".png");
                this.qualityEffect.auto = true;
                this.qualityEffect.move(this._image.x + 28, this._image.y + 28);
            }
            else
            {
                this.qualityEffect.finalize();
            }
            if (this._info.q_type == ItemType.ELEMENT_HEART)
            {
                this._effect.loadRes(QEHeartCfgObj.getInstance().getItem(int(this._info.q_value)).effectUrl);
                this._effect.auto = true;
            }
            else
            {
                this._effect.finalize();
            }
            this._describeTxt.htmlText = _loc_2.q_describe || "";
            var _loc_4:* = Math.max(this._iconBg.y + this._iconBg.height + 8, this._describeTxt.y + this._describeTxt.height + 8);
            this._box.y = _loc_4 + 16;
            this.addGapLine(_loc_4);
            this.initLimitContainer(_loc_2);
            if (_loc_2.isbind > 0)
            {
                this._box.add(this._bindSp);
                this.addGapLine(this._box.y + this._bindSp.y + this._bindSp.height);
            }
            else if (this._bindSp.parent)
            {
                this._box.remove(this._bindSp);
            }
            this.repaintDrop(_loc_2);
            this.showHighLockedTime(_loc_2);
            this._box.update();
            this.initPriceSp(_loc_2);
            this._box.update();
            this.repaintEffectTime(_loc_2);
            this._box.update();
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 24 + this._content.height;
            addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            return;
        }// end function

        public function removeFromStage(event:Event) : void
        {
            this.remove();
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

        private function initLimitContainer(param1:PropInfo) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = UserObj.getInstance().playerInfo;
            var _loc_4:* = "";
            if (param1.q_level)
            {
                if (_loc_3.level >= param1.q_level)
                {
                    _loc_5 = 16777215;
                }
                else
                {
                    _loc_5 = 16711680;
                }
                _loc_6 = param1.q_level > Params.ROLE_MAX_LEVEL ? (LanguageCfgObj.getInstance().getByIndex("12455") + (param1.q_level - Params.ROLE_MAX_LEVEL)) : (param1.q_level.toString());
                _loc_4 = _loc_4 + ("<font color = \'#" + _loc_5.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11809") + _loc_6 + "</font><br>");
            }
            _loc_4 = _loc_4 + this.setProfession(param1);
            if (param1.q_str_limit)
            {
                if (_loc_3.strength >= param1.q_str_limit)
                {
                    _loc_5 = 16777215;
                }
                else
                {
                    _loc_5 = 16711680;
                }
                _loc_4 = _loc_4 + ("<font color = \'#" + _loc_5.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11810") + param1.q_str_limit + "</font><br>");
            }
            if (param1.q_agile_limit)
            {
                if (_loc_3.agile >= param1.q_agile_limit)
                {
                    _loc_5 = 16777215;
                }
                else
                {
                    _loc_5 = 16711680;
                }
                _loc_4 = _loc_4 + ("<font color = \'#" + _loc_5.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11811") + param1.q_agile_limit + "</font><br>");
            }
            if (param1.q_int_limit)
            {
                if (_loc_3.intelligence >= param1.q_int_limit)
                {
                    _loc_5 = 16777215;
                }
                else
                {
                    _loc_5 = 16711680;
                }
                _loc_4 = _loc_4 + ("<font color = \'#" + _loc_5.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11812") + param1.q_int_limit + "</font><br>");
            }
            if (param1.q_vit_limit)
            {
                if (_loc_3.vitality >= param1.q_vit_limit)
                {
                    _loc_5 = 16777215;
                }
                else
                {
                    _loc_5 = 16711680;
                }
                _loc_4 = _loc_4 + ("<font color = \'#" + _loc_5.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11813") + param1.q_vit_limit + "</font><br>");
            }
            this._limitTxt.htmlText = _loc_4;
            this._limitTxt.height = this._limitTxt.textHeight + 4;
            if (_loc_4 != "")
            {
                if (!this._limitTxt.parent)
                {
                    this._box.add(this._limitTxt);
                }
                this.addGapLine(this._box.y + this._limitTxt.y + this._limitTxt.height);
            }
            else if (this._limitTxt.parent)
            {
                this._box.remove(this._limitTxt);
            }
            return;
        }// end function

        private function setProfession(param1:PropInfo) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.isUseForJob(UserObj.getInstance().playerInfo.job);
            if (param1.q_job_limit == 0)
            {
                _loc_3 = "";
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10141");
                _loc_3 = _loc_3 + PropUtil.getProfessionStr(param1.q_job_limit);
                if (_loc_2)
                {
                    _loc_3 = "<font color = \'#ffffff\'>" + _loc_3 + "</font>";
                }
                else
                {
                    _loc_3 = "<font color = \'#ff0000\'>" + _loc_3 + "</font>";
                }
            }
            if (_loc_3 != "")
            {
                _loc_3 = _loc_3 + "<br>";
            }
            return _loc_3;
        }// end function

        private function endCount() : void
        {
            this.repaintEffectTime(this._info);
            return;
        }// end function

        private function repaintEffectTime(param1:PropInfo) : void
        {
            var _loc_2:* = 0;
            if (param1.lostTime)
            {
                _loc_2 = param1.lostTime - ToolKit.getServerTime() * 0.001;
                Ticker.killTimer(this.updateEffectTime);
                if (_loc_2 > 0)
                {
                    Ticker.registerTimer(1, this.updateEffectTime, this.endCount, _loc_2);
                    this._timeTxt.textColor = 16187136;
                    this._count = _loc_2;
                    this.updateEffectTime();
                }
                else
                {
                    this._timeTxt.textColor = 16711680;
                    this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("10142");
                    this._count = 0;
                }
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                if (!this._timeTxt.parent)
                {
                    this._content.addChild(this._timeTxt);
                }
                this._timeTxt.y = this._box.y + this._box.height - 17;
            }
            else if (param1.q_effective_time)
            {
                this._timeTxt.textColor = 65280;
                this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("11814") + ToolKit.second2TimeStr(param1.q_effective_time * 60, LanguageCfgObj.getInstance().getByIndex("11569") + LanguageCfgObj.getInstance().getByIndex("11570") + LanguageCfgObj.getInstance().getByIndex("10024"));
                this._count = 0;
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                if (!this._timeTxt.parent)
                {
                    this._content.addChild(this._timeTxt);
                }
                this._timeTxt.y = this._box.y + this._box.height - 17;
            }
            else
            {
                if (this._timeTxt.parent)
                {
                    this._timeTxt.parent.removeChild(this._timeTxt);
                }
                this._count = 0;
            }
            return;
        }// end function

        override public function remove() : void
        {
            Ticker.killTimer(this.updateEffectTime);
            Ticker.killTimer(this.updateLockedEffectTime);
            this.qualityEffect.finalize();
            this._effect.finalize();
            this._lines.splice(0);
            return;
        }// end function

        private function updateEffectTime() : void
        {
            this._timeTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11815"), [ToolKit.second2CountDown(this._count)]);
            var _loc_1:* = this;
            var _loc_2:* = this._count - 1;
            _loc_1._count = _loc_2;
            return;
        }// end function

        private function initEffectTime(param1:PropInfo) : void
        {
            var _loc_2:* = 0;
            if (param1.lostTime)
            {
                _loc_2 = param1.lostTime - ToolKit.getServerTime() * 0.001;
                Ticker.killTimer(this.updateEffectTime);
                if (_loc_2 > 0)
                {
                    Ticker.registerTimer(1, this.updateEffectTime);
                    this._timeTxt.textColor = 15564081;
                    this._count = _loc_2;
                    this.updateEffectTime();
                }
                else
                {
                    this._timeTxt.textColor = 16711680;
                    this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("10142");
                    this._count = 0;
                }
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                if (!this._timeTxt.parent)
                {
                    this._box.add(this._timeTxt);
                }
            }
            else if (param1.q_effective_time)
            {
                this._timeTxt.textColor = 65280;
                this._timeTxt.text = LanguageCfgObj.getInstance().getByIndex("11814") + ToolKit.second2TimeStr(param1.q_effective_time * 60, LanguageCfgObj.getInstance().getByIndex("11569") + LanguageCfgObj.getInstance().getByIndex("11570"));
                this._count = 0;
                this._timeTxt.height = this._timeTxt.textHeight + 4;
                if (!this._timeTxt.parent)
                {
                    this._box.add(this._timeTxt);
                }
            }
            else
            {
                if (this._timeTxt.parent)
                {
                    this._box.remove(this._timeTxt);
                }
                this._count = 0;
            }
            return;
        }// end function

        private function repaintDrop(param1:PropInfo) : void
        {
            var _loc_2:* = "";
            if (!param1.q_drop)
            {
                _loc_2 = LanguageCfgObj.getInstance().getByIndex("10144");
                if (!param1.q_sell)
                {
                    _loc_2 = _loc_2 + ("/" + LanguageCfgObj.getInstance().getByIndex("10145"));
                }
            }
            else
            {
                _loc_2 = LanguageCfgObj.getInstance().getByIndex("10145");
            }
            if (!param1.q_save_warehouse)
            {
                _loc_2 = _loc_2 + ("<br>" + LanguageCfgObj.getInstance().getByIndex("11816"));
            }
            this._dropTxt.htmlText = _loc_2;
            if (param1.q_sell && param1.q_drop && param1.q_save_warehouse)
            {
                if (this._dropTxt.parent)
                {
                    this._box.remove(this._dropTxt);
                }
            }
            else
            {
                if (!this._dropTxt.parent)
                {
                    this._box.add(this._dropTxt);
                }
                this.addGapLine(this._box.y + this._dropTxt.y + this._dropTxt.height);
            }
            return;
        }// end function

        private function initPriceSp(param1:PropInfo) : void
        {
            var _loc_2:* = null;
            if (param1.q_sell)
            {
                if (!this._priceSp.parent)
                {
                    this._box.add(this._priceSp);
                }
                _loc_2 = "";
                if (param1.num > 1)
                {
                    _loc_2 = _loc_2 + param1.q_sell_price * param1.num;
                }
                else
                {
                    _loc_2 = _loc_2 + param1.q_sell_price;
                }
                this._priceValueTxt.htmlText = _loc_2;
                this._goldIcon.x = this._priceTxt.x + this._priceTxt.width;
                this._priceValueTxt.x = this._goldIcon.x + this._goldIcon.width + 3;
            }
            else if (this._priceSp.parent)
            {
                this._box.remove(this._priceSp);
            }
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
                    this.addGapLine(this._box.y + this._highLockSp.height);
                    this._box.add(this._highLockSp);
                }
            }
            else if (param1.lockedEndTime == -1)
            {
                this._lockedtimeTxt.textColor = 65280;
                this._lockedtimeTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10000", "lang_highlock");
                this._lockedtimeTxt.height = this._lockedtimeTxt.textHeight + 4;
                if (!this._highLockSp.parent)
                {
                    this.addGapLine(this._box.y + this._highLockSp.height);
                    this._box.add(this._highLockSp);
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

        public static function getTipX(param1:BaseTips) : int
        {
            if (!param1)
            {
                return 0;
            }
            var _loc_2:* = FrameworkGlobal.stage.mouseX;
            var _loc_3:* = FrameworkGlobal.stage.mouseX;
            if (_loc_2 + param1.width > FrameworkGlobal.stageW)
            {
                _loc_3 = _loc_2 - param1.width - MOUSE_ADJUST;
            }
            else
            {
                _loc_3 = _loc_3 + MOUSE_ADJUST;
            }
            return _loc_3;
        }// end function

        public static function getTipY(param1:BaseTips) : int
        {
            var _loc_2:* = FrameworkGlobal.stage.mouseY;
            var _loc_3:* = _loc_2;
            if (_loc_2 + param1.height > FrameworkGlobal.stageH)
            {
                _loc_3 = _loc_2 - param1.height - MOUSE_ADJUST;
            }
            else
            {
                _loc_3 = _loc_3 + MOUSE_ADJUST;
            }
            return _loc_3;
        }// end function

    }
}
