package com.game.zones.view.dekaron
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.operationpanel.view.*;
    import com.game.zones.message.*;
    import com.game.zones.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesDekaronDetailPanel extends BaseBox
    {
        private var _txtmonsterName:TextField;
        private var _txtGiftMoney:TextField;
        private var _txtGiftExp:TextField;
        private var _txtGiftSpirit:TextField;
        private var _btnClose:BaseButton;
        private var _photo:VMCView;
        private var _fruitAdvicePower:ImgNumber;
        private var _hBox:HBox;
        private var _txtMonsterlevel:TextField;
        private var _txtMonsterHP:TextField;
        private var _txtMonsterMP:TextField;
        private var _txtMonsterAttack:TextField;
        private var _txtMonsterDefense:TextField;
        private var _txtMonsterDodge:TextField;
        private var _txtMonsterSpeed:TextField;
        private var _txtMonsterHit:TextField;

        public function ZonesDekaronDetailPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super("cue_zones_pop_box");
            this.initpanel();
            this.addEvents();
            return;
        }// end function

        private function initpanel() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._txtGiftExp = TextField(getDisplayChildByName("txt_gift_exp"));
            this._txtGiftMoney = TextField(getDisplayChildByName("txt_gift_money"));
            this._txtGiftSpirit = TextField(getDisplayChildByName("txt_gift_spirit"));
            this._txtmonsterName = TextField(getDisplayChildByName("txt_monster_name"));
            this._txtMonsterlevel = TextField(getDisplayChildByName("txt_monster_level"));
            this._txtMonsterHP = TextField(getDisplayChildByName("txt_monster_hp"));
            this._txtMonsterMP = TextField(getDisplayChildByName("txt_monster_mp"));
            this._txtMonsterAttack = TextField(getDisplayChildByName("txt_monster_attack"));
            this._txtMonsterDefense = TextField(getDisplayChildByName("txt_monster_defense"));
            this._txtMonsterDodge = TextField(getDisplayChildByName("txt_monster_dodge"));
            this._txtMonsterHit = TextField(getDisplayChildByName("txt_monster_hit"));
            this._txtMonsterSpeed = TextField(getDisplayChildByName("txt_monster_speed"));
            this._fruitAdvicePower = new ImgNumber();
            this._fruitAdvicePower.move(30, 318);
            this.addChild(this._fruitAdvicePower);
            this._hBox = new HBox();
            this._hBox.horizontal = true;
            this._hBox.intervalX = 8;
            this._hBox.oneRow = 5;
            this._hBox.move(303, 377);
            this.addChild(this._hBox);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStageHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function addedToStageHandler(event:Event) : void
        {
            this.freshPanel();
            return;
        }// end function

        protected function removeFromStageHandler(event:Event) : void
        {
            this.cleanPanel();
            return;
        }// end function

        public function freshPanel() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = ZonesModel.getInstance().dekaronInfo;
            if (_loc_1)
            {
                _loc_2 = _loc_1.zoneId;
                _loc_3 = ZonesCloneCfg.getInstance().getZonesInfoFromId(_loc_2);
                if (_loc_3)
                {
                    _loc_4 = MonsterCfgObj.getInstance().getMonsterCfg(_loc_3.monster);
                    if (_loc_4)
                    {
                        this.freshMonsterInfo(_loc_4);
                    }
                    this.freshTableInfo(_loc_3);
                }
            }
            return;
        }// end function

        private function freshTableInfo(param1:ZonesTableVo) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            this._fruitAdvicePower.setNumber(param1.fighting_value.toString(), 1, 0, true);
            var _loc_2:* = param1.reward.split(";");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_6 = _loc_2[_loc_3];
                _loc_7 = _loc_6.split("_");
                if (_loc_7[0] == -1)
                {
                    this._txtGiftMoney.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                }
                if (_loc_7[0] == -4)
                {
                    this._txtGiftExp.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                }
                if (_loc_7[0] == -6)
                {
                    this._txtGiftSpirit.text = ToolKit.getMoneyString(uint(_loc_7[1]));
                }
                _loc_3++;
            }
            var _loc_4:* = param1.monster_skill;
            var _loc_5:* = 0;
            if (_loc_4.length > 0)
            {
                _loc_8 = _loc_4.split(";");
                _loc_5 = _loc_8.length;
            }
            this._hBox.reset();
            _loc_3 = 0;
            while (_loc_3 < 3)
            {
                
                _loc_9 = new SkillBox("zones_dekaron_skill_bg");
                _loc_9.isNum = false;
                _loc_9.canDrag = false;
                _loc_9.setImageSize(39, 39);
                _loc_9.setSize(48, 48);
                if (_loc_3 < _loc_5)
                {
                    _loc_10 = SkillCfgObj.getInstance().getSkillInfoById(_loc_8[_loc_3]);
                    _loc_9.info = _loc_10;
                }
                this._hBox.add(_loc_9);
                _loc_3++;
            }
            return;
        }// end function

        private function freshMonsterInfo(param1:Monster) : void
        {
            this._txtmonsterName.text = param1.q_name;
            this._txtMonsterlevel.text = param1.q_grade.toString();
            this._txtMonsterHP.text = param1.q_maxhp.toString();
            this._txtMonsterMP.text = param1.q_maxmp.toString();
            this._txtMonsterAttack.text = param1.q_attack.toString();
            this._txtMonsterDefense.text = param1.q_defense.toString();
            this._txtMonsterDodge.text = param1.q_dodge.toString();
            this._txtMonsterSpeed.text = param1.q_speed.toString();
            this._txtMonsterHit.text = param1.q_hit.toString();
            this._photo = new VMCView();
            this._photo.move(155, 265);
            this.addChild(this._photo);
            this._photo.loadRes(Params.ROLE_RES_PATH + param1.q_sculpt_resid + "/act01.png");
            this._photo.updatePose("135", true);
            this._photo.auto = true;
            return;
        }// end function

        private function cleanPanel() : void
        {
            if (this._photo)
            {
                this._photo.stop();
                this._photo.finalize();
                this._photo = null;
            }
            return;
        }// end function

    }
}
