package com.game.primaryrole.view
{
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.image.*;
    import com.f1.ui.stripe.*;
    import com.game.primaryrole.control.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class RoleInfoPanel extends BaseBox
    {
        private var _image:Image;
        private var _nameTxt:TextField;
        private var _levelTxt:TextField;
        private var _pkTxt:TextField;
        private var _professionTxt:TextField;
        private var _hpStripe:Stripe;
        private var _epStripe:Stripe;
        private var _physicalAttacksTxt:TextField;
        private var _attackRateTxt:TextField;
        private var _defenceTxt:TextField;
        private var _defenceRateTxt:TextField;
        private var _attackSpeedTxt:TextField;
        private var _magicAttackTxt:TextField;
        private var _ice_defTxt:TextField;
        private var _poison_defTxt:TextField;
        private var _ray_defTxt:TextField;
        private var _speedTxt:TextField;
        private var _ignoreAttackTxt:TextField;
        private var closeBtn:BaseButton;
        private var _criticalTxt:TextField;
        private var _excellentAttackTxt:TextField;
        private var _txt_fatal_blow:TextField;
        private var txt_pk:TextField;
        private var _info:PlayerInfo;

        public function RoleInfoPanel()
        {
            loadDisplay("res/roleinfo.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("roleinfo");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._attackRateTxt = getDisplayChildByName("txt_attackRate");
            this._defenceTxt = getDisplayChildByName("txt_defence");
            this._defenceRateTxt = getDisplayChildByName("txt_defenceRate");
            this._levelTxt = getDisplayChildByName("txt_level");
            this._hpStripe = new Stripe(getDisplayChildByName("hpBar"));
            this._epStripe = new Stripe(getDisplayChildByName("epBar"));
            this._nameTxt = getDisplayChildByName("txt_name");
            this._physicalAttacksTxt = getDisplayChildByName("txt_physicalAttacks");
            this._magicAttackTxt = getDisplayChildByName("txt_magicattack");
            this._defenceTxt = getDisplayChildByName("txt_defence");
            this._attackSpeedTxt = getDisplayChildByName("txt_attackSpeed");
            this._ice_defTxt = getDisplayChildByName("txt_iceDefence");
            this._ray_defTxt = getDisplayChildByName("txt_rayDefence");
            this._poison_defTxt = getDisplayChildByName("txt_poisonDefence");
            this._speedTxt = getDisplayChildByName("txt_speed");
            this._defenceRateTxt = getDisplayChildByName("txt_defenceRate");
            this._ignoreAttackTxt = getDisplayChildByName("txt_ignorelDefence");
            this._attackRateTxt = getDisplayChildByName("txt_attackRate");
            this._criticalTxt = getDisplayChildByName("txt_critical");
            this._excellentAttackTxt = getDisplayChildByName("txt_excellentAttack");
            this._txt_fatal_blow = getDisplayChildByName("txt_fatal_blow");
            this._professionTxt = getDisplayChildByName("txt_profession");
            this.txt_pk = getDisplayChildByName("txt_pk");
            this._image = new Image();
            this._image.x = getDisplayChildByName("img").x;
            this._image.y = getDisplayChildByName("img").y;
            addChild(this._image);
            this.info = UserObj.getInstance().playerInfo;
            this.addListener();
            return;
        }// end function

        private function updateUI() : void
        {
            this.setImage(this._info.job, this._info.level);
            this.setLevel(this._info.level);
            this.setName(this._info.name);
            this.setProfession();
            this._epStripe.setValue(this._info.MP, this._info.MPMax);
            this._hpStripe.setValue(this._info.HP, this._info.HPMax);
            this.setPhysicalAttack(this._info.physic_attacklower, this._info.physic_attackupper);
            this.setMagicAttack(PrimaryRoleControl.getInstance().lowMagicAttack, this._info.magic_attackupper);
            this.setDefence(this._info.defense);
            this.setAttackSpeed(this._info.attackspeed);
            this.setIceDef(this._info.ice_def);
            this.setPoisonDef(this._info.poison_def);
            this.setRayDef(this._info.ray_def);
            this.setSpeed(this._info.speed);
            this.setAttackPercent(this._info.attackPercent);
            this.setDefenceRate(this._info.dodge);
            this.setIgnoreAttack(this._info.ignore_attackPercent);
            this.setCritical(this._info.Knowing_attackPercent);
            this.setExcellent(this._info.crit);
            this.setFatal_blow(this._info.fatal_blow);
            this.setPkValue(this._info.pkValue);
            return;
        }// end function

        public function updateMagicAttack() : void
        {
            this.setMagicAttack(PrimaryRoleControl.getInstance().lowMagicAttack, this._info.magic_attackupper);
            return;
        }// end function

        private function setPkValue(param1:int) : void
        {
            this.txt_pk.text = "" + param1;
            return;
        }// end function

        private function setProfession() : void
        {
            this._professionTxt.text = RoleInfo.getJobName(this._info.job);
            return;
        }// end function

        private function setAttackPercent(param1:int) : void
        {
            this._attackRateTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setDefenceRate(param1:int) : void
        {
            this._defenceRateTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setIgnoreAttack(param1:int) : void
        {
            this._ignoreAttackTxt.htmlText = param1 / 100 + "%";
            return;
        }// end function

        private function setExcellent(param1:int) : void
        {
            this._excellentAttackTxt.htmlText = param1 / 100 + "%";
            return;
        }// end function

        private function setFatal_blow(param1:int) : void
        {
            this._txt_fatal_blow.htmlText = int(param1 / 100) + "%";
            return;
        }// end function

        private function setCritical(param1:int) : void
        {
            this._criticalTxt.htmlText = param1 / 100 + "%";
            return;
        }// end function

        private function setPoisonDef(param1:int) : void
        {
            this._poison_defTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setRayDef(param1:int) : void
        {
            this._ray_defTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setSpeed(param1:int) : void
        {
            this._speedTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setIceDef(param1:int) : void
        {
            this._ice_defTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setAttackSpeed(param1:int) : void
        {
            this._attackSpeedTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setDefence(param1:int) : void
        {
            this._defenceTxt.htmlText = param1.toString();
            return;
        }// end function

        private function setMagicAttack(param1:int, param2:int) : void
        {
            this._magicAttackTxt.htmlText = param1 + "-" + param2;
            return;
        }// end function

        private function setPhysicalAttack(param1:int, param2:int) : void
        {
            this._physicalAttacksTxt.htmlText = param1 + "-" + param2;
            return;
        }// end function

        private function setImage(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            if (RoleLevelUtil.isMasterLevel(param2))
            {
                _loc_3 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((param1 - 1) % 3 + 1) + "-4.png";
            }
            else
            {
                _loc_3 = Params.ROLE_HEAD_PANEL_PATH + "job" + ((param1 - 1) % 3 + 1) + ".png";
            }
            if (this._image)
            {
                this._image.load(_loc_3);
            }
            return;
        }// end function

        private function addTips() : void
        {
            return;
        }// end function

        public function set info(param1:PlayerInfo) : void
        {
            if (param1 != this._info)
            {
                this._info = param1;
                this.updateUI();
                this.addListener();
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._info.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__updateLevel);
            this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MP, this.__updatMP);
            this._info.addEvtListener(RoleEvent.UPDATE_HPMAX, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MPMAX, this.__updatMP);
            this._info.addEvtListener(RoleEvent.UPDATE_PHYSIC_ATTACKLOWER, this.__updateAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_PHYSIC_ATTACKUPPER, this.__updateAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_MAGIC_ATTACKLOWER, this.__updateMagicAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_MAGIC_ATTACKUPPER, this.__updateMagicAttack);
            this._info.addEvtListener(RoleEvent.UPDATE_DEFENSE, this.__updateDefense);
            this._info.addEvtListener(RoleEvent.UPDATE_ATTACKSPEED, this.__updateAttackSpeed);
            this._info.addEvtListener(RoleEvent.UPDATE_ICE_DEF, this.__updateIceDef);
            this._info.addEvtListener(RoleEvent.UPDATE_RAY_DEF, this.__updateRayDef);
            this._info.addEvtListener(RoleEvent.UPDATE_POISON_DEF, this.__updatePoisonDef);
            this._info.addEvtListener(RoleEvent.UPDATE_SPEED, this.__updateSpeed);
            this._info.addEvtListener(RoleEvent.UPDATE_DODGE, this.__updateDefensePercent);
            this._info.addEvtListener(RoleEvent.UPDATE_IGNORE_ATTACKPERCENT, this.__updateIgnore);
            this._info.addEvtListener(RoleEvent.UPDATE_ATTACK_PERCENT, this.__updateAttackPercent);
            this._info.addEvtListener(RoleEvent.UPDATE_CRIT, this.__updateCritical);
            this._info.addEvtListener(RoleEvent.UPDATE_FATAL_BLOW, this.__updateFatalBlow);
            this._info.addEvtListener(RoleEvent.UPDATE_KNOWING_ATTACKPERCENT, this.__updateKnowing);
            this.closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        private function __updateMagicAttack(event:RoleEvent) : void
        {
            this.setMagicAttack(this._info.magic_attacklower, this._info.magic_attackupper);
            return;
        }// end function

        private function __updateAttack(event:RoleEvent) : void
        {
            this.setPhysicalAttack(this._info.physic_attacklower, this._info.physic_attackupper);
            return;
        }// end function

        private function __updateLevel(event:RoleEvent) : void
        {
            this.setLevel(this._info.level);
            return;
        }// end function

        private function __updateHP(event:RoleEvent) : void
        {
            this._hpStripe.setValue(this._info.HP, this._info.HPMax);
            return;
        }// end function

        private function __updatMP(event:RoleEvent) : void
        {
            this._epStripe.setValue(this._info.MP, this._info.MPMax);
            return;
        }// end function

        private function __updateDefense(event:RoleEvent) : void
        {
            this.setDefence(this._info.defense);
            return;
        }// end function

        private function __updateAttackSpeed(event:RoleEvent) : void
        {
            this.setAttackSpeed(this._info.attackspeed);
            return;
        }// end function

        private function __updateIceDef(event:RoleEvent) : void
        {
            this.setIceDef(this._info.ice_def);
            return;
        }// end function

        private function __updateRayDef(event:RoleEvent) : void
        {
            this.setRayDef(this._info.ray_def);
            return;
        }// end function

        private function __updatePoisonDef(event:RoleEvent) : void
        {
            this.setPoisonDef(this._info.poison_def);
            return;
        }// end function

        private function __updateSpeed(event:RoleEvent) : void
        {
            this.setSpeed(this._info.speed);
            return;
        }// end function

        private function __updateAttackPercent(event:RoleEvent) : void
        {
            this.setAttackPercent(this._info.attackPercent);
            return;
        }// end function

        private function __updateDefensePercent(event:RoleEvent) : void
        {
            this.setDefenceRate(this._info.dodge);
            return;
        }// end function

        private function __updateIgnore(event:RoleEvent) : void
        {
            this.setIgnoreAttack(this._info.ignore_attackPercent);
            return;
        }// end function

        private function __updateCritical(event:RoleEvent) : void
        {
            this.setExcellent(this._info.crit);
            return;
        }// end function

        private function __updateFatalBlow(event:RoleEvent) : void
        {
            this.setFatal_blow(this._info.fatal_blow);
            return;
        }// end function

        private function __updateKnowing(event:RoleEvent) : void
        {
            this.setCritical(this._info.Knowing_attackPercent);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        public function setLevel(param1:uint) : void
        {
            this._levelTxt.htmlText = RoleLevelUtil.getMasterLevel(param1);
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

        public function setName(param1:String) : void
        {
            if (!param1)
            {
                param1 = this._info.name;
            }
            this._nameTxt.htmlText = param1;
            return;
        }// end function

    }
}
