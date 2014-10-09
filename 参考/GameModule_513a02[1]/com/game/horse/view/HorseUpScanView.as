package com.game.horse.view
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.operationpanel.view.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class HorseUpScanView extends BaseBox
    {
        private var horsePhoto:VMCView;
        private var horseWingPhoto:VMCView;
        private var horseName:Image;
        private var fruit:ImgNumber;
        private var btnClose:BaseButton;
        private var btnClose1:BaseButton;
        private var _info:HorseTableVo;
        private var skillBoxList:HBox;
        private var vecSkillBox:Vector.<SkillBox>;
        private var dic:Dictionary;
        private var mcUpFight:Sprite;

        public function HorseUpScanView()
        {
            this.vecSkillBox = new Vector.<SkillBox>(3, true);
            this.dic = new Dictionary();
            loadDisplay("res/horseUpScanView.swf");
            return;
        }// end function

        private function getTextField(param1:String) : TextField
        {
            var _loc_2:* = null;
            if (!this.dic[param1])
            {
                _loc_2 = getDisplayChildByName(param1);
                _loc_2.mouseEnabled = false;
                this.dic[param1] = _loc_2;
            }
            return this.dic[param1];
        }// end function

        private function getUpSign(param1:String) : MovieClip
        {
            var _loc_2:* = null;
            if (!this.dic[param1])
            {
                _loc_2 = getDisplayChildByName(param1);
                _loc_2.mouseEnabled = false;
                this.dic[param1] = _loc_2;
            }
            return this.dic[param1];
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("horseUpScanView");
            super.displayReady();
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.btnClose1 = new BaseButton(getDisplayChildByName("btnClose1"));
            this.mcUpFight = Sprite(getDisplayChildByName("mc_up_fight"));
            this.btnClose1.setText(LanguageCfgObj.getInstance().getByIndex("10869"), true);
            this.btnClose.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.btnClose1.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
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
            this.horsePhoto = new VMCView();
            this.horsePhoto.move(419, 244);
            this.addChild(this.horsePhoto);
            this.addChild(this.mcUpFight);
            this.fruit = new ImgNumber();
            this.fruit.move(349, 70);
            this.addChild(this.fruit);
            this.horseName = new Image();
            this.horseName.move(340, 327);
            this.addChild(this.horseName);
            this.addEvents();
            return;
        }// end function

        private function addEvents() : void
        {
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        public function set horseInfo(param1:HorseTableVo) : void
        {
            this._info = param1;
            this.freshMe();
            return;
        }// end function

        private function freshMe() : void
        {
            var _loc_5:* = 0;
            if (!UserObj.getInstance().playerInfo.horseInfo)
            {
                return;
            }
            var _loc_1:* = UserObj.getInstance().playerInfo.horseInfo.horse_level;
            var _loc_2:* = HorseCfgObj.getInstance().getNestGradeInfoFromLevel(_loc_1);
            this.setSkillList(_loc_2);
            this.getTextField(HorseUnit.SCAN_MAX_DEFENSE_VALUE).htmlText = _loc_2.horse_defense.toString();
            this.getTextField(HorseUnit.SCAN_MAX_LIFT_VALUE).htmlText = _loc_2.horse_hp.toString();
            this.getTextField(HorseUnit.SCAN_MAX_POW_ATTACT_VALUE).htmlText = _loc_2.horse_min_magicatk + " - " + _loc_2.horse_max_magicatk;
            this.getTextField(HorseUnit.SCAN_MAX_POW_VALUE).htmlText = _loc_2.horse_mp.toString();
            this.getTextField(HorseUnit.SCAN_MAX_SPEED_VALUE).htmlText = _loc_2.horse_speed.toString();
            this.getTextField(HorseUnit.SCAN_MAX_TXT_ATTACT_VALUE).htmlText = _loc_2.horse_min_phyatk + " - " + _loc_2.horse_max_phyatk;
            this.getTextField(HorseUnit.SCAN_MAX_UNDEFENSE_VALUE).htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12088"), [_loc_2.horse_ignoredefense / 100]);
            this.getTextField(HorseUnit.SCAN_MAX_ADDED_HARM_VALUE).htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12089"), [_loc_2.horse_perfectatk_percent / 100]);
            this.horsePhoto.loadRes(Params.HORSE_PATH + _loc_2.horse_id + "/act01/135.png");
            this.horsePhoto.updatePose("135", true);
            this.horsePhoto.direct = -135;
            this.horsePhoto.auto = true;
            this.horseName.load(Params.ZONES_LEVEL_PATH + _loc_2.horse_id + ".png");
            if (_loc_2.q_horse_wing == 1)
            {
                this.horseWingPhoto = new VMCView();
                this.horseWingPhoto.loadRes(Params.HORSE_PATH + _loc_2.horse_id + "01/act01.png");
                this.horseWingPhoto.move(419, 244);
                this.addChild(this.horseWingPhoto);
                _loc_5 = this.getChildIndex(this.horsePhoto);
                this.setChildIndex(this.horseWingPhoto, (_loc_5 + 1));
                this.horseWingPhoto.direct = -135;
                this.horseWingPhoto.auto = true;
                this.horsePhoto.appendView(this.horseWingPhoto);
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
            var _loc_3:* = HorseCfgObj.getInstance().getInfoFromLevel(_loc_1);
            this.setUpSign(_loc_3, _loc_2);
            var _loc_4:* = HorseCfgObj.getInstance().getCombatValue(_loc_2);
            this.fruit.setNumber(_loc_4.toString(), 1, 0, true);
            return;
        }// end function

        private function setUpSign(param1:HorseTableVo, param2:HorseTableVo) : void
        {
            var _loc_3:* = null;
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_ADDED_HARM_VALUE);
            _loc_3.visible = param2.horse_perfectatk_percent > param1.horse_perfectatk_percent ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_DEFENSE_VALUE);
            _loc_3.visible = param2.horse_defense > param1.horse_defense ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_LIFT_VALUE);
            _loc_3.visible = param2.horse_hp > param1.horse_hp ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_POW_ATTACT_VALUE);
            _loc_3.visible = param2.horse_max_magicatk > param1.horse_max_magicatk ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_POW_VALUE);
            _loc_3.visible = param2.horse_mp > param1.horse_mp ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_SPEED_VALUE);
            _loc_3.visible = param2.horse_speed > param1.horse_speed ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_TXT_ATTACT_VALUE);
            _loc_3.visible = param2.horse_max_phyatk > param1.horse_max_phyatk ? (true) : (false);
            _loc_3 = this.getUpSign(HorseUnit.SCAN_UP_UNDEFENSE_VALUE);
            _loc_3.visible = param2.horse_ignoredefense > param1.horse_ignoredefense ? (true) : (false);
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
            layoutMC(this.skillBoxList, Layout.BOTTOM_CENTER, 197, 60);
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.horseInfo = UserObj.getInstance().playerInfo.horseInfo;
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.horsePhoto.finalize();
            if (this.horseWingPhoto)
            {
                this.horseWingPhoto.finalize();
                this.horseWingPhoto = null;
            }
            return;
        }// end function

    }
}
