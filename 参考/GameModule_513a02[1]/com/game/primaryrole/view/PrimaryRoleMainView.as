package com.game.primaryrole.view
{
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.guide.event.*;
    import com.game.guide.model.*;
    import com.game.guild.model.*;
    import com.game.player.events.*;
    import com.game.player.model.*;
    import com.game.player.view.*;
    import com.game.primaryrole.control.*;
    import com.game.remark.model.*;
    import com.game.remark.tips.*;
    import com.game.role.util.*;
    import com.game.sound.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class PrimaryRoleMainView extends Component
    {
        private var _userObj:UserObj;
        private var _expBarNormal:Stripe;
        private var _expBarMaster:Stripe;
        private var _titleBtn:BaseButton;
        private var _plusTalentbtn:BaseButton;
        private var _infoBtn:BaseButton;
        private var _powerTxt:TextField;
        private var _HPTxt:TextField;
        private var _forceTxt:TextField;
        private var _agileTxt:TextField;
        private var _witTxt:TextField;
        private var _professionTxt:TextField;
        private var _allianceTxt:TextField;
        private var _allianceLabel:TextField;
        private var _EPTxt:TextField;
        private var _strengthTxt:TextField;
        private var _primaryRoleControl:PrimaryRoleControl;
        private var _info:PlayerInfo;
        private var _type:String;
        private var _head_mc:RoleEquipBox;
        private var _hand_mc:RoleEquipBox;
        private var _wing_mc:RoleEquipBox;
        private var _pet_mc:RoleEquipBox;
        private var _nicklace_mc:RoleEquipBox;
        private var _left_weapon_mc:RoleEquipBox;
        private var _right_weapon_mc:RoleEquipBox;
        private var _ring_1_mc:RoleEquipBox;
        private var _ring_2_mc:RoleEquipBox;
        private var _shoe_mc:RoleEquipBox;
        private var _leg_mc:RoleEquipBox;
        private var _body_mc:RoleEquipBox;
        private var _remarkPoint:BaseButton;
        private var _intensifyPoint:BaseButton;
        private var _equipsObj:EquipsObj;
        private var _remark_inactivatePoint:BaseButton;
        private var _instensify_inactivatePoint:BaseButton;
        private var _equipArr:Array;
        private static const MASTER_TYPE:int = 1;
        private static const SERVANT_TYPE:int = 2;
        private static const HORSE_TYPE:int = 3;

        public function PrimaryRoleMainView(param1 = null, param2:String = null)
        {
            this._equipArr = [];
            super(param1, param2);
            this.initUI();
            return;
        }// end function

        public function get info() : PlayerInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PlayerInfo) : void
        {
            this._info = param1;
            this.updateUI();
            this.addListener();
            return;
        }// end function

        public function addListener() : void
        {
            this._info.addEvtListener(RoleEvent.UPDATE_EXP, this.__expUpdate);
            this._info.addEvtListener(RoleEvent.UPDATE_HP, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_HPMAX, this.__updateHP);
            this._info.addEvtListener(RoleEvent.UPDATE_MPMAX, this.__updateMP);
            this._info.addEvtListener(RoleEvent.UPDATE_MP, this.__updateMP);
            this._info.addEvtListener(RoleEvent.UPDATE_STRENGTH, this.__updateStrength);
            this._info.addEvtListener(RoleEvent.UPDATE_AGILE, this.__updateAgile);
            this._info.addEvtListener(RoleEvent.UPDATE_INTELLIGENCE, this.__updateIntelligence);
            this._info.addEvtListener(RoleEvent.UPDATE_VITALITY, this.__updateVitality);
            return;
        }// end function

        private function initUI() : void
        {
            this._equipsObj = EquipsObj.getInstance();
            this._expBarNormal = new Stripe(getDisplayChildByName("expBar"));
            this._expBarMaster = new Stripe(getDisplayChildByName("expBarMaster"));
            this._infoBtn = new BaseButton(getDisplayChildByName("btn_roleInfo"));
            this._infoBtn.addEvtListener(MouseEvent.CLICK, this.__infoClick, false, true);
            this._infoBtn.setText(LanguageCfgObj.getInstance().getByIndex("11048"), true);
            this._plusTalentbtn = new BaseButton(getDisplayChildByName("btn_plusTalent"));
            this._plusTalentbtn.addEvtListener(MouseEvent.CLICK, this.__plusTalentClick);
            this._plusTalentbtn.setText(LanguageCfgObj.getInstance().getByIndex("11049"), true);
            this._titleBtn = new BaseButton(getDisplayChildByName("btn_title"));
            this._titleBtn.addEvtListener(MouseEvent.CLICK, this.onTitleHandler);
            this._titleBtn.setText(LanguageCfgObj.getInstance().getByIndex("11050"), true);
            this._head_mc = new RoleEquipBox(getDisplayChildByName("pos_head"));
            this._head_mc.pos = Params.HEAD;
            this._equipArr.push(this._head_mc);
            this._hand_mc = new RoleEquipBox(getDisplayChildByName("pos_hand"));
            this._hand_mc.pos = Params.HAND;
            this._equipArr.push(this._hand_mc);
            this._wing_mc = new RoleEquipBox(getDisplayChildByName("pos_wing"));
            this._wing_mc.pos = Params.WING;
            this._equipArr.push(this._wing_mc);
            this._pet_mc = new RoleEquipBox(getDisplayChildByName("pos_pet"));
            this._pet_mc.pos = Params.PET;
            this._equipArr.push(this._pet_mc);
            this._nicklace_mc = new RoleEquipBox(getDisplayChildByName("pos_nicklace"));
            this._nicklace_mc.pos = Params.NICKLACE;
            this._equipArr.push(this._nicklace_mc);
            this._body_mc = new RoleEquipBox(getDisplayChildByName("pos_body"));
            this._body_mc.pos = Params.BODY;
            this._equipArr.push(this._body_mc);
            this._ring_1_mc = new RoleEquipBox(getDisplayChildByName("pos_ring_1"));
            this._ring_1_mc.pos = Params.RING1;
            this._equipArr.push(this._ring_1_mc);
            this._ring_2_mc = new RoleEquipBox(getDisplayChildByName("pos_ring_2"));
            this._ring_2_mc.pos = Params.RING2;
            this._equipArr.push(this._ring_2_mc);
            this._left_weapon_mc = new RoleEquipBox(getDisplayChildByName("mc_leftweapon"));
            this._left_weapon_mc.pos = Params.LEFT_WEAPON;
            this._equipArr.push(this._left_weapon_mc);
            this._right_weapon_mc = new RoleEquipBox(getDisplayChildByName("mc_rightweapon"));
            this._right_weapon_mc.pos = Params.RIGHT_WEAPON;
            this._equipArr.push(this._right_weapon_mc);
            this._shoe_mc = new RoleEquipBox(getDisplayChildByName("pos_shoe"));
            this._equipArr.push(this._shoe_mc);
            this._shoe_mc.pos = Params.SHOE;
            this._leg_mc = new RoleEquipBox(getDisplayChildByName("pos_leg"));
            this._equipArr.push(this._leg_mc);
            this._leg_mc.pos = Params.LEG;
            this._allianceLabel = getDisplayChildByName("label_alliance");
            this._agileTxt = getDisplayChildByName("txt_agile");
            this._HPTxt = getDisplayChildByName("txt_life");
            this._allianceTxt = getDisplayChildByName("txt_alliance");
            this._strengthTxt = getDisplayChildByName("txt_strength");
            this._forceTxt = getDisplayChildByName("txt_force");
            this._agileTxt = getDisplayChildByName("txt_agile");
            this._witTxt = getDisplayChildByName("txt_wit");
            this._powerTxt = getDisplayChildByName("txt_power");
            this._professionTxt = getDisplayChildByName("txt_profession");
            this._EPTxt = getDisplayChildByName("txt_EP");
            this._HPTxt = getDisplayChildByName("txt_HP");
            this._remarkPoint = new BaseButton(getDisplayChildByName("remark_point"));
            this._remark_inactivatePoint = new BaseButton(getDisplayChildByName("remark_inactivatePoint"));
            this._intensifyPoint = new BaseButton(getDisplayChildByName("intensify_point"));
            this._instensify_inactivatePoint = new BaseButton(getDisplayChildByName("intensify_inactivatePoint"));
            this._equipsObj.addEvtListener(EquipEvent.WEAR, this.__wear);
            this._equipsObj.addEvtListener(EquipEvent.TAKE_OFF, this.__takeoff);
            GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            this.guideConfigComplete();
            return;
        }// end function

        public function setWaterLight(param1:uint, param2:Number) : void
        {
            this._head_mc.setWaterLightTest(param1, param2);
            this._hand_mc.setWaterLightTest(param1, param2);
            this._wing_mc.setWaterLightTest(param1, param2);
            this._pet_mc.setWaterLightTest(param1, param2);
            this._nicklace_mc.setWaterLightTest(param1, param2);
            this._left_weapon_mc.setWaterLightTest(param1, param2);
            this._right_weapon_mc.setWaterLightTest(param1, param2);
            this._ring_1_mc.setWaterLightTest(param1, param2);
            this._ring_2_mc.setWaterLightTest(param1, param2);
            this._shoe_mc.setWaterLightTest(param1, param2);
            this._leg_mc.setWaterLightTest(param1, param2);
            this._body_mc.setWaterLightTest(param1, param2);
            return;
        }// end function

        private function onTitleHandler(event:MouseEvent) : void
        {
            PrimaryRoleControl.getInstance().openTitlePanel();
            return;
        }// end function

        private function __plusTalentClick(event:MouseEvent) : void
        {
            PrimaryRoleControl.getInstance().openTalentPlus();
            return;
        }// end function

        private function __updateHP(event:RoleEvent) : void
        {
            this._HPTxt.htmlText = this._info.HP + "/" + this._info.HPMax;
            return;
        }// end function

        private function __updateMP(event:RoleEvent) : void
        {
            this._EPTxt.htmlText = this._info.MP + "/" + this._info.MPMax;
            return;
        }// end function

        private function __updateStrength(event:RoleEvent) : void
        {
            this._powerTxt.htmlText = this._info.strength.toString();
            return;
        }// end function

        private function __updateAgile(event:RoleEvent) : void
        {
            this._agileTxt.htmlText = this._info.agile.toString();
            return;
        }// end function

        private function __updateIntelligence(event:RoleEvent) : void
        {
            this._witTxt.htmlText = this._info.intelligence.toString();
            return;
        }// end function

        private function __updateVitality(event:RoleEvent) : void
        {
            this._strengthTxt.htmlText = this._info.vitality.toString();
            return;
        }// end function

        private function __takeoff(event:EquipEvent) : void
        {
            var _loc_2:* = event.data.equip as EquipmentInfo;
            var _loc_3:* = event.data.type;
            var _loc_4:* = this.getRoleEquipBox(_loc_3);
            if (this.getRoleEquipBox(_loc_3) != null && _loc_4.info)
            {
                SoundControl.getInstance().playItemSound(SoundFlag.UNWEAREQUIP, _loc_4.info.itemModelId);
                _loc_4.info = null;
            }
            return;
        }// end function

        private function getRoleEquipBox(param1:int) : RoleEquipBox
        {
            var _loc_2:* = param1;
            switch(_loc_2)
            {
                case Params.LEFT_WEAPON:
                {
                    return this._left_weapon_mc;
                }
                case Params.RIGHT_WEAPON:
                {
                    return this._right_weapon_mc;
                }
                case Params.BODY:
                {
                    return this._body_mc;
                }
                case Params.HEAD:
                {
                    return this._head_mc;
                }
                case Params.NICKLACE:
                {
                    return this._nicklace_mc;
                }
                case Params.HAND:
                {
                    return this._hand_mc;
                }
                case Params.LEG:
                {
                    return this._leg_mc;
                }
                case Params.SHOE:
                {
                    return this._shoe_mc;
                }
                case Params.RING1:
                {
                    return this._ring_1_mc;
                }
                case Params.RING2:
                {
                    return this._ring_2_mc;
                }
                case Params.PET:
                {
                    return this._pet_mc;
                }
                case Params.WING:
                {
                    return this._wing_mc;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        private function __wear(event:EquipEvent) : void
        {
            var _loc_2:* = event.data.equip as EquipmentInfo;
            var _loc_3:* = this.getRoleEquipBox(_loc_2.pos);
            _loc_3.info = _loc_2;
            return;
        }// end function

        private function __expUpdate(event:RoleEvent) : void
        {
            this._expBarNormal.setValue(this._info.exp.toNumber(), Number(LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level)));
            this._expBarMaster.setValue(this._info.exp.toNumber(), Number(LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level)));
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                this._expBarMaster.visible = true;
                this._expBarNormal.visible = false;
            }
            else
            {
                this._expBarMaster.visible = false;
                this._expBarNormal.visible = true;
            }
            return;
        }// end function

        private function __infoClick(event:MouseEvent) : void
        {
            PrimaryRoleControl.getInstance().openInfo();
            return;
        }// end function

        public function updateUI() : void
        {
            this._info = UserObj.getInstance().playerInfo;
            this._witTxt.htmlText = this._info.intelligence.toString();
            this._agileTxt.htmlText = this._info.agile.toString();
            this._strengthTxt.htmlText = this._info.vitality.toString();
            this._powerTxt.htmlText = this._info.strength.toString();
            this._allianceLabel.visible = true;
            this._allianceTxt.text = ToolKit.trimDistrict(GuildData.getInstance().getGuildNameById(this._info.guildId));
            this._professionTxt.text = RoleInfo.getJobName(this._info.job);
            if (this._info.job == JobType.WARRIOR)
            {
                StringTip.create(this._witTxt, LanguageCfgObj.getInstance().getByIndex("11051"));
                StringTip.create(this._agileTxt, LanguageCfgObj.getInstance().getByIndex("11052"));
                StringTip.create(this._powerTxt, LanguageCfgObj.getInstance().getByIndex("11053"));
                StringTip.create(this._strengthTxt, LanguageCfgObj.getInstance().getByIndex("11054"));
            }
            else if (this._info.job == JobType.BOWMAN)
            {
                StringTip.create(this._powerTxt, LanguageCfgObj.getInstance().getByIndex("11053"));
                StringTip.create(this._strengthTxt, LanguageCfgObj.getInstance().getByIndex("11054"));
                StringTip.create(this._witTxt, LanguageCfgObj.getInstance().getByIndex("11051"));
                StringTip.create(this._agileTxt, LanguageCfgObj.getInstance().getByIndex("11058"));
            }
            else if (this._info.job == JobType.MAGICER)
            {
                StringTip.create(this._powerTxt, LanguageCfgObj.getInstance().getByIndex("11053"));
                StringTip.create(this._strengthTxt, LanguageCfgObj.getInstance().getByIndex("11054"));
                StringTip.create(this._witTxt, LanguageCfgObj.getInstance().getByIndex("11061"));
                StringTip.create(this._agileTxt, LanguageCfgObj.getInstance().getByIndex("11052"));
            }
            this._expBarNormal.setValue(this._info.exp.low, LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level));
            this._expBarMaster.setValue(this._info.exp.low, LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level));
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                this._expBarMaster.visible = true;
                this._expBarNormal.visible = false;
            }
            else
            {
                this._expBarMaster.visible = false;
                this._expBarNormal.visible = true;
            }
            this._HPTxt.htmlText = this.info.HP + "/" + this._info.HPMax;
            this._EPTxt.htmlText = this._info.MP + "/" + this._info.MPMax;
            this._left_weapon_mc.info = this._equipsObj.getEquipBy(Params.LEFT_WEAPON);
            this._right_weapon_mc.info = this._equipsObj.getEquipBy(Params.RIGHT_WEAPON);
            this._hand_mc.info = this._equipsObj.getEquipBy(Params.HAND);
            this._head_mc.info = this._equipsObj.getEquipBy(Params.HEAD);
            this._wing_mc.info = this._equipsObj.getEquipBy(Params.WING);
            this._ring_1_mc.info = this._equipsObj.getEquipBy(Params.RING1);
            this._ring_2_mc.info = this._equipsObj.getEquipBy(Params.RING2);
            this._shoe_mc.info = this._equipsObj.getEquipBy(Params.SHOE);
            this._leg_mc.info = this._equipsObj.getEquipBy(Params.LEG);
            this._pet_mc.info = this._equipsObj.getEquipBy(Params.PET);
            this._nicklace_mc.info = this._equipsObj.getEquipBy(Params.NICKLACE);
            this._body_mc.info = this._equipsObj.getEquipBy(Params.BODY);
            this.createAttributeTips();
            this.checkEquip();
            return;
        }// end function

        public function createAttributeTips() : void
        {
            this.createRemarkTips();
            this.createIntensifyTips();
            return;
        }// end function

        public function createIntensifyTips() : void
        {
            var _loc_1:* = new Object();
            _loc_1.type = RemarkModel.INTENSIFY;
            _loc_1.param = RemarkModel.getInstance().self.intenfisy;
            var _loc_2:* = RemarkRoleCfgObj.getInstance().getSatisfyInfo(_loc_1.type, _loc_1.param);
            this._instensify_inactivatePoint.visible = _loc_2 == -1 ? (true) : (false);
            this._intensifyPoint.visible = !this._remark_inactivatePoint.visible;
            if (_loc_2 != -1)
            {
                ItemTips.create(this._intensifyPoint, _loc_1, RemarkRoleTip);
                ItemTips.dispose(this._instensify_inactivatePoint);
            }
            else
            {
                ItemTips.dispose(this._intensifyPoint);
                ItemTips.create(this._instensify_inactivatePoint, _loc_1, RemarkRoleTip);
            }
            return;
        }// end function

        public function createRemarkTips() : void
        {
            var _loc_1:* = new Object();
            _loc_1.type = RemarkModel.REMARK;
            _loc_1.param = RemarkModel.getInstance().self.remark;
            var _loc_2:* = RemarkRoleCfgObj.getInstance().getSatisfyInfo(_loc_1.type, _loc_1.param);
            this._remark_inactivatePoint.visible = _loc_2 == -1 ? (true) : (false);
            this._remarkPoint.visible = !this._remark_inactivatePoint.visible;
            if (_loc_2 != -1)
            {
                ItemTips.create(this._remarkPoint, _loc_1, RemarkRoleTip);
                ItemTips.dispose(this._remark_inactivatePoint);
            }
            else
            {
                ItemTips.create(this._remark_inactivatePoint, _loc_1, RemarkRoleTip);
                ItemTips.dispose(this._remarkPoint);
            }
            return;
        }// end function

        private function guideConfigComplete(event:GuideEvent = null) : void
        {
            GuideConfigObj.getInstance().removeEventListener(GuideEvent.GUIDE_ACTIVE_CONFIG_COMPLETE, this.guideConfigComplete);
            if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)) == 0 && this._plusTalentbtn)
            {
                this._plusTalentbtn.visible = false;
                GuideConfigObj.getInstance().addEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
                this.layoutBtns();
            }
            return;
        }// end function

        public function checkEquip() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._equipArr.length)
            {
                
                (this._equipArr[_loc_1] as RoleEquipBox).check(UserObj.getInstance().playerInfo);
                _loc_1++;
            }
            return;
        }// end function

        private function guideActive(event:GuideEvent) : void
        {
            var _loc_2:* = String(event.data);
            if (_loc_2 == GuideConfigObj.getInstance().ROLE_POINT_ACTIVE_TEAM)
            {
                this._plusTalentbtn.visible = true;
                this.layoutBtns();
                GuideConfigObj.getInstance().removeEventListener(GuideEvent.GUIDE_ACTIVE, this.guideActive);
            }
            return;
        }// end function

        private function layoutBtns() : void
        {
            var _loc_8:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 14;
            var _loc_4:* = [this._titleBtn, this._plusTalentbtn, this._infoBtn];
            var _loc_5:* = _loc_4.length;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_8 = _loc_4[_loc_7];
                if (_loc_8 && _loc_8.visible)
                {
                    _loc_6++;
                    _loc_1 = _loc_1 + _loc_8.width;
                    if (_loc_7 != 0)
                    {
                        _loc_1 = _loc_1 + _loc_3;
                    }
                }
                _loc_7++;
            }
            _loc_2 = (_w - _loc_1) / 2 + _loc_3;
            _loc_7 = 0;
            while (_loc_7 < _loc_5)
            {
                
                _loc_8 = _loc_4[_loc_7];
                if (_loc_8 && _loc_8.visible)
                {
                    _loc_8._x = _loc_2;
                    _loc_2 = _loc_2 + _loc_8.width;
                    _loc_2 = _loc_2 + _loc_3;
                }
                _loc_7++;
            }
            return;
        }// end function

    }
}
