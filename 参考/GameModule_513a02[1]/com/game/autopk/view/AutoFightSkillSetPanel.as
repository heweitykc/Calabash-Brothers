package com.game.autopk.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.ui.list.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.mediator.*;
    import com.game.autopk.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class AutoFightSkillSetPanel extends BaseBox
    {
        private var mediator:AutoFightSkillSetMediator;
        private var btn_close:BaseButton;
        public var btn_submit:BaseButton;
        public var btn_cancel:BaseButton;
        public var listMC:List;
        public var mc_list:MovieClip;
        public var skillBoxList:Vector.<SkillBoxItemMediator>;

        public function AutoFightSkillSetPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            initBaseBoxUI("AutoFightSkillSet");
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_close.addEvtListener(MouseEvent.CLICK, this.onClosePanel);
            this.btn_submit = new BaseButton(getDisplayChildByName("btn_submit"));
            this.btn_submit.setText(LanguageCfgObj.getInstance().getByIndex("10327"));
            this.btn_cancel = new BaseButton(getDisplayChildByName("btn_cancel"));
            this.btn_cancel.setText(LanguageCfgObj.getInstance().getByIndex("10328"));
            this.mc_list = getDisplayChildByName("mc_list");
            this.mc_list.visible = false;
            this.mc_list.addEventListener(MouseEvent.ROLL_OUT, this.onListBoxOutHandle);
            this.listMC = new List(this.mc_list.width - 4, this.mc_list.height - 4);
            this.listMC.x = 2;
            this.listMC.y = 2;
            this.mc_list.addChild(this.listMC);
            this.skillBoxList = new Vector.<SkillBoxItemMediator>;
            var _loc_1:* = 0;
            while (_loc_1 < 8)
            {
                
                _loc_2 = getDisplayChildByName("mc" + (_loc_1 + 1));
                this.skillBoxList[_loc_1] = new SkillBoxItemMediator(_loc_2, (_loc_1 + 1));
                _loc_1++;
            }
            addEventListener(BoxEvent.SHOW_HIDE, this.onPanelShowOrHid);
            this.mediator = new AutoFightSkillSetMediator(this);
            this.setTableData();
            return;
        }// end function

        private function onListBoxOutHandle(event:MouseEvent) : void
        {
            this.mc_list.visible = false;
            return;
        }// end function

        private function onPanelShowOrHid(event:BoxEvent) : void
        {
            if (event.showOrHide == BaseBox.HIDE)
            {
                this.mc_list.visible = false;
            }
            return;
        }// end function

        private function onClosePanel(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openOrCloseSkillSetPanel();
            return;
        }// end function

        public function getTableData() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.mediator.autoSkill;
            AutoFightModel.skillIdList = new Vector.<int>;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_2];
                AutoFightModel.skillIdList.push(_loc_3.q_skillID);
                _loc_2++;
            }
            return;
        }// end function

        public function setTableData() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            this.clear();
            var _loc_1:* = UserObj.getInstance().playerInfo.skillList;
            if (AutoFightModel.fightSkill == 1)
            {
                _loc_2 = SkillCfgObj.getInstance().getSkillSortTable();
                _loc_3 = UserObj.getInstance().playerInfo.job;
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = int(_loc_4["q_default"]);
                _loc_6 = 0;
                _loc_7 = [];
                for (_loc_8 in _loc_4)
                {
                    
                    if (_loc_8.indexOf("q_skill_") != -1 && _loc_4[_loc_8] != "")
                    {
                        _loc_7.push(int(_loc_4[_loc_8]));
                    }
                }
                _loc_9 = 0;
                while (_loc_9 < _loc_1.length)
                {
                    
                    if (_loc_6 < 8)
                    {
                        if (_loc_1[_loc_9].q_skillID == _loc_5 || _loc_7.indexOf(_loc_1[_loc_9].q_skillID) == -1)
                        {
                        }
                        else
                        {
                            this.skillBoxList[_loc_6].data = _loc_1[_loc_9];
                            _loc_6++;
                        }
                    }
                    _loc_9++;
                }
            }
            else
            {
                _loc_10 = AutoFightModel.skillIdList;
                if (!_loc_10)
                {
                    return;
                }
                _loc_9 = 0;
                while (_loc_9 < _loc_10.length)
                {
                    
                    _loc_11 = 0;
                    while (_loc_11 < _loc_1.length)
                    {
                        
                        if (_loc_1[_loc_11].q_skillID == _loc_10[_loc_9])
                        {
                            this.skillBoxList[_loc_9].data = _loc_1[_loc_11];
                        }
                        _loc_11++;
                    }
                    _loc_9++;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < 8)
            {
                
                this.skillBoxList[_loc_1].data = null;
                _loc_1++;
            }
            return;
        }// end function

    }
}
