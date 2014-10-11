package com.game.primaryrole.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.guide.*;
    import com.game.guide.control.*;
    import com.game.guide.model.*;
    import com.game.primaryrole.cfg.*;
    import com.game.primaryrole.consts.*;
    import com.game.primaryrole.control.*;
    import com.game.primaryrole.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class RoleTalentPlusPanel extends BaseBox implements IGuide
    {
        private var _totalTalentPoint:TextField;
        private var _lastTalentPoint:TextField;
        private var _recommandBtn:BaseButton;
        private var _addTalentBtn:BaseButton;
        private var closeBtn:BaseButton;
        private var _powerAddBtn:BaseButton;
        private var _powerSubBtn:BaseButton;
        private var _agileAddBtn:BaseButton;
        private var _agileSubBtn:BaseButton;
        private var _strengthAddBtn:BaseButton;
        private var _strengthSubBtn:BaseButton;
        private var _witAddBtn:BaseButton;
        private var _witSubBtn:BaseButton;
        private var _powerTxt:TextField;
        private var _agileTxt:TextField;
        private var _strengthTxt:TextField;
        private var _witTxt:TextField;
        private var _popBox:SysCueBox;
        private var _physicalAttacksTxt:TextField;
        private var _attackRateTxt:TextField;
        private var _defenceTxt:TextField;
        private var _defenceRateTxt:TextField;
        private var _attackSpeedTxt:TextField;
        private var _powerAddTxt:TextField;
        private var _agileAddTxt:TextField;
        private var _witAddTxt:TextField;
        private var _strengthAddTxt:TextField;
        private var _attackTxt:TextField;
        private var _HPTxt:TextField;
        private var _EPTxt:TextField;
        private var _magicAttackTxt:TextField;
        private var _info:PlayerInfo;
        private var _lastPoint:int;
        private var _delaytimeid:int;
        private var _curTarget:TextField;
        private var _newRoleDefaultPoint:int;
        private var _tempPower:int;
        private var _tempAgile:int;
        private var _tempStrength:int;
        private var _tempWit:int;
        private var _operType:int;
        private var _orginPoint:int;
        private var _timeOutId:int;
        private var _preTime:Number;
        private var _addOper:int;
        private var _targetText:TextField;
        private var _orginValue:int;
        private static const POWER:int = 1;
        private static const AGILE:int = 2;
        private static const STRENGTH:int = 3;
        private static const WIT:int = 4;

        public function RoleTalentPlusPanel()
        {
            loadDisplay("res/roletalentplus.swf");
            return;
        }// end function

        public function get lastPoint() : int
        {
            return this._lastPoint;
        }// end function

        private function setPointTxtUseable(param1:Boolean) : void
        {
            this._agileAddTxt.type = param1 ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
            this._strengthAddTxt.type = param1 ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
            this._witAddTxt.type = param1 ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
            this._powerAddTxt.type = param1 ? (TextFieldType.INPUT) : (TextFieldType.DYNAMIC);
            if (param1)
            {
                this._agileAddTxt.addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
                this._strengthAddTxt.addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
                this._witAddTxt.addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
                this._powerAddTxt.addEventListener(Event.CHANGE, this.__inputChange, false, 0, true);
                this._agileAddTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focus, false, 0, true);
                this._strengthAddTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focus, false, 0, true);
                this._witAddTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focus, false, 0, true);
                this._powerAddTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focus, false, 0, true);
                this._powerAddTxt.addEventListener(FocusEvent.FOCUS_OUT, this.__focusout, false, 0, true);
                this._powerAddTxt.addEventListener(FocusEvent.FOCUS_OUT, this.__focusout, false, 0, true);
                this._powerAddTxt.addEventListener(FocusEvent.FOCUS_OUT, this.__focusout, false, 0, true);
                this._powerAddTxt.addEventListener(FocusEvent.FOCUS_OUT, this.__focusout, false, 0, true);
            }
            else
            {
                this._agileAddTxt.removeEventListener(Event.CHANGE, this.__inputChange, false);
                this._strengthAddTxt.removeEventListener(Event.CHANGE, this.__inputChange, false);
                this._witAddTxt.removeEventListener(Event.CHANGE, this.__inputChange, false);
                this._powerAddTxt.removeEventListener(Event.CHANGE, this.__inputChange, false);
                this._agileAddTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focus, false);
                this._strengthAddTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focus, false);
                this._witAddTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focus, false);
                this._powerAddTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focus, false);
            }
            return;
        }// end function

        private function __focusout(event:FocusEvent) : void
        {
            return;
        }// end function

        private function __focus(event:FocusEvent) : void
        {
            (event.target as TextField).text = "";
            return;
        }// end function

        private function __inputChange(event:Event) : void
        {
            clearTimeout(this._delaytimeid);
            if (this._curTarget != null && this._curTarget != event.target)
            {
                this.checkNum(this._curTarget, event.target as TextField);
            }
            this._curTarget = event.target as TextField;
            this._delaytimeid = setTimeout(this.checkNum, 200, event.target);
            return;
        }// end function

        private function checkNum(param1:TextField, param2:TextField = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            if (param2 == null)
            {
                if (param1 == this._curTarget)
                {
                    this._curTarget = null;
                }
            }
            var _loc_3:* = this.getMaxPoint(param1, param2);
            var _loc_4:* = int(param1.text) < 0 ? (0) : (int(param1.text));
            param1.text = _loc_4 > _loc_3 ? (_loc_3.toString()) : (_loc_4.toString());
            this.countAttribute();
            this.updateAttribute(true);
            if (!param2)
            {
                this.lastPoint = this._info.unallocatedTalent - (int(this._powerAddTxt.text) + int(this._agileAddTxt.text) + int(this._strengthAddTxt.text) + int(this._witAddTxt.text));
            }
            else
            {
                _loc_5 = int(this._witAddTxt.text);
                _loc_6 = int(this._strengthAddTxt.text);
                _loc_7 = int(this._agileAddTxt.text);
                _loc_8 = int(this._powerAddTxt.text);
                switch(param2)
                {
                    case this._powerAddTxt:
                    {
                        _loc_8 = 0;
                        break;
                    }
                    case this._agileAddTxt:
                    {
                        _loc_7 = 0;
                        break;
                    }
                    case this._strengthAddTxt:
                    {
                        _loc_6 = 0;
                        break;
                    }
                    case this._witAddTxt:
                    {
                        _loc_5 = 0;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this.lastPoint = this._info.unallocatedTalent - (_loc_5 + _loc_6 + _loc_7 + _loc_8);
            }
            return;
        }// end function

        private function getMaxPoint(param1:TextField, param2:TextField = null) : int
        {
            var _loc_3:* = int(this._witAddTxt.text);
            var _loc_4:* = int(this._strengthAddTxt.text);
            var _loc_5:* = int(this._agileAddTxt.text);
            var _loc_6:* = int(this._powerAddTxt.text);
            if (param2 != null)
            {
                switch(param2)
                {
                    case this._powerAddTxt:
                    {
                        _loc_6 = 0;
                        break;
                    }
                    case this._agileAddTxt:
                    {
                        _loc_5 = 0;
                        break;
                    }
                    case this._strengthAddTxt:
                    {
                        _loc_4 = 0;
                        break;
                    }
                    case this._witAddTxt:
                    {
                        _loc_3 = 0;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            switch(param1)
            {
                case this._powerAddTxt:
                {
                    return this._info.unallocatedTalent - (_loc_3 + _loc_4 + _loc_5);
                }
                case this._agileAddTxt:
                {
                    return this._info.unallocatedTalent - (_loc_6 + _loc_4 + _loc_3);
                }
                case this._strengthAddTxt:
                {
                    return this._info.unallocatedTalent - (_loc_6 + _loc_3 + _loc_5);
                }
                case this._witAddTxt:
                {
                    return this._info.unallocatedTalent - (_loc_6 + _loc_4 + _loc_5);
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public function set lastPoint(param1:int) : void
        {
            this._lastPoint = param1;
            this._lastTalentPoint.text = this._lastPoint.toString();
            this.setPointTxtUseable(this._info.unallocatedTalent > 0);
            if (this._lastPoint > 0 && isOpen)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._recommandBtn);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this._recommandBtn);
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("roletalentplus");
            super.displayReady();
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._powerAddBtn = new BaseButton(getDisplayChildByName("powerAddBtn"));
            this._powerSubBtn = new BaseButton(getDisplayChildByName("powerSubBtn"));
            this._agileAddBtn = new BaseButton(getDisplayChildByName("agileAddBtn"));
            this._agileSubBtn = new BaseButton(getDisplayChildByName("agileSubBtn"));
            this._strengthAddBtn = new BaseButton(getDisplayChildByName("strengthAddBtn"));
            this._strengthSubBtn = new BaseButton(getDisplayChildByName("strengthSubBtn"));
            this._witAddBtn = new BaseButton(getDisplayChildByName("witAddBtn"));
            this._witSubBtn = new BaseButton(getDisplayChildByName("witSubBtn"));
            this._recommandBtn = new BaseButton(getDisplayChildByName("recommandBtn"));
            this._addTalentBtn = new BaseButton(getDisplayChildByName("addTalentBtn"));
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._totalTalentPoint = getDisplayChildByName("txt_totalTalentPoint");
            this._lastTalentPoint = getDisplayChildByName("txt_lastTalentPoint");
            this._witTxt = getDisplayChildByName("txt_wit");
            this._powerTxt = getDisplayChildByName("txt_power");
            this._strengthTxt = getDisplayChildByName("txt_strength");
            this._agileTxt = getDisplayChildByName("txt_agile");
            this._physicalAttacksTxt = getDisplayChildByName("txt_physicalAttacks");
            this._attackRateTxt = getDisplayChildByName("txt_attackRate");
            this._defenceTxt = getDisplayChildByName("txt_defence");
            this._defenceRateTxt = getDisplayChildByName("txt_defenceRate");
            this._attackSpeedTxt = getDisplayChildByName("txt_attackSpeed");
            this._HPTxt = getDisplayChildByName("txt_HP");
            this._EPTxt = getDisplayChildByName("txt_EP");
            this._magicAttackTxt = getDisplayChildByName("txt_magicAttack");
            this._strengthAddTxt = getDisplayChildByName("txt_strengthAdd");
            this._strengthAddTxt.restrict = "0-9";
            this._powerAddTxt = getDisplayChildByName("txt_powerAdd");
            this._powerAddTxt.restrict = "0-9";
            this._agileAddTxt = getDisplayChildByName("txt_agileAdd");
            this._agileAddTxt.restrict = "0-9";
            this._witAddTxt = getDisplayChildByName("txt_witAdd");
            this._witAddTxt.restrict = "0-9";
            this._powerAddBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._powerSubBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._agileAddBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._agileSubBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._strengthAddBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._strengthSubBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._witAddBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this._witSubBtn.addEvtListener(MouseEvent.MOUSE_DOWN, this.__mouseDown);
            this.closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._addTalentBtn.setText(LanguageCfgObj.getInstance().getByIndex("11063"), true);
            this._recommandBtn.setText(LanguageCfgObj.getInstance().getByIndex("11064"));
            this._recommandBtn.addEvtListener(MouseEvent.CLICK, this.__recomandClick);
            this._addTalentBtn.addEvtListener(MouseEvent.CLICK, this.__addClick);
            this.setInfo(UserObj.getInstance().playerInfo);
            this.addListener();
            return;
        }// end function

        public function setInfo(param1:PlayerInfo) : void
        {
            this._info = param1;
            this._newRoleDefaultPoint = NewRoleDefaultValueObj.getInstance().getDefaultPoint(this._info.job);
            this.lastPoint = 0;
            this.updateUI();
            return;
        }// end function

        private function addListener() : void
        {
            this._info.addEvtListener(RoleEvent.UPDATE_UNALLOCALTEDTALENT, this.__unlocatePoint);
            this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MP, this.__updateMP);
            this._info.addEvtListener(RoleEvent.UPDATE_HPMAX, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MPMAX, this.__updateMP);
            this._info.addEvtListener(RoleEvent.UPDATE_PHYSIC_ATTACKLOWER, this.__updateAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_PHYSIC_ATTACKUPPER, this.__updateAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_MAGIC_ATTACKLOWER, this.__updateMagicAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_MAGIC_ATTACKUPPER, this.__updateMagicAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_DEFENSE, this.__updateDefense);
            this._info.addEvtListener(RoleEvent.UPDATE_ATTACKSPEED, this.__updateAttackSpeed);
            this._info.addEvtListener(RoleEvent.UPDATE_DODGE, this.__updateDefensePercent);
            this._info.addEvtListener(RoleEvent.UPDATE_ATTACK_PERCENT, this.__updateAttackPercent);
            addEventListener(UIEvent.BOX_LAYOUT_COMPLETE, this.showComplete);
            return;
        }// end function

        private function showComplete(event:UIEvent) : void
        {
            this.registerGuide();
            return;
        }// end function

        private function __unlocatePoint(event:RoleEvent) : void
        {
            this.setUnallocatedTalent(this._info.unallocatedTalent);
            return;
        }// end function

        private function clearAdd() : void
        {
            this._powerAddTxt.text = "0";
            this._agileAddTxt.text = "0";
            this._strengthAddTxt.text = "0";
            this._witAddTxt.text = "0";
            this._tempPower = this._info.strength;
            this._tempAgile = this._info.agile;
            this._tempWit = this._info.intelligence;
            this._tempStrength = this._info.vitality;
            return;
        }// end function

        private function updateUI() : void
        {
            this.countTotal();
            this.setUnallocatedTalent(this._info.unallocatedTalent);
            this.clearAdd();
            this.countAttribute();
            this.setPowerRegion();
            this.setAgileRegion();
            this.setWitRegion();
            this.setStrengthRegion();
            return;
        }// end function

        private function countAttribute() : void
        {
            this._tempPower = this._info.strength + int(this._powerAddTxt.text);
            this._tempStrength = this._info.vitality + int(this._strengthAddTxt.text);
            this._tempAgile = this._info.agile + int(this._agileAddTxt.text);
            this._tempWit = this._info.intelligence + int(this._witAddTxt.text);
            return;
        }// end function

        private function setUnallocatedTalent(param1:int) : void
        {
            this.lastPoint = param1;
            return;
        }// end function

        private function setPowerRegion(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                param1 = this._info.strength;
            }
            this._powerTxt.htmlText = param1.toString();
            this.effectPower();
            return;
        }// end function

        private function __updateDefensePercent(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            if (this._tempAgile == this._info.agile)
            {
                this._defenceTxt.htmlText = this._info.defense.toString();
                this._defenceRateTxt.htmlText = this._info.dodge.toString();
                this._attackSpeedTxt.htmlText = this._info.attackspeed.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function __updateAttackPercent(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._tempPower == this._info.strength)
            {
                this._attackRateTxt.htmlText = this._info.attackPercent.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.MAGICER_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.MAGICER_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.BOWMAN_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.BOWMAN_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function setAgileRegion(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                param1 = this._info.agile;
            }
            this._agileTxt.htmlText = param1.toString();
            this.effectAgile();
            return;
        }// end function

        private function setStrengthRegion(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                param1 = this._info.vitality;
            }
            this._strengthTxt.htmlText = "" + param1.toString() + "";
            this.effectStrength();
            return;
        }// end function

        private function setWitRegion(param1:int = 0) : void
        {
            if (param1 == 0)
            {
                param1 = this._info.intelligence;
            }
            this._witTxt.htmlText = param1.toString();
            this.effectWit();
            return;
        }// end function

        private function countTotal() : void
        {
            var _loc_1:* = this._info.agile + this._info.vitality + this._info.strength + this._info.intelligence - this._newRoleDefaultPoint;
            if (this._totalTalentPoint)
            {
                this._totalTalentPoint.htmlText = _loc_1.toString();
            }
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __updateAttackSpeed(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            if (this._tempAgile == this._info.agile)
            {
                this._attackSpeedTxt.htmlText = this._info.attackspeed.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function __updateDefense(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            if (this._tempAgile == this._info.agile)
            {
                this._defenceTxt.htmlText = this._info.defense.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        this.updateDefenceForBowMan();
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function updateMagicAttack() : void
        {
            this.__updateMagicAttack();
            return;
        }// end function

        private function __updateMagicAttack(event:RoleEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._tempWit == this._info.intelligence)
            {
                this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1);
                        _loc_3 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9);
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "<font color=\'#00ff00\'>+" + _loc_3 + "</font>-" + this._info.magic_attackupper + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function __recomandClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            ClickStream.add(ClickStreamId.CLICK_TuiJianJiaDian);
            if (this._lastPoint > 0)
            {
                _loc_2 = RecommandTalentPlusObj.getInstance().getPlus(this._info.job, this._info.level);
                _loc_2 = RoleAddPointUtil.getAddPoint(_loc_2, UserObj.getInstance().playerInfo.job);
                _loc_3 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12171"), [_loc_2.strength, _loc_2.agile, _loc_2.vitality, _loc_2.intelligence]);
                this._popBox = Global.popManager.cue(_loc_3, LanguageCfgObj.getInstance().getByIndex("11064"), [_loc_2], this.yesToRecommand, null, 2, null, false, false, null) as SysCueBox;
                if (this._popBox)
                {
                    GuideMultiControl.getInstance().registerGuide(this._popBox.yesBtn, this, GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_3);
                    GuideMultiControl.getInstance().registerGuide(this._popBox.yesBtn, this, GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_2);
                    this._popBox.addEventListener(Event.REMOVED_FROM_STAGE, this.__popRemove);
                }
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11066"));
            }
            return;
        }// end function

        private function __popRemove(event:Event) : void
        {
            this._popBox = null;
            this.guidePause(GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_3);
            this.guidePause(GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_2);
            return;
        }// end function

        private function getPoint(param1:Object) : Object
        {
            var _loc_4:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_2:* = this._info.unallocatedTalent;
            var _loc_3:* = {};
            var _loc_5:* = [];
            var _loc_6:* = [false, false, false, false];
            if (this._info.jobkind == JobType.WARRIOR)
            {
                _loc_5 = ["strength", "agile", "vitality", "intelligence", "str_limit", "agi_limit", "vit_limit", "int_limit"];
            }
            else if (this._info.jobkind == JobType.MAGICER)
            {
                _loc_5 = ["intelligence", "agile", "vitality", "strength", "int_limit", "agi_limit", "vit_limit", "str_limit"];
            }
            else if (this._info.jobkind == JobType.BOWMAN)
            {
                _loc_5 = ["agile", "intelligence", "vitality", "strength", "agi_limit", "int_limit", "vit_limit", "str_limit"];
            }
            var _loc_7:* = {};
            var _loc_8:* = 0;
            while (_loc_8 < 4)
            {
                
                _loc_3[_loc_5[_loc_8]] = 0;
                _loc_7[_loc_5[_loc_8]] = this._info[_loc_5[[_loc_8]]];
                _loc_8++;
            }
            var _loc_9:* = false;
            while (_loc_2 > 0)
            {
                
                var _loc_13:* = _loc_2 > 5 ? (5) : (_loc_2);
                _loc_10 = _loc_2 > 5 ? (5) : (_loc_2);
                _loc_11 = _loc_13;
                _loc_8 = 0;
                while (_loc_8 < 4)
                {
                    
                    if (_loc_7[_loc_5[_loc_8]] >= int(param1[_loc_5[4 + _loc_8]]))
                    {
                        _loc_6[_loc_8] = true;
                        _loc_9 = true;
                    }
                    else if (_loc_3[_loc_5[_loc_8]] + int(param1[_loc_5[_loc_8]]) + _loc_7[_loc_5[_loc_8]] <= int(param1[_loc_5[4 + _loc_8]]) && int(param1[_loc_5[_loc_8]] <= _loc_11))
                    {
                        _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + int(param1[_loc_5[_loc_8]]);
                        _loc_11 = _loc_11 - param1[_loc_5[_loc_8]];
                    }
                    else if (_loc_3[_loc_5[_loc_8]] + int(param1[_loc_5[_loc_8]]) + _loc_7[_loc_5[_loc_8]] <= int(param1[_loc_5[4 + _loc_8]]) && int(param1[_loc_5[_loc_8]]) > _loc_11)
                    {
                        _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + _loc_11;
                        _loc_11 = 0;
                    }
                    else if (_loc_3[_loc_5[_loc_8]] + int(param1[_loc_5[_loc_8]]) + _loc_7[_loc_5[_loc_8]] > int(param1[_loc_5[4 + _loc_8]]) && int(param1[_loc_5[_loc_8]]) > _loc_11)
                    {
                        if (_loc_3[_loc_5[_loc_8]] + _loc_11 + _loc_7[_loc_5[_loc_8]] >= int(param1[_loc_5[4 + _loc_8]]))
                        {
                            _loc_11 = _loc_11 - (int(param1[_loc_5[4 + _loc_8]]) - _loc_3[_loc_5[_loc_8]] - _loc_7[_loc_5[_loc_8]]);
                            _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + (int(param1[_loc_5[4 + _loc_8]]) - _loc_3[_loc_5[_loc_8]] - _loc_7[_loc_5[_loc_8]]);
                            _loc_6[_loc_8] = true;
                            _loc_9 = true;
                            ;
                        }
                        else if (_loc_3[_loc_5[_loc_8]] + _loc_11 + _loc_7[_loc_5[_loc_8]] < int(param1[_loc_5[4 + _loc_8]]))
                        {
                            _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + _loc_11;
                            _loc_11 = 0;
                        }
                    }
                    else
                    {
                        _loc_11 = _loc_11 - (int(param1[_loc_5[4 + _loc_8]]) - _loc_3[_loc_5[_loc_8]] - _loc_7[_loc_5[_loc_8]]);
                        _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + (int(param1[_loc_5[4 + _loc_8]]) - _loc_3[_loc_5[_loc_8]] - _loc_7[_loc_5[_loc_8]]);
                        _loc_6[_loc_8] = true;
                        _loc_9 = true;
                        ;
                    }
                    _loc_8++;
                }
                _loc_2 = _loc_2 - (_loc_10 - _loc_11);
                if (_loc_9)
                {
                    break;
                }
            }
            _loc_8 = 0;
            while (_loc_8 < 4)
            {
                
                if (!_loc_6[_loc_8])
                {
                    _loc_12 = _loc_2 - (int(param1[_loc_5[4 + _loc_8]]) - _loc_3[_loc_5[_loc_8]] - _loc_7[_loc_5[_loc_8]]);
                    if (_loc_12 > 0)
                    {
                        _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + (_loc_2 - _loc_12);
                        _loc_2 = _loc_12;
                    }
                    else
                    {
                        _loc_3[_loc_5[_loc_8]] = _loc_3[_loc_5[_loc_8]] + _loc_2;
                        _loc_2 = 0;
                    }
                }
                _loc_8++;
            }
            if (_loc_2 > 0)
            {
                _loc_3[_loc_5[0]] = _loc_3[_loc_5[0]] + _loc_2;
            }
            return _loc_3;
        }// end function

        private function __updateAttack(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (this._info.jobkind == JobType.WARRIOR)
            {
                if (this._tempPower == this._info.strength)
                {
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                    this._attackRateTxt.htmlText = this._info.attackPercent.toString();
                }
                else if (this._info.jobkind == JobType.WARRIOR)
                {
                    _loc_2 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 1.1) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 1.1);
                    _loc_3 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 0.9) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 0.9);
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "<font color=\'#00ff00\'>+" + _loc_3 + "</font>-" + this._info.physic_attackupper + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                }
                else if (this._info.jobkind == JobType.MAGICER)
                {
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                }
                else
                {
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                }
            }
            else if (this._info.jobkind == JobType.BOWMAN)
            {
                if (this._tempAgile == this._info.agile)
                {
                    this._defenceTxt.htmlText = this._info.defense.toString();
                    this._defenceRateTxt.htmlText = this._info.dodge.toString();
                    this._attackSpeedTxt.htmlText = this._info.attackspeed.toString();
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                }
                else
                {
                    _loc_2 = int(this._tempAgile * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1) - int(this._info.agile * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1);
                    _loc_3 = int(this._tempAgile * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9) - int(this._info.agile * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9);
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "<font color=\'#00ff00\'>+" + _loc_3 + "</font>-" + this._info.physic_attackupper + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                }
            }
            else if (this._info.jobkind == JobType.MAGICER)
            {
                this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
            }
            return;
        }// end function

        private function __updateMP(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            if (this._tempWit == this._info.intelligence)
            {
                this._EPTxt.htmlText = this._info.MPMax.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.WARRIOR_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.WARRIOR_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.BOWMAN_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.BOWMAN_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.M_WARRIOR_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.M_WARRIOR_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function __updateHP(event:RoleEvent) : void
        {
            var _loc_2:* = 0;
            if (this._tempStrength == this._info.vitality)
            {
                this._HPTxt.htmlText = this._info.HPMax.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_2 = int(this._tempStrength * RoleAddTalentConst.WARRIOR_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.WARRIOR_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_2 = int(this._tempStrength * RoleAddTalentConst.MAGICER_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.MAGICER_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_2 = int(this._tempStrength * RoleAddTalentConst.BOWMAN_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.BOWMAN_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_2 = int(this._tempStrength * RoleAddTalentConst.M_WARRIOR_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.M_WARRIOR_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function yesToRecommand(param1:Object) : void
        {
            PrimaryRoleControl.getInstance().addPoint(param1.agile, param1.vitality, param1.intelligence, param1.strength);
            return;
        }// end function

        private function updateTalent(param1:Object) : void
        {
            this._powerAddTxt.htmlText = param1.strength;
            this._agileAddTxt.htmlText = param1.agile;
            this._strengthAddTxt.htmlText = param1.vitality;
            this._witAddTxt.htmlText = param1.intelligence;
            return;
        }// end function

        private function updateAttribute(param1:Boolean = false) : void
        {
            switch(this._operType)
            {
                case POWER:
                {
                    break;
                }
                case AGILE:
                {
                    break;
                }
                case WIT:
                {
                    break;
                }
                case STRENGTH:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function effectPower() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._tempPower == this._info.strength)
            {
                if (this._info.jobkind != JobType.BOWMAN)
                {
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                }
                this._attackRateTxt.htmlText = this._info.attackPercent.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 1.1) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 1.1);
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 0.9) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACK * 0.9);
                        this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>-" + this._info.physic_attackupper + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.WARRIOR_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.WARRIOR_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.MAGICER_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.MAGICER_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.BOWMAN_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.BOWMAN_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACK * 1.1) - int(this._info.strength * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACK * 1.1);
                        _loc_2 = int(this._tempPower * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACK * 0.9) - int(this._info.strength * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACK * 0.9);
                        this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>-" + this._info.physic_attackupper + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempPower * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACKRATE) - int(this._info.strength * RoleAddTalentConst.M_WARRIOR_POWER_2_ATTACKRATE);
                        this._attackRateTxt.htmlText = this._info.attackPercent.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function effectAgile() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._tempAgile == this._info.agile)
            {
                this._defenceTxt.htmlText = this._info.defense.toString();
                this._defenceRateTxt.htmlText = this._info.dodge.toString();
                this._attackSpeedTxt.htmlText = this._info.attackspeed.toString();
                if (this._info.jobkind == JobType.BOWMAN)
                {
                    this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
                }
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.WARRIOR_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.WARRIOR_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.MAGICER_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.MAGICER_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACK * 1.1) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACK * 1.1);
                        _loc_2 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACK * 0.9) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACK * 0.9);
                        this._physicalAttacksTxt.htmlText = this._info.physic_attacklower + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>-" + this._info.physic_attackupper + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        this.updateDefenceForBowMan();
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCE);
                        this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCERATE) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_DEFENCERATE);
                        this._defenceRateTxt.htmlText = this._info.dodge.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempAgile * RoleAddTalentConst.M_WARRIOR_AGILE_2_ATTACKSPEED) - int(this._info.agile * RoleAddTalentConst.M_WARRIOR_AGILE_2_ATTACKSPEED);
                        this._attackSpeedTxt.htmlText = this._info.attackspeed.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function updateDefenceForBowMan() : void
        {
            var _loc_1:* = 0;
            _loc_1 = int(this._tempAgile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCE) - int(this._info.agile * RoleAddTalentConst.BOWMAN_AGILE_2_DEFENCE) + int(this._tempWit * RoleAddTalentConst.BOWMAN_WIT_2_DEFENCE) - int(this._info.intelligence * RoleAddTalentConst.BOWMAN_WIT_2_DEFENCE);
            this._defenceTxt.htmlText = this._info.defense.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
            return;
        }// end function

        private function effectWit() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            if (this._tempWit == this._info.intelligence)
            {
                this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                this._EPTxt.htmlText = this._info.MPMax.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        _loc_1 = int(this._tempWit * RoleAddTalentConst.WARRIOR_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.WARRIOR_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = this._tempWit - this._info.intelligence;
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_1 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 1.1);
                        _loc_2 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_ATTACK * 0.9);
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "<font color=\'#00ff00\'>+" + _loc_2 + "</font>-" + this._info.magic_attackupper + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = int(this._tempWit * RoleAddTalentConst.MAGICER_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.MAGICER_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        this.updateDefenceForBowMan();
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        _loc_1 = int(this._tempWit * RoleAddTalentConst.BOWMAN_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.BOWMAN_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        this._magicAttackTxt.htmlText = PrimaryRoleControl.getInstance().lowMagicAttack + "-" + this._info.magic_attackupper;
                        _loc_1 = int(this._tempWit * RoleAddTalentConst.M_WARRIOR_WIT_2_EP) - int(this._info.intelligence * RoleAddTalentConst.M_WARRIOR_WIT_2_EP);
                        this._EPTxt.htmlText = this._info.MPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        _loc_1 = this._tempWit - this._info.intelligence;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function effectStrength() : void
        {
            var _loc_1:* = 0;
            if (this._tempStrength == this._info.vitality)
            {
                this._HPTxt.htmlText = this._info.HPMax.toString();
            }
            else
            {
                switch(this._info.jobkind)
                {
                    case JobType.WARRIOR:
                    {
                        _loc_1 = int(this._tempStrength * RoleAddTalentConst.WARRIOR_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.WARRIOR_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.MAGICER:
                    {
                        _loc_1 = int(this._tempStrength * RoleAddTalentConst.MAGICER_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.MAGICER_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.BOWMAN:
                    {
                        _loc_1 = int(this._tempStrength * RoleAddTalentConst.BOWMAN_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.BOWMAN_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    case JobType.K_M_WARRIOR:
                    {
                        _loc_1 = int(this._tempStrength * RoleAddTalentConst.M_WARRIOR_STRENGTH_2_HP) - int(this._info.vitality * RoleAddTalentConst.M_WARRIOR_STRENGTH_2_HP);
                        this._HPTxt.htmlText = this._info.HPMax.toString() + "<font color=\'#00ff00\'>+" + _loc_1 + "</font>";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.updateUI();
            }
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._powerAddBtn:
                {
                    this._targetText = this._powerAddTxt;
                    this._operType = POWER;
                    this._addOper = 1;
                    break;
                }
                case this._powerSubBtn:
                {
                    this._targetText = this._powerAddTxt;
                    this._operType = POWER;
                    this._addOper = -1;
                    break;
                }
                case this._agileAddBtn:
                {
                    this._targetText = this._agileAddTxt;
                    this._operType = AGILE;
                    this._addOper = 1;
                    break;
                }
                case this._agileSubBtn:
                {
                    this._targetText = this._agileAddTxt;
                    this._operType = AGILE;
                    this._addOper = -1;
                    break;
                }
                case this._strengthAddBtn:
                {
                    this._targetText = this._strengthAddTxt;
                    this._operType = STRENGTH;
                    this._addOper = 1;
                    break;
                }
                case this._strengthSubBtn:
                {
                    this._targetText = this._strengthAddTxt;
                    this._operType = STRENGTH;
                    this._addOper = -1;
                    break;
                }
                case this._witAddBtn:
                {
                    this._targetText = this._witAddTxt;
                    this._operType = WIT;
                    this._addOper = 1;
                    break;
                }
                case this._witSubBtn:
                {
                    this._targetText = this._witAddTxt;
                    this._operType = WIT;
                    this._addOper = -1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._orginValue = int(this._targetText.text);
            this._preTime = getTimer();
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            this._timeOutId = setTimeout(this.addToEnterFrame, 200);
            return;
        }// end function

        private function addToEnterFrame() : void
        {
            clearTimeout(this._timeOutId);
            if (this._addOper != 1 || this._lastPoint != 0)
            {
                this._orginPoint = this.lastPoint;
                addEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            }
            return;
        }// end function

        private function __mouseUp(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.__mouseUp);
            clearTimeout(this._timeOutId);
            var _loc_2:* = int(this._targetText.text);
            if (_loc_2 == this._orginValue)
            {
                if (this._addOper == 1 && this._lastPoint > 0)
                {
                    _loc_2 = _loc_2 + 1;
                    (this.lastPoint - 1);
                }
                else if (this._addOper == -1 && this._orginValue > 0)
                {
                    _loc_2 = _loc_2 - 1;
                    (this.lastPoint + 1);
                }
                this.setTargetText(this._targetText, _loc_2);
            }
            this._orginPoint = 0;
            removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
            this.countAttribute();
            this.updateAttribute();
            this._addOper = 0;
            this._operType = 0;
            this._targetText = null;
            this._preTime = 0;
            return;
        }// end function

        private function setTargetText(param1:TextField, param2:int) : void
        {
            if (int(param1.text) != param2)
            {
                param1.text = param2.toString();
            }
            return;
        }// end function

        private function __addClick(event:MouseEvent) : void
        {
            var _loc_2:* = int(this._powerAddTxt.text);
            var _loc_3:* = int(this._agileAddTxt.text);
            var _loc_4:* = int(this._strengthAddTxt.text);
            var _loc_5:* = int(this._witAddTxt.text);
            var _loc_6:* = _loc_2 | _loc_3 | _loc_4 | _loc_5;
            ClickStream.add(ClickStreamId.CLICK_JiaDian);
            if (_loc_6 != 0)
            {
                PrimaryRoleControl.getInstance().addPoint(_loc_3, _loc_4, _loc_5, _loc_2);
            }
            return;
        }// end function

        private function __OperEnterFrame(event:Event) : void
        {
            var _loc_2:* = 0;
            if (this._preTime == 0 || this._targetText == null || this._addOper == 0)
            {
                removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                this._addOper = 0;
                return;
            }
            var _loc_3:* = int((getTimer() - this._preTime) * 0.01);
            if (this._addOper == 1)
            {
                if (_loc_3 >= this._orginPoint)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                    this._addOper = 0;
                    _loc_3 = this._orginPoint;
                }
                _loc_2 = this._orginValue + _loc_3;
            }
            else if (this._addOper == -1)
            {
                _loc_2 = this._orginValue - _loc_3;
                if (_loc_2 <= 0)
                {
                    removeEvtListener(Event.ENTER_FRAME, this.__OperEnterFrame);
                    this._addOper = 0;
                    _loc_2 = 0;
                }
            }
            this._targetText.text = _loc_2.toString();
            this.countAttribute();
            this.updateAttribute();
            if (this._orginPoint != -1)
            {
                this.lastPoint = this._orginPoint - (Number(this._targetText.text) - this._orginValue);
            }
            return;
        }// end function

        public function addPointRes(param1:int) : void
        {
            if (param1)
            {
                this.updateUI();
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.guidePause(GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_2);
            this.guidePause(GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_1);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._recommandBtn);
            return;
        }// end function

        public function registerGuide() : void
        {
            GuideMultiControl.getInstance().registerGuide(this._recommandBtn, this, GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_2);
            GuideMultiControl.getInstance().registerGuide(this._recommandBtn, this, GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_1);
            GuideMultiControl.getInstance().unHideGuide(GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_1);
            return;
        }// end function

        public function guideAction(param1:String) : void
        {
            return;
        }// end function

        public function guidePause(param1:String) : void
        {
            if (param1 == GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_3)
            {
                GuideMultiControl.getInstance().backGuide(param1, 2);
            }
            if (param1 == GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_2)
            {
                GuideMultiControl.getInstance().backGuide(param1, 1);
            }
            if (param1 == GuideConfigObj.getInstance().ROLE_POINT_SY_GUIDE_ID_1)
            {
                GuideMultiControl.getInstance().hideGuide(param1);
            }
            if (param1 == GuideConfigObj.getInstance().ROLE_POINT_GUIDE_ID_2)
            {
                GuideMultiControl.getInstance().backGuide(param1, 1);
            }
            return;
        }// end function

        public function guideEnd(param1:String) : void
        {
            return;
        }// end function

        public function isGuideReady() : Boolean
        {
            return UILoaded && isOpen;
        }// end function

    }
}
