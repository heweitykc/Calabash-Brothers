package com.game.primaryrole.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.guild.model.*;
    import com.game.player.view.*;
    import com.game.primaryrole.control.*;
    import com.game.primaryrole.model.*;
    import com.game.remark.tips.*;
    import com.game.role.util.*;
    import com.game.team.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OtherRoleMainView extends Component
    {
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var _remarkPoint:MovieClip;
        private var _expBar:Stripe;
        private var _expBarMaster:Stripe;
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

        public function OtherRoleMainView(param1 = null, param2:String = null)
        {
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
            return;
        }// end function

        private function initUI() : void
        {
            this._expBar = new Stripe(getDisplayChildByName("expBar"));
            this._expBarMaster = new Stripe(getDisplayChildByName("expBarMaster"));
            this._infoBtn = new BaseButton(getDisplayChildByName("btn_roleInfo"));
            this._plusTalentbtn = new BaseButton(getDisplayChildByName("btn_plusTalent"));
            this._plusTalentbtn.visible = false;
            this._infoBtn.visible = false;
            this._head_mc = new RoleEquipBox(getDisplayChildByName("pos_head"), null, false);
            this._head_mc.pos = Params.HEAD;
            this._hand_mc = new RoleEquipBox(getDisplayChildByName("pos_hand"), null, false);
            this._hand_mc.pos = Params.HAND;
            this._wing_mc = new RoleEquipBox(getDisplayChildByName("pos_wing"), null, false);
            this._wing_mc.pos = Params.WING;
            this._pet_mc = new RoleEquipBox(getDisplayChildByName("pos_pet"), null, false);
            this._pet_mc.pos = Params.PET;
            this._nicklace_mc = new RoleEquipBox(getDisplayChildByName("pos_nicklace"), null, false);
            this._nicklace_mc.pos = Params.NICKLACE;
            this._body_mc = new RoleEquipBox(getDisplayChildByName("pos_body"), null, false);
            this._body_mc.pos = Params.BODY;
            this._ring_1_mc = new RoleEquipBox(getDisplayChildByName("pos_ring_1"), null, false);
            this._ring_1_mc.pos = Params.RING1;
            this._ring_2_mc = new RoleEquipBox(getDisplayChildByName("pos_ring_2"), null, false);
            this._ring_2_mc.pos = Params.RING2;
            this._left_weapon_mc = new RoleEquipBox(getDisplayChildByName("mc_leftweapon"), null, false);
            this._left_weapon_mc.pos = Params.LEFT_WEAPON;
            this._right_weapon_mc = new RoleEquipBox(getDisplayChildByName("mc_rightweapon"), null, false);
            this._right_weapon_mc.pos = Params.RIGHT_WEAPON;
            this._shoe_mc = new RoleEquipBox(getDisplayChildByName("pos_shoe"), null, false);
            this._shoe_mc.pos = Params.SHOE;
            this._leg_mc = new RoleEquipBox(getDisplayChildByName("pos_leg"), null, false);
            this._leg_mc.pos = Params.LEG;
            this._remarkPoint = getDisplayChildByName("remark_point") as MovieClip;
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
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("11038"), true);
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("11039"), true);
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("11040"), true);
            this.btn1.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn3.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn4.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btn1:
                {
                    if (this._info.name)
                    {
                        ChatController.getInstance().toRole(this._info.name);
                    }
                    break;
                }
                case this.btn2:
                {
                    break;
                }
                case this.btn3:
                {
                    TeamControl.getInstance().teamInvitePlayer(OtherRoleControl.getInstance().playerInfo.personId);
                    break;
                }
                case this.btn4:
                {
                    if (this._info.personId && UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildInviteAdd(UserObj.getInstance().playerInfo.guildId, this._info.personId);
                    }
                    else if (this._info.guildId)
                    {
                        GuildControl.getInstance().reqGuildApplyAdd(this._info.guildId);
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

        public function createRemarkTips() : void
        {
            var _loc_1:* = new Object();
            _loc_1.type = 1;
            _loc_1.param = OtherEquipsData.getInstance().attributeCount;
            ItemTips.create(this._remarkPoint, _loc_1, RemarkRoleTip);
            return;
        }// end function

        public function updateUI() : void
        {
            if (!this._info.exp)
            {
                return;
            }
            this._witTxt.htmlText = this._info.attackspeed.toString();
            this._agileTxt.htmlText = this._info.magic_attacklower + "-" + this._info.magic_attackupper;
            this._strengthTxt.htmlText = this._info.defense.toString();
            this._powerTxt.htmlText = this._info.physic_attacklower + "-" + this._info.physic_attackupper;
            this._allianceLabel.visible = true;
            this._allianceTxt.text = ToolKit.trimDistrict(GuildData.getInstance().getGuildNameById(this._info.guildId));
            this._professionTxt.text = JobType.getJobName(this.info.job);
            this._expBar.setValue(this._info.exp.low, LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level));
            this._expBarMaster.setValue(this._info.exp.low, LevelExpCfgObj.getInstance().getExpByLevel(this._info.job, this._info.level));
            if (RoleLevelUtil.isMasterLevel(this._info.level))
            {
                this._expBar.visible = false;
                this._expBarMaster.visible = true;
            }
            else
            {
                this._expBar.visible = true;
                this._expBarMaster.visible = false;
            }
            this._HPTxt.htmlText = this.info.HP + "/" + this._info.HPMax;
            this._EPTxt.htmlText = this._info.MP + "/" + this._info.MPMax;
            this._left_weapon_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.LEFT_WEAPON);
            this._right_weapon_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.RIGHT_WEAPON);
            this._hand_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.HAND);
            this._head_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.HEAD);
            this._wing_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.WING);
            this._ring_1_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.RING1);
            this._ring_2_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.RING2);
            this._shoe_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.SHOE);
            this._leg_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.LEG);
            this._pet_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.PET);
            this._nicklace_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.NICKLACE);
            this._body_mc.info = OtherEquipsData.getInstance().getEquipBy(Params.BODY);
            return;
        }// end function

    }
}
