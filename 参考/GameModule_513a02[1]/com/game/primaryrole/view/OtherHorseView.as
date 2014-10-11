package com.game.primaryrole.view
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.vmc.*;
    import com.game.chat.control.*;
    import com.game.guild.control.*;
    import com.game.horse.view.*;
    import com.game.operationpanel.view.*;
    import com.game.primaryrole.control.*;
    import com.game.team.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class OtherHorseView extends Component
    {
        private var horsePhoto:VMCView;
        private var horseWingPhoto:VMCView;
        private var horseName:Image;
        private var btnLeftRot:BaseButton;
        private var btnRightRot:BaseButton;
        private var fruit:ImgNumber;
        private var skillBoxList:HBox;
        private var vecSkillBox:Vector.<SkillBox>;
        private var horseDir:int = -3;
        private var horseLevel:int;
        private var horseComb:int = 0;
        private var dic:Dictionary;
        private var _horseInfo:HorseTableVo;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;

        public function OtherHorseView()
        {
            this.vecSkillBox = new Vector.<SkillBox>(3, true);
            this.dic = new Dictionary();
            loadDisplay("res/horsepanelother.swf");
            return;
        }// end function

        private function getTextField(param1:String) : TextField
        {
            var _loc_2:* = null;
            if (!this.dic[param1])
            {
                _loc_2 = getDisplayChildByName(param1);
                _loc_2.selectable = false;
                this.dic[param1] = _loc_2;
            }
            return this.dic[param1];
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("horsePanel2");
            super.displayReady();
            this.initUI();
            this.addEvent();
            OtherRoleControl.getInstance().reqOtherPlayerHorse();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnLeftRot = new BaseButton(getDisplayChildByName("btnLeftRot"));
            this.btnRightRot = new BaseButton(getDisplayChildByName("btnRightRot"));
            this.fruit = new ImgNumber();
            this.fruit.move(110, 68);
            this.addChild(this.fruit);
            this.skillBoxList = new HBox();
            this.skillBoxList.horizontal = true;
            this.addChild(this.skillBoxList);
            var _loc_1:* = 0;
            while (_loc_1 < this.vecSkillBox.length)
            {
                
                this.vecSkillBox[_loc_1] = new SkillBox("horseSkillBoxBack");
                this.vecSkillBox[_loc_1].setImageSize(40, 40);
                _loc_1++;
            }
            this.horseName = new Image();
            this.horseName.move(115, 302);
            this.addChild(this.horseName);
            this.horsePhoto = new VMCView();
            this.horsePhoto.move(210, 220);
            this.addChild(this.horsePhoto);
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("11035"), true);
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("11036"), true);
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("11037"), true);
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
                    ChatController.getInstance().toRole(OtherRoleControl.getInstance().playerInfo.name);
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
                    if (OtherRoleControl.getInstance().playerInfo.personId && UserObj.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildInviteAdd(UserObj.getInstance().playerInfo.guildId, OtherRoleControl.getInstance().playerInfo.personId);
                    }
                    else if (OtherRoleControl.getInstance().playerInfo.guildId)
                    {
                        GuildControl.getInstance().reqGuildApplyAdd(OtherRoleControl.getInstance().playerInfo.guildId);
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

        private function addEvent() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnLeftRot:
                {
                    this.setNestDirect(1);
                    break;
                }
                case this.btnRightRot:
                {
                    this.setNestDirect(-1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setNestDirect(param1:int = 0) : void
        {
            if (!this.horsePhoto)
            {
                return;
            }
            switch(param1)
            {
                case -1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.horseDir - 1;
                    _loc_2.horseDir = _loc_3;
                    this.horseDir = this.horseDir < -3 ? (4) : (this.horseDir);
                    break;
                }
                case 0:
                {
                    break;
                }
                case 1:
                {
                    var _loc_2:* = this;
                    var _loc_3:* = this.horseDir + 1;
                    _loc_2.horseDir = _loc_3;
                    this.horseDir = this.horseDir > 4 ? (-3) : (this.horseDir);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.loadHorseRes(this.horseDir);
            this.loadHorseWingRes();
            return;
        }// end function

        public function updateHorseInfo(param1:int) : void
        {
            if (!UILoaded)
            {
                return;
            }
            var _loc_2:* = HorseCfgObj.getInstance().getInfoFromLevel(param1);
            this._horseInfo = _loc_2;
            this.setDetailInfo(_loc_2);
            this.setSkillList(_loc_2);
            this.horseLevel = param1;
            this.horseName.load(Params.ZONES_LEVEL_PATH + _loc_2.horse_id + ".png");
            if (_loc_2.q_horse_wing == 1)
            {
                if (!this.horseWingPhoto)
                {
                    this.horseWingPhoto = new VMCView();
                    this.horseWingPhoto.auto = true;
                    this.horseWingPhoto.repeat = true;
                    this.horseWingPhoto.move(210, 220);
                    this.addChild(this.horseWingPhoto);
                    this.horsePhoto.appendView(this.horseWingPhoto);
                }
            }
            else if (this.horseWingPhoto)
            {
                this.horsePhoto.removeAppend(this.horseWingPhoto);
                if (this.horseWingPhoto.parent)
                {
                    this.horseWingPhoto.parent.removeChild(this.horseWingPhoto);
                }
                if (this.horseWingPhoto.playing)
                {
                    this.horseWingPhoto.stop();
                }
                this.horseWingPhoto.finalize();
                this.horseWingPhoto = null;
            }
            this.setNestDirect();
            return;
        }// end function

        public function loadHorseRes(param1:int = 90) : void
        {
            var url:String;
            var direct:* = param1;
            if (this._horseInfo)
            {
                if (this.horsePhoto)
                {
                    url = Params.HORSE_PATH + this._horseInfo.horse_id + "/act01/" + Math.abs(direct * 45) + ".png";
                    this.horsePhoto.direct = direct * 45;
                    this.horsePhoto.auto = true;
                    this.horsePhoto.loadRes(url, null, false, function () : void
            {
                horsePhoto.updatePose(Math.abs(direct * 45).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        public function loadHorseWingRes() : void
        {
            var direct:int;
            var url:String;
            direct = this.horsePhoto.direct;
            if (this._horseInfo)
            {
                if (this.horseWingPhoto)
                {
                    url = Params.HORSE_PATH + this._horseInfo.horse_id + "01/act01/" + Math.abs(direct) + ".png";
                    this.horseWingPhoto.direct = direct;
                    this.horseWingPhoto.loadRes(url, null, false, function () : void
            {
                horseWingPhoto.updatePose(Math.abs(direct).toString(), true);
                horsePhoto.updatePose(Math.abs(direct).toString(), true);
                return;
            }// end function
            );
                }
            }
            return;
        }// end function

        private function setSkillOneInfo(param1:SkillBox, param2:int) : void
        {
            var _loc_3:* = null;
            if (param2)
            {
                _loc_3 = SkillCfgObj.getInstance().getSkillInfoById(param2);
                param1.info = _loc_3;
                this.skillBoxList.add(param1);
            }
            else
            {
                if (this.skillBoxList.contains(param1))
                {
                    this.skillBoxList.remove(param1);
                }
                param1.clean();
            }
            return;
        }// end function

        private function setSkillList(param1:HorseTableVo) : void
        {
            this.setSkillOneInfo(this.vecSkillBox[0], param1.horse_skill_id1);
            this.setSkillOneInfo(this.vecSkillBox[1], param1.horse_skill_id2);
            this.setSkillOneInfo(this.vecSkillBox[2], param1.horse_skill_id3);
            layoutMC(this.skillBoxList, Layout.BOTTOM_CENTER, 15, -5);
            return;
        }// end function

        private function setDetailInfo(param1:HorseTableVo) : void
        {
            var _loc_2:* = 0;
            if (param1)
            {
                _loc_2 = HorseCfgObj.getInstance().getCombatValue(param1);
                this.horseComb = _loc_2;
                this.fruit.setNumber(_loc_2.toString(), 1, 0, true);
                this.getTextField(HorseUnit.MAIN_TXT_ADDED_HARM_VALUE).htmlText = param1.horse_perfectatk_percent / 100 + "%";
                this.getTextField(HorseUnit.MAIN_TXT_ADDED_SPEED_VALUE).htmlText = param1.horse_speed.toString();
                this.getTextField(HorseUnit.MAIN_TXT_BASE_ATTACK_VALUE).htmlText = param1.horse_min_phyatk + " - " + param1.horse_max_phyatk;
                this.getTextField(HorseUnit.MAIN_TXT_DEFENSE_VALUE).htmlText = param1.horse_defense.toString();
                this.getTextField(HorseUnit.MAIN_TXT_LIFT_VALUE).htmlText = param1.horse_hp.toString();
                this.getTextField(HorseUnit.MAIN_TXT_POW_ATTACK_VALUE).htmlText = param1.horse_min_magicatk + " - " + param1.horse_max_magicatk;
                this.getTextField(HorseUnit.MAIN_TXT_POW_VALUE).htmlText = param1.horse_mp.toString();
                this.getTextField(HorseUnit.MAIN_TXT_UNDEFENSE_VALUE).htmlText = param1.horse_ignoredefense / 100 + "%";
            }
            return;
        }// end function

    }
}
