package com.game.grandMasterPanel.view
{
    import avmplus.*;
    import com.*;
    import com.cfg.*;
    import com.events.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.scroller.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.backpack.control.*;
    import com.game.backpack.model.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.role.util.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class GrandMasterPanel extends BaseBox
    {
        private var _closeBtn:BaseButton;
        private var masterIcon:MovieClip;
        private var _masterEffect:VMCView;
        private var lvTf:TextField;
        private var masterSkillPointTf:TextField;
        private var attackTreePointTf:TextField;
        private var defenseTreePointTf:TextField;
        private var treatTreePointTf:TextField;
        private var resetBtn:BaseButton;
        private var sysMc1:MovieClip;
        private var sysMc2:MovieClip;
        private var sysMc3:MovieClip;
        private var _scrollTarget:Sprite;
        private var _scrollPanel:ScrollPanel;
        private var _skillBoxDict:Dictionary;

        public function GrandMasterPanel()
        {
            this._skillBoxDict = new Dictionary();
            loadDisplay("res/grandMasterSkillPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            initBaseBoxUI("grandMasterSkillPanel");
            this._closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.onCloseHandler);
            this.masterIcon = getDisplayChildByName("masterIcon");
            this._masterEffect = new VMCView();
            this._masterEffect.loadRes("res/effect/masterSkill/masterIcon.png", null, true);
            this._masterEffect.move(this.masterIcon.width * 0.5, this.masterIcon.height * 0.5);
            this._masterEffect.updatePose("90", true);
            this._masterEffect.auto = true;
            this.masterIcon.addChild(this._masterEffect);
            this.lvTf = getDisplayChildByName("lvTf");
            this.updateLevelHandler(null);
            this.masterSkillPointTf = getDisplayChildByName("masterSkillPointTf");
            this.attackTreePointTf = getDisplayChildByName("attackTreePointTf");
            this.defenseTreePointTf = getDisplayChildByName("defenseTreePointTf");
            this.treatTreePointTf = getDisplayChildByName("treatTreePointTf");
            this.resetBtn = new BaseButton(getDisplayChildByName("resetBtn"));
            this.resetBtn.addEvtListener(MouseEvent.CLICK, this.onResetHandler);
            this._scrollTarget = new Sprite();
            addChild(this._scrollTarget);
            this.sysMc1 = getDisplayChildByName("sysMc1");
            this.sysMc1.x = this.sysMc1.x - 40;
            this.sysMc1.y = 48;
            this._scrollTarget.addChild(this.sysMc1);
            this.sysMc2 = getDisplayChildByName("sysMc2");
            this.sysMc2.x = this.sysMc2.x - 40;
            this.sysMc2.y = 48;
            this._scrollTarget.addChild(this.sysMc2);
            this.sysMc3 = getDisplayChildByName("sysMc3");
            this.sysMc3.x = this.sysMc3.x - 40;
            this.sysMc3.y = 48;
            this._scrollTarget.addChild(this.sysMc3);
            var _loc_1:* = [];
            _loc_1[MasterSkillConst.ATK_SYSTEM] = this.sysMc1;
            _loc_1[MasterSkillConst.DEF_SYSTEM] = this.sysMc2;
            _loc_1[MasterSkillConst.MED_SYSTEM] = this.sysMc3;
            var _loc_2:* = MasterSkillData.instance.skillPool;
            var _loc_3:* = 70;
            _loc_4 = 83;
            for each (_loc_5 in _loc_2)
            {
                
                _loc_6 = _loc_1[_loc_5.cfg.q_type];
                if (_loc_6)
                {
                    _loc_7 = (_loc_5.cfg.q_x - 1) * _loc_3;
                    _loc_8 = (_loc_5.cfg.q_y - 1) * _loc_4;
                    _loc_9 = new MasterSkillBox();
                    _loc_9.move(_loc_7, _loc_8);
                    _loc_9.name = _loc_5.skillId + "";
                    _loc_9.data = _loc_5;
                    _loc_6.addChild(_loc_9);
                    this._skillBoxDict[_loc_5.skillId] = _loc_9;
                }
            }
            this.updateDetails();
            MasterSkillData.instance.addEvtListener(Event.CHANGE, this.updateBoxListHandler);
            for each (_loc_9 in this._skillBoxDict)
            {
                
                _loc_11 = _loc_9.data.cfg.q_depense.length;
                _loc_12 = 0;
                while (_loc_12 < _loc_11)
                {
                    
                    _loc_13 = _loc_9.data.cfg.q_depense[_loc_12][0];
                    _loc_10 = _loc_16[_loc_13];
                    if (_loc_10 && _loc_10.data.cfg.q_x == _loc_9.data.cfg.q_x)
                    {
                        _loc_7 = _loc_10.x + _loc_10.width * 0.5;
                        _loc_8 = _loc_10.y + _loc_10.height;
                        _loc_14 = ToolKit.getNew("grandMasterSkillPanel.crossDown");
                        _loc_14.mouseChildren = false;
                        _loc_14.mouseEnabled = false;
                        _loc_14.tabChildren = false;
                        _loc_7 = _loc_7 - _loc_14.width * 0.5;
                        _loc_4 = _loc_9.y - _loc_8;
                        _loc_14.x = _loc_7;
                        _loc_14.y = _loc_8;
                        _loc_14.height = _loc_4;
                        _loc_9.parent.addChild(_loc_14);
                    }
                    _loc_12++;
                }
            }
            this._scrollPanel = new ScrollPanel(884, 355, "scrollBar3");
            this._scrollPanel.move(40, 117);
            this._scrollPanel.offsetY = 43;
            this._scrollPanel.content = this._scrollTarget;
            this._scrollPanel.updateThumb();
            addChild(this._scrollPanel);
            super.displayReady();
            return;
        }// end function

        private function onCloseHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            MasterSkillData.instance.removeEvtListener(Event.CHANGE, this.updateBoxListHandler);
            UserObj.getInstance().playerInfo.removeEvtListener(RoleEvent.UPDATE_LEVEL, this.updateLevelHandler);
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.updateBoxListHandler();
                MasterSkillData.instance.addEvtListener(Event.CHANGE, this.updateBoxListHandler);
                this._scrollPanel.scrollTo(0);
            }
            this.updateLevelHandler(null);
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.updateLevelHandler);
            return;
        }// end function

        private function updateLevelHandler(event:RoleEvent) : void
        {
            if (UILoaded)
            {
                this.lvTf.text = StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("GrandMasterPanel_1408518825", "lang_masterSkill"), RoleLevelUtil.getMasterLv(UserObj.getInstance().playerInfo.level));
            }
            return;
        }// end function

        private function updateBoxListHandler(event:Event = null) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = MasterSkillData.instance.skillPool;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = this._skillBoxDict[_loc_3.skillId];
                _loc_4.data = _loc_3;
            }
            this.updateDetails();
            return;
        }// end function

        private function updateDetails() : void
        {
            this.masterSkillPointTf.text = "" + MasterSkillData.instance.masterSkillPoint;
            this.attackTreePointTf.text = StringUtil.formatString("（{0}）", MasterSkillData.instance.attackTreePoint);
            this.defenseTreePointTf.text = StringUtil.formatString("（{0}）", MasterSkillData.instance.defenseTreePoint);
            this.treatTreePointTf.text = StringUtil.formatString("（{0}）", MasterSkillData.instance.treatTreePoint);
            return;
        }// end function

        private function onResetHandler(event:MouseEvent) : void
        {
            BackPackControl.getInstance().checkItemenough(MasterSkillConst.RESET_ITEM_ID, 1, this.resetConfirm);
            return;
        }// end function

        private function resetConfirm() : void
        {
            var _loc_1:* = BackpackObj.getInstance().getItemByItemModelId(MasterSkillConst.RESET_ITEM_ID);
            Global.popManager.cue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("GrandMasterPanel_1405999509", "lang_masterSkill"), _loc_1.q_name), null, null, this.resetHandler);
            return;
        }// end function

        private function resetHandler() : void
        {
            MasterSkillControl.instance.protocol.resetAllSkill();
            return;
        }// end function

    }
}
