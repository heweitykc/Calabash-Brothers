package com.game.skill.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.clickstream.*;
    import com.game.guide.control.*;
    import com.game.skill.control.*;
    import com.game.skill.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class SkillPassiveItem extends SkillItemBase
    {
        private var _txtSkillName:TextField;
        private var _txtSkillLevel:TextField;
        private var _txtSkillDescribe:TextField;
        private var _txtNeedGrade:TextField;
        private var _btnActivation:BaseButton;
        private var _btnUpStage:BaseButton;
        private var _info:SkillPassiveInfo;
        private var _icon:Image;
        private var _tipsMaskBack:MovieClip;
        private var _vmcSkillUpEffect:VMCView;
        private var _tipsLostUp:SkillLostUpTips;
        private var _isCanActive:Boolean = false;
        private var _tipsLostActive:SkillLostActiveTips;

        public function SkillPassiveItem()
        {
            super("skil_lost_item");
            return;
        }// end function

        override protected function getComp() : void
        {
            super.getComp();
            this._txtSkillName = TextField(_content.getChildByName("txt_skill_name"));
            this._txtSkillLevel = TextField(_content.getChildByName("txt_skill_level"));
            this._txtSkillDescribe = TextField(_content.getChildByName("txt_describe"));
            this._txtNeedGrade = TextField(_content.getChildByName("txt_need_grade"));
            this._tipsMaskBack = MovieClip(_content.getChildByName("tips_back"));
            this._btnActivation = new BaseButton(_content.getChildByName("btn_activation"));
            this._btnActivation.setText(LanguageCfgObj.getInstance().getByIndex("11178"));
            this._btnUpStage = new BaseButton(_content.getChildByName("btn_up_stage"));
            this._btnUpStage.setText(LanguageCfgObj.getInstance().getByIndex("11179"));
            this._icon = new Image();
            this._txtSkillDescribe.mouseWheelEnabled = false;
            this._icon.move(16, 14);
            this.addChild(this._icon);
            this._tipsLostUp = new SkillLostUpTips();
            this._tipsLostActive = new SkillLostActiveTips();
            this._vmcSkillUpEffect = new VMCView();
            this._vmcSkillUpEffect.move(45, 41);
            this.addChild(this._vmcSkillUpEffect);
            return;
        }// end function

        override public function set info(param1) : void
        {
            this._info = param1;
            this.freshItem();
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        override protected function addEvents() : void
        {
            super.addEvents();
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this._btnUpStage.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverUpLevel);
            this._btnUpStage.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutUpLevel);
            this._btnActivation.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverActive);
            this._btnActivation.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutActive);
            return;
        }// end function

        protected function mouseOverUpLevel(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.currentTarget)
            {
                case this._btnUpStage:
                {
                    this._tipsLostUp.repaint(this.info);
                    FrameworkGlobal.stage.addChild(this._tipsLostUp);
                    _loc_2 = this._btnUpStage.localToGlobal(new Point(this._btnUpStage.width, this._btnUpStage.height / 2));
                    if (_loc_2.x > FrameworkGlobal.stageW - this._tipsLostUp.width)
                    {
                        _loc_2.x = _loc_2.x - this._btnUpStage.width - this._tipsLostUp.width;
                    }
                    if (_loc_2.y > FrameworkGlobal.stageH - this._tipsLostUp.height)
                    {
                        _loc_2.y = _loc_2.y - this._btnUpStage.height / 2 - this._tipsLostUp.height;
                    }
                    this._tipsLostUp.x = _loc_2.x;
                    this._tipsLostUp.y = _loc_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOverActive(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.currentTarget)
            {
                case this._btnActivation:
                {
                    this._tipsLostActive.repaint(this.info);
                    FrameworkGlobal.stage.addChild(this._tipsLostActive);
                    _loc_2 = this._btnActivation.localToGlobal(new Point(this._btnActivation.width, this._btnActivation.height / 2));
                    if (_loc_2.x > FrameworkGlobal.stageW - this._tipsLostActive.width)
                    {
                        _loc_2.x = _loc_2.x - this._btnActivation.width - this._tipsLostActive.width;
                    }
                    if (_loc_2.y > FrameworkGlobal.stageH - this._tipsLostActive.height)
                    {
                        _loc_2.y = _loc_2.y - this._btnActivation.height / 2 - this._tipsLostActive.height;
                    }
                    this._tipsLostActive.x = _loc_2.x;
                    this._tipsLostActive.y = _loc_2.y;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOutUpLevel(event:MouseEvent) : void
        {
            switch(event.currentTarget)
            {
                case this._btnUpStage:
                {
                    if (this._tipsLostUp.parent)
                    {
                        this._tipsLostUp.parent.removeChild(this._tipsLostUp);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseOutActive(event:MouseEvent) : void
        {
            switch(event.currentTarget)
            {
                case this._btnActivation:
                {
                    if (this._tipsLostActive.parent)
                    {
                        this._tipsLostActive.parent.removeChild(this._tipsLostActive);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnActivation:
                {
                    ClickStream.add(ClickStreamId.CLICK_JiNeng_JiHuo);
                    this.upLevelSkill();
                    break;
                }
                case this._btnUpStage:
                {
                    ClickStream.add(ClickStreamId.CLICK_JiNeng_ShengJi);
                    this.upLevelSkill();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function upLevelSkill() : void
        {
            if (this._info)
            {
                SkillControl.getInstance().reqActivateLostSkill(this._info.q_skill_type);
            }
            return;
        }// end function

        override protected function freshItem() : void
        {
            super.freshItem();
            this.fresh();
            return;
        }// end function

        private function fresh() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this._txtSkillLevel.text = this._info.skillLevel + "/" + this._info.q_skill_levelmax;
            this._txtSkillName.text = this._info.q_skill_name;
            this._icon.load(Params.SKILL_ICON_PATH + this._info.q_icon + ".png");
            ItemTips.create(this._tipsMaskBack, this._info, SkillLostItemTips);
            if (this._info.skillIsActive)
            {
                ItemTips.dispose(this._txtSkillDescribe);
                this._btnActivation.visible = false;
                this._btnUpStage.visible = true;
                this._txtSkillDescribe.htmlText = this._info.q_info;
                this._txtSkillDescribe.mouseEnabled = false;
                this._txtNeedGrade.text = "";
                this._icon.filters = [];
            }
            else
            {
                this._btnActivation.visible = true;
                this._btnUpStage.visible = false;
                this._txtSkillDescribe.mouseEnabled = true;
                this._txtNeedGrade.htmlText = "<font color = \'#FFCC33\'>" + LanguageCfgObj.getInstance().getByIndex("12202") + this._info.q_need_level + "</font>";
                this._icon.filters = [ColorFilter.getGrayFilter()];
                _loc_1 = this._info.q_need_info;
                _loc_2 = _loc_1.split(";");
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    _loc_4 = String(_loc_2[_loc_3]).split("_");
                    switch(_loc_4[0])
                    {
                        case "-6":
                        {
                            this._txtSkillDescribe.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12203"), [_loc_4[1]]);
                            break;
                        }
                        case "-4":
                        {
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (int(_loc_4[0]) > 0)
                    {
                        _loc_5 = new PropInfo();
                        _loc_5.convByCfg(int(_loc_4[0]));
                        this._txtSkillDescribe.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12204"), [_loc_5.q_name]);
                        ItemTips.create(this._txtSkillDescribe, _loc_5, PropTips);
                    }
                    _loc_3++;
                }
            }
            if (this._info.skillLevel == this._info.q_skill_levelmax)
            {
                this._btnUpStage.mouseEnabled = false;
                this._btnUpStage.filters = [ColorFilter.getGrayFilter()];
                this._btnUpStage.setText(LanguageCfgObj.getInstance().getByIndex("11180"));
            }
            else
            {
                this._btnUpStage.mouseEnabled = true;
                this._btnUpStage.filters = [];
                this._btnUpStage.setText(LanguageCfgObj.getInstance().getByIndex("11179"));
            }
            return;
        }// end function

        public function setServerInfo(param1:uint, param2:uint, param3:uint) : void
        {
            var _loc_4:* = null;
            if (!this._info || this._info.q_skill_id != param1)
            {
                this._info = new SkillPassiveInfo();
                _loc_4 = SkillCfgObj.getInstance().getskillLostInfo(param1);
                if (_loc_4)
                {
                    this._info.parse(_loc_4);
                }
            }
            this._info.skillIsActive = true;
            this._info.skillLevel = param2;
            this._info.skillType = param3;
            this.freshItem();
            if (this._tipsLostUp.parent)
            {
                this._tipsLostUp.updateInfo(this._info);
            }
            return;
        }// end function

        public function isActive() : Boolean
        {
            if (this._info && this._info.skillIsActive)
            {
                return true;
            }
            return false;
        }// end function

        public function playEffect() : void
        {
            this._vmcSkillUpEffect.loadRes("res/effect/skill/skill_lost_up.png");
            this._vmcSkillUpEffect.auto = true;
            this._vmcSkillUpEffect.updatePose("90");
            return;
        }// end function

        public function get isCanActive() : Boolean
        {
            return this._isCanActive;
        }// end function

        public function set isCanActive(param1:Boolean) : void
        {
            this._isCanActive = param1;
            if (param1)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnActivation);
                this.filters = [];
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnActivation);
                this.filters = [ColorFilter.getGrayFilter()];
            }
            return;
        }// end function

    }
}
