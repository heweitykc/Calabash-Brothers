package com.game.skill.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.game.backpack.model.*;
    import com.game.clickstream.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.lostskills.bean.*;
    import com.game.role.util.*;
    import com.game.skill.control.*;
    import com.game.skill.model.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SkillPanel extends BaseBox
    {
        private var _btnJobSkill:BaseButton;
        private var _btnPassiveSkill:BaseButton;
        private var _spiritInfoArea:MovieClip;
        private var _btnClose:BaseButton;
        private var _btns:Buttons;
        private var _masterBtn:BaseButton;
        private var _txtCountSpirit:TextField;
        private var _txtGetSpirit:TextField;
        private var _vecPassiveinfos:Vector.<SkillPassiveInfo>;
        private var _itemList:List;
        private var items:Vector.<SkillItemBase>;
        private var backItems:Vector.<PropInfo>;
        private var openType:int = 0;
        private static const GET_SPIRIT_TIPS_WORD:String = LanguageCfgObj.getInstance().getByIndex("12360");

        public function SkillPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.items = new Vector.<SkillItemBase>;
            super(param1, param2, param3, param4);
            _combinedBox = ["com.game.zones.view.dekaron::ZonesDekaronPanel"];
            loadDisplay("res/skill.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("skill");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._masterBtn = new BaseButton(getDisplayChildByName("masterBtn"));
            this._masterBtn.setText(LanguageCfgObj.getInstance().getByIndex("12441"));
            this._masterBtn.visible = RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level);
            this._masterBtn.addEvtListener(MouseEvent.CLICK, this.masterBtnHandler);
            this._btnJobSkill = new BaseButton(getDisplayChildByName("tabBtn0"), true);
            this._btnJobSkill.parent.removeChild(this._btnJobSkill);
            this._btnJobSkill.setText(LanguageCfgObj.getInstance().getByIndex("11175"));
            this._btnPassiveSkill = new BaseButton(getDisplayChildByName("tabBtn1"), true);
            this._btnPassiveSkill.parent.removeChild(this._btnPassiveSkill);
            this._btnPassiveSkill.setText(LanguageCfgObj.getInstance().getByIndex("11176"));
            this._spiritInfoArea = MovieClip(getDisplayChildByName("spirit_info"));
            this._txtCountSpirit = TextField(this._spiritInfoArea.getChildByName("txt_count_spirit"));
            this._txtGetSpirit = TextField(this._spiritInfoArea.getChildByName("txt_get_spirit"));
            this._txtGetSpirit.htmlText = LanguageCfgObj.getInstance().getByIndex("11177");
            StringTip.create(this._txtGetSpirit, GET_SPIRIT_TIPS_WORD);
            this._spiritInfoArea.visible = false;
            this._itemList = new List(363, 396);
            this.display.addChild(this._itemList);
            this._itemList.move(23, 91);
            this._btns = new Buttons();
            this.addChild(this._btns);
            this._btns.horizontal = true;
            this._btns.intervalX = 1;
            this._btns.intervalY = 0;
            this._btns.move(20, 52);
            this._btns.add(this._btnJobSkill);
            this._btns.add(this._btnPassiveSkill);
            this.setJobInfo();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this._btns.addEventListener(Event.CHANGE, this.onTabChange);
            var _loc_1:* = UserObj.getInstance().playerInfo;
            _loc_1.addEventListener(RoleEvent.UPDATE_SPIRIT, this.onChangeSpirit);
            _loc_1.addEventListener(RoleEvent.UPDATE_LEVEL, this.onUpdateLevelHandler);
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this.backItems = null;
            return;
        }// end function

        protected function masterBtnHandler(event:MouseEvent) : void
        {
            MasterSkillControl.instance.openOrCloseSkillPanel();
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.openToTabSkill(this.openType);
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function onChangeSpirit(event:Event) : void
        {
            this.freshSpirit();
            return;
        }// end function

        protected function onUpdateLevelHandler(event:Event) : void
        {
            this._masterBtn.visible = RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level);
            return;
        }// end function

        protected function onTabChange(event:Event) : void
        {
            switch(this._btns.selectBtn)
            {
                case this._btnPassiveSkill:
                {
                    this._itemList.setWH(363, 396 - 50);
                    this._spiritInfoArea.visible = true;
                    this._spiritInfoArea.parent.setChildIndex(this._spiritInfoArea, (this._spiritInfoArea.parent.numChildren - 1));
                    break;
                }
                case this._btnJobSkill:
                {
                    this._itemList.setWH(363, 396);
                    this._spiritInfoArea.visible = false;
                    break;
                }
                default:
                {
                    break;
                }
            }
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
                case this._btnPassiveSkill:
                {
                    this.backItems = null;
                    ClickStream.add(ClickStreamId.OPEN_YiLuoJiNeng);
                    this.setPassiveInfo();
                    break;
                }
                case this._btnJobSkill:
                {
                    if (isOpen)
                    {
                        ClickStream.add(ClickStreamId.OPEN_JiNeng);
                    }
                    this.setJobInfo();
                    break;
                }
                case this._txtGetSpirit:
                {
                    ZonesControl.getInstance().openZonesDekaron();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPassiveInfo() : void
        {
            SkillControl.getInstance().reqLostSkillInfos();
            this._itemList.reset();
            this.freshSpirit();
            this.updateLostInfo();
            return;
        }// end function

        private function freshSpirit() : void
        {
            this._txtCountSpirit.text = UserObj.getInstance().playerInfo.spirit.toString();
            return;
        }// end function

        private function setJobInfo() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.job;
            var _loc_2:* = SkillCfgObj.getInstance().getSkillListFroJob(_loc_1);
            _loc_2 = _loc_2.sort(this.sortSkill);
            if (_loc_2)
            {
                this._itemList.reset();
                while (this.items.length)
                {
                    
                    _loc_6 = this.items.pop();
                    if (_loc_6.parent)
                    {
                        _loc_6.parent.removeChild(_loc_7);
                    }
                }
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    _loc_7 = new SkillIntroduceItem();
                    _loc_7.info = _loc_2[_loc_5];
                    _loc_7.isStudy = this.getSkillState(_loc_2[_loc_5]);
                    if (_loc_7.isStudy)
                    {
                        this.items.splice(_loc_4, 0, _loc_7);
                        _loc_4++;
                    }
                    else
                    {
                        this.items.push(_loc_7);
                    }
                    _loc_5++;
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_3)
                {
                    
                    this._itemList.add(this.items[_loc_5]);
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function sortSkill(param1:SkillInfo, param2:SkillInfo) : int
        {
            if (param1.q_skillID < param2.q_skillID)
            {
                return -1;
            }
            if (param1.q_skillID > param2.q_skillID)
            {
                return 1;
            }
            return 0;
        }// end function

        private function getSkillState(param1:SkillInfo) : Boolean
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.skillList;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4].q_skillID == SkillInfo(param1).q_skillID)
                {
                    return true;
                }
                _loc_4++;
            }
            return false;
        }// end function

        public function openToTabSkill(param1:int) : void
        {
            if (this.UILoaded)
            {
                this.setTabType(param1);
            }
            else
            {
                this.openType = param1;
            }
            return;
        }// end function

        private function setTabType(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    this._btnJobSkill.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                case 2:
                {
                    this._btnPassiveSkill.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function freshLostSkillInfo(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = null;
            if (this._btns.selectBtn == this._btnPassiveSkill)
            {
                _loc_4 = this.getItemFromType(param3) as SkillPassiveItem;
                _loc_4.setServerInfo(param1, param2, param3);
                _loc_4.playEffect();
            }
            return;
        }// end function

        public function updateLostInfo() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_1:* = SkillModel.getInstance().vecLostSkillInfo;
            if (!_loc_1)
            {
                return;
            }
            while (this.items.length > 0)
            {
                
                _loc_7 = this.items.pop();
                if (_loc_7.parent)
                {
                    _loc_7.parent.removeChild(_loc_7);
                }
            }
            if (!this._vecPassiveinfos)
            {
                this._vecPassiveinfos = this.getPassiveSkillList();
            }
            if (this._vecPassiveinfos)
            {
                _loc_8 = this._vecPassiveinfos.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_8)
                {
                    
                    _loc_3 = new SkillPassiveItem();
                    _loc_3.info = this._vecPassiveinfos[_loc_4];
                    this.items.push(_loc_3);
                    _loc_4++;
                }
            }
            _loc_8 = _loc_1.length;
            _loc_4 = 0;
            while (_loc_4 < _loc_8)
            {
                
                _loc_2 = _loc_1[_loc_4];
                _loc_3 = this.getItemFromType(_loc_2.skillType) as SkillPassiveItem;
                _loc_3.setServerInfo(_loc_2.skillId, _loc_2.skillLv, _loc_2.skillType);
                _loc_4++;
            }
            var _loc_5:* = this.sortPassiveItems();
            _loc_8 = this.items.length;
            this._itemList.reset();
            var _loc_6:* = -1;
            _loc_4 = 0;
            while (_loc_4 < _loc_8)
            {
                
                this._itemList.add(this.items[_loc_4]);
                if (this.items[_loc_4] == _loc_5)
                {
                    _loc_6 = _loc_4;
                }
                _loc_4++;
            }
            if (_loc_6 != -1)
            {
                this._itemList.scrollTo(_loc_6);
            }
            return;
        }// end function

        private function sortPassiveItems() : SkillPassiveItem
        {
            var _loc_1:* = null;
            var _loc_7:* = null;
            var _loc_2:* = new Vector.<SkillItemBase>;
            var _loc_3:* = new Vector.<SkillItemBase>;
            var _loc_4:* = new Vector.<SkillItemBase>;
            var _loc_5:* = this.items.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_7 = this.items[_loc_6] as SkillPassiveItem;
                if (_loc_7.isActive())
                {
                    _loc_2.push(_loc_7);
                }
                else if (this.canActive(_loc_7.info))
                {
                    if (!_loc_1)
                    {
                        _loc_1 = _loc_7;
                    }
                    _loc_7.isCanActive = true;
                    _loc_3.push(_loc_7);
                }
                else
                {
                    _loc_7.isCanActive = false;
                    _loc_4.push(_loc_7);
                }
                _loc_6++;
            }
            this.items = null;
            this.items = _loc_2.concat(_loc_3);
            this.items = this.items.concat(_loc_4);
            return _loc_1;
        }// end function

        private function canActive(param1:SkillPassiveInfo) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            if (this.backItems == null)
            {
                this.backItems = BackpackObj.getInstance().getGoodsByType(10);
            }
            var _loc_2:* = param1.q_need_info;
            var _loc_3:* = _loc_2.split(";");
            if (UserObj.getInstance().playerInfo.level < param1.q_need_level)
            {
                return false;
            }
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = String(_loc_3[_loc_4]).split("_");
                switch(_loc_5[0])
                {
                    case "-6":
                    {
                        _loc_6 = UserObj.getInstance().playerInfo.spirit;
                        if (int(_loc_5[1]) < _loc_6)
                        {
                            return false;
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (int(_loc_5[0]) > 0)
                {
                    _loc_7 = int(_loc_5[0]);
                    _loc_8 = this.backItems.length;
                    _loc_9 = false;
                    _loc_10 = 0;
                    while (_loc_10 < _loc_8)
                    {
                        
                        if (_loc_7 == this.backItems[_loc_10].q_id)
                        {
                            _loc_9 = true;
                        }
                        _loc_10++;
                    }
                    if (!_loc_9)
                    {
                        return false;
                    }
                }
                _loc_4++;
            }
            return true;
        }// end function

        private function getItemFromType(param1:int) : SkillItemBase
        {
            var _loc_2:* = null;
            var _loc_3:* = this.items.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2 = this.items[_loc_4];
                if (SkillPassiveInfo(_loc_2.info).q_skill_type == param1)
                {
                    return _loc_2;
                }
                _loc_4++;
            }
            return null;
        }// end function

        private function getPassiveSkillList() : Vector.<SkillPassiveInfo>
        {
            var _loc_2:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = new Vector.<SkillPassiveInfo>;
            var _loc_3:* = 0;
            while (_loc_3 < 100)
            {
                
                _loc_4 = this.getPassiveSkillId((_loc_3 + 1), 1);
                _loc_5 = SkillCfgObj.getInstance().getskillLostInfo(_loc_4);
                if (_loc_5)
                {
                    _loc_2 = new SkillPassiveInfo();
                    _loc_2.parse(_loc_5);
                    _loc_1.push(_loc_2);
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function getPassiveSkillId(param1:int, param2:int) : int
        {
            return param1 * 1000 + param2;
        }// end function

    }
}
