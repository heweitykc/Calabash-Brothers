package com.game.autopk.mediator
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.model.*;
    import com.game.autopk.view.*;
    import com.game.autopk.view.render.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class AutoFightSkillSetMediator extends Object
    {
        private var panel:AutoFightSkillSetPanel;
        private var renderList:Vector.<SkillBorderItemRender>;
        private var selectGrid:SkillBoxItemMediator;

        public function AutoFightSkillSetMediator(param1:AutoFightSkillSetPanel)
        {
            this.panel = param1;
            param1.btn_cancel.addEventListener(MouseEvent.CLICK, this.onCancelHandle);
            param1.btn_submit.addEventListener(MouseEvent.CLICK, this.onSubmitHandle);
            this.renderList = new Vector.<SkillBorderItemRender>;
            var _loc_2:* = param1.skillBoxList;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3].addEventListener(MouseEvent.CLICK, this.onItemClickHandle);
                _loc_2[_loc_3].addEventListener("rightClick", this.onRemoveHandle);
                _loc_3++;
            }
            return;
        }// end function

        private function onRemoveHandle(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as SkillBoxItemMediator;
            _loc_2.data = null;
            return;
        }// end function

        private function onItemClickHandle(event:MouseEvent) : void
        {
            this.selectGrid = event.currentTarget as SkillBoxItemMediator;
            this.panel.mc_list.x = this.selectGrid.skin.x;
            this.panel.mc_list.y = this.selectGrid.skin.y + this.selectGrid.skin.height * 0.5;
            this.panel.mc_list.visible = true;
            this.updateDropList();
            return;
        }// end function

        private function updateDropList() : void
        {
            var _loc_2:* = 0;
            var _loc_11:* = null;
            var _loc_13:* = null;
            var _loc_15:* = null;
            var _loc_1:* = this.renderList.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this.renderList[_loc_2])
                {
                    if (this.renderList[_loc_2].parent)
                    {
                        this.renderList[_loc_2].parent.removeChild(this.renderList[_loc_2]);
                    }
                    this.renderList[_loc_2] = null;
                }
                _loc_2++;
            }
            this.renderList.length = 0;
            var _loc_3:* = this.panel.skillBoxList;
            var _loc_4:* = new Vector.<long>;
            _loc_2 = 0;
            while (_loc_2 < _loc_3.length)
            {
                
                _loc_15 = _loc_3[_loc_2].data;
                if (_loc_15)
                {
                    _loc_4.push(_loc_15.skillId);
                }
                _loc_2++;
            }
            var _loc_5:* = SkillCfgObj.getInstance().getSkillSortTable();
            var _loc_6:* = UserObj.getInstance().playerInfo.job;
            var _loc_7:* = _loc_5[_loc_6];
            var _loc_8:* = int(_loc_7["q_default"]);
            var _loc_9:* = UserObj.getInstance().playerInfo.skillList;
            var _loc_10:* = [];
            for (_loc_11 in _loc_7)
            {
                
                if (_loc_11.indexOf("q_skill_") != -1 && _loc_7[_loc_11] != "")
                {
                    _loc_10.push(int(_loc_7[_loc_11]));
                }
            }
            _loc_1 = _loc_9.length;
            if (_loc_1 == 0)
            {
                return;
            }
            var _loc_12:* = 0;
            _loc_13 = new SkillBorderItemRender();
            _loc_13.setUnloadItem();
            _loc_13.addEventListener(MouseEvent.CLICK, this.onItemClick);
            _loc_13.x = 4;
            _loc_13.y = 4 + 60 * _loc_12++;
            this.renderList.push(_loc_13);
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (_loc_4.indexOf(_loc_9[_loc_2].skillId) == -1 && _loc_9[_loc_2].q_skillID != _loc_8 && _loc_10.indexOf(_loc_9[_loc_2].q_skillID) != -1)
                {
                    _loc_13 = new SkillBorderItemRender();
                    _loc_13.addEventListener(MouseEvent.CLICK, this.onItemClick);
                    _loc_13.x = 4;
                    _loc_13.y = 4 + 60 * _loc_12++;
                    _loc_13.data = _loc_9[_loc_2];
                    this.renderList.push(_loc_13);
                }
                _loc_2++;
            }
            _loc_1 = this.renderList.length;
            var _loc_14:* = this.panel.mc_list.getChildByName("bg") as MovieClip;
            if (_loc_1 < 5)
            {
                this.panel.listMC.visible = false;
                _loc_14.width = 64;
                _loc_14.height = 64 * _loc_1;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    this.panel.mc_list.addChild(this.renderList[_loc_2]);
                    _loc_2++;
                }
            }
            else
            {
                this.panel.listMC.reset();
                this.panel.listMC.visible = true;
                _loc_14.width = 88;
                _loc_14.height = 222;
                _loc_2 = 0;
                while (_loc_2 < _loc_1)
                {
                    
                    this.panel.listMC.add(this.renderList[_loc_2]);
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function onItemClick(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as SkillBorderItemRender;
            var _loc_3:* = _loc_2.data;
            this.panel.mc_list.visible = false;
            this.selectGrid.data = _loc_3;
            return;
        }// end function

        private function onCancelHandle(event:MouseEvent) : void
        {
            this.panel.close();
            return;
        }// end function

        public function get autoSkill() : Vector.<SkillInfo>
        {
            var _loc_4:* = null;
            var _loc_1:* = new Vector.<SkillInfo>;
            var _loc_2:* = this.panel.skillBoxList;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3].data;
                if (_loc_4)
                {
                    _loc_1.push(_loc_4);
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function onSubmitHandle(event:MouseEvent) : void
        {
            AutoFightController.getInstance().fightPanel.rd_skill2.selected = true;
            this.panel.getTableData();
            AutoFightModel.save();
            this.panel.close();
            return;
        }// end function

    }
}
