package com.game.autopk.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.mediator.*;
    import com.game.autopk.model.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class AutoFightPanel extends BaseBox
    {
        public var mediator:AutoFightMediator;
        public var close_btn:BaseButton;
        public var box1:CheckBox;
        public var box2:CheckBox;
        public var box_pick:CheckBox;
        public var btn_vip:BaseButton;
        public var btn_open:BaseButton;
        public var mc_drop:MovieClip;
        public var btn_sell:UIButton;
        public var btn_skill:UIButton;
        public var btn_pick:SimpleButton;
        public var rd_range1:CheckBox;
        public var rd_range2:CheckBox;
        public var rd_sell1:CheckBox;
        public var rd_sell2:CheckBox;
        public var rd_skill1:CheckBox;
        public var rd_skill2:CheckBox;
        public var rd_type1:CheckBox;
        public var rd_type2:CheckBox;
        public var txt_num1:TextField;
        public var txt_num2:TextField;
        public var txt_pick:TextField;
        public var rangeView:MovieClip;
        public var rangeBtn:BaseButton;
        public var range:MovieClip;
        public var rangeMask:Shape;
        public var rangeText:TextField;
        public var dropList:Vector.<CheckBox>;
        private var selectDrop:uint;
        private var old_num1:int = 80;
        private var old_num2:int = 50;
        private var beginX:Number;
        private var begin:Number;

        public function AutoFightPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            _combinedBox = ["com.game.autopk.view::AutoFightSellSetPanel", "com.game.autopk.view::AutoFightSkillSetPanel", "com.game.autopk.view::VipSetPanel", "com.game.artifact.view::ArtifactExtractSettingPanel"];
            loadDisplay("res/autopk.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("AutoFightSet");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = display;
            this.close_btn = new BaseButton(getDisplayChildByName("btn_close"));
            this.box1 = new CheckBox(getDisplayChildByName("box1"));
            this.box1.bindTextField(getDisplayChildByName("tx1"));
            this.box1.selected = true;
            this.box2 = new CheckBox(getDisplayChildByName("box2"));
            this.box2.bindTextField(getDisplayChildByName("tx2"));
            this.box2.selected = true;
            this.box_pick = new CheckBox(getDisplayChildByName("box_pick"));
            this.box_pick.selected = true;
            this.btn_open = new BaseButton(getDisplayChildByName("btn_open"));
            this.btn_vip = new BaseButton(getDisplayChildByName("btn_vip"));
            if (UserObj.getInstance().playerInfo.vipid == 0)
            {
                this.btn_vip.visible = false;
            }
            this.btn_vip.setText(LanguageCfgObj.getInstance().getByIndex("10310"));
            if (0)
            {
                this.btn_vip.visible = false;
            }
            this.mc_drop = getDisplayChildByName("mc_drop");
            this.mc_drop.addEventListener(MouseEvent.ROLL_OUT, this.onBoxRoleOutHandle);
            this.setDropBox(this.mc_drop);
            this.btn_pick = getDisplayChildByName("btn_pick");
            this.btn_pick.addEventListener(MouseEvent.CLICK, this.onPickItemClick);
            this.btn_sell = new UIButton(getDisplayChildByName("btn_sell"));
            this.btn_sell.setText(LanguageCfgObj.getInstance().getByIndex("10311"));
            this.btn_skill = new UIButton(getDisplayChildByName("btn_skill"));
            this.btn_skill.setText(LanguageCfgObj.getInstance().getByIndex("10312"));
            this.rangeView = getDisplayChildByName("rangeView");
            this.rangeBtn = new BaseButton(this.rangeView["rangeBtn"]);
            this.rangeBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onRangeDown);
            this.range = this.rangeView["range"];
            this.rangeText = this.rangeView["rangeNum"];
            this.rangeMask = new Shape();
            this.rangeMask.y = this.range.y;
            this.rangeMask.x = this.range.x;
            this.rangeMask.graphics.beginFill(0, 0);
            this.rangeMask.graphics.drawRect(0, 0, this.range.width, this.range.height);
            this.rangeMask.graphics.endFill();
            this.range.parent.addChild(this.rangeMask);
            this.range.mask = this.rangeMask;
            this.rd_sell1 = new CheckBox(getDisplayChildByName("rd_sell1"));
            this.rd_sell2 = new CheckBox(getDisplayChildByName("rd_sell2"));
            var _loc_2:* = getDisplayChildByName("t41") as TextField;
            this.rd_sell1.bindTextField(_loc_2);
            CheckBox.group(this.rd_sell1, this.rd_sell2);
            this.rd_sell1.selected = false;
            this.rd_sell2.selected = false;
            this.rd_skill1 = new CheckBox(getDisplayChildByName("rd_skill1"));
            this.rd_skill2 = new CheckBox(getDisplayChildByName("rd_skill2"));
            this.rd_skill1.bindTextField(getDisplayChildByName("t31"));
            CheckBox.group(this.rd_skill1, this.rd_skill2);
            this.rd_type1 = new CheckBox(getDisplayChildByName("rd_type1"));
            this.rd_type2 = new CheckBox(getDisplayChildByName("rd_type2"));
            this.rd_type1.bindTextField(getDisplayChildByName("t11") as TextField);
            this.rd_type2.bindTextField(getDisplayChildByName("t12") as TextField);
            CheckBox.group(this.rd_type1, this.rd_type2);
            var _loc_3:* = getDisplayChildByName("t11") as TextField;
            var _loc_4:* = getDisplayChildByName("t12") as TextField;
            this.txt_pick = getDisplayChildByName("txt_pick") as TextField;
            this.txt_pick.defaultTextFormat = new TextFormat(null, 12, null, null, null, false, null, "left");
            this.txt_num1 = getDisplayChildByName("txt_num1") as TextField;
            this.txt_num2 = getDisplayChildByName("txt_num2") as TextField;
            this.txt_num1.addEventListener(Event.CHANGE, this.onTextChange1);
            this.txt_num2.addEventListener(Event.CHANGE, this.onTextChange2);
            var _loc_5:* = AutoFightManager.getInstance().isAutoFighting();
            if (AutoFightManager.getInstance().isAutoFighting())
            {
                if (this.btn_open)
                {
                    this.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10314"));
                }
            }
            else if (this.btn_open)
            {
                this.btn_open.setText(LanguageCfgObj.getInstance().getByIndex("10315"));
            }
            this.mediator = new AutoFightMediator(this);
            this.setTableData();
            var _loc_6:* = LanguageCfgObj.getInstance().getByIndex("11898");
            StringTip.create(this.rd_type1, LanguageCfgObj.getInstance().getByIndex("10316"));
            StringTip.create(_loc_3, LanguageCfgObj.getInstance().getByIndex("10316"));
            StringTip.create(this.rd_type2, LanguageCfgObj.getInstance().getByIndex("10318"));
            StringTip.create(_loc_4, LanguageCfgObj.getInstance().getByIndex("10318"));
            StringTip.create(this.rd_sell1, _loc_6);
            StringTip.create(_loc_2, _loc_6);
            return;
        }// end function

        private function setDropBox(param1:MovieClip) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            param1.x = 120;
            param1.y = 304;
            param1.visible = false;
            this.dropList = new Vector.<CheckBox>(PickLogic.TOTAL_PICK_NUM);
            var _loc_2:* = 0;
            while (_loc_2 < PickLogic.TOTAL_PICK_NUM)
            {
                
                if (_loc_2 == 5)
                {
                    this.selectDrop = 2 << _loc_2 | this.selectDrop;
                }
                else
                {
                    _loc_3 = param1.getChildByName("box" + (_loc_2 + 1)) as MovieClip;
                    _loc_4 = new CheckBox(_loc_3);
                    _loc_4.selected = true;
                    this.selectDrop = 2 << _loc_2 | this.selectDrop;
                    this.dropList[_loc_2] = _loc_4;
                }
                _loc_2++;
            }
            return;
        }// end function

        private function onTextChange1(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as TextField;
            if (_loc_2.text == "")
            {
                this.old_num1 = 0;
                _loc_2.text = "0";
                return;
            }
            var _loc_3:* = int(_loc_2.text);
            if (_loc_3 > 0 && _loc_3 < 100)
            {
                this.old_num1 = int(_loc_2.text);
            }
            _loc_2.text = this.old_num1 + "";
            return;
        }// end function

        private function onTextChange2(event:Event) : void
        {
            var _loc_2:* = event.currentTarget as TextField;
            if (_loc_2.text == "")
            {
                this.old_num2 = 0;
                _loc_2.text = "0";
                return;
            }
            var _loc_3:* = int(_loc_2.text);
            if (_loc_3 > 0 && _loc_3 < 100)
            {
                this.old_num2 = int(_loc_2.text);
            }
            _loc_2.text = this.old_num2 + "";
            return;
        }// end function

        private function onPickItemClick(event:MouseEvent) : void
        {
            this.mc_drop.visible = !this.mc_drop.visible;
            return;
        }// end function

        private function onBoxRoleOutHandle(event:MouseEvent) : void
        {
            this.mc_drop.visible = false;
            this.getPickTypeShow();
            return;
        }// end function

        private function onClickArtifact(event:MouseEvent) : void
        {
            ArtifactControl.getInstance().openOrCloseExtractSettingPanel();
            return;
        }// end function

        public function getPickTypeShow() : void
        {
            this.selectDrop = 0;
            var _loc_1:* = 0;
            while (_loc_1 < PickLogic.TOTAL_PICK_NUM)
            {
                
                if (_loc_1 == 5)
                {
                    this.selectDrop = 2 << _loc_1 | this.selectDrop;
                }
                else if (this.dropList[_loc_1].selected == true)
                {
                    this.selectDrop = 2 << _loc_1 | this.selectDrop;
                }
                _loc_1++;
            }
            var _loc_2:* = "";
            _loc_2 = LanguageCfgObj.getInstance().getByIndex("10320");
            this.txt_pick.text = _loc_2;
            this.txt_pick.width = this.txt_pick.textWidth + 4;
            this.btn_pick.x = this.txt_pick.x + this.txt_pick.width + 2;
            return;
        }// end function

        public function setPickTypeShow(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this.selectDrop = param1;
            var _loc_2:* = "";
            _loc_2 = LanguageCfgObj.getInstance().getByIndex("10320");
            _loc_3 = 0;
            while (_loc_3 < PickLogic.TOTAL_PICK_NUM)
            {
                
                if (_loc_3 == 5)
                {
                    _loc_4 = 2 << _loc_3;
                }
                else
                {
                    _loc_4 = 2 << _loc_3;
                    this.dropList[_loc_3].selected = _loc_4 == (this.selectDrop & _loc_4);
                }
                _loc_3++;
            }
            this.txt_pick.text = _loc_2;
            this.txt_pick.width = this.txt_pick.textWidth + 4;
            this.btn_pick.x = this.txt_pick.x + this.txt_pick.width + 2;
            return;
        }// end function

        public function getTableData() : void
        {
            if (!UILoaded)
            {
                return;
            }
            AutoFightModel.autohp = this.box1.selected;
            AutoFightModel.hp = int(this.txt_num1.text);
            AutoFightModel.automp = this.box2.selected;
            AutoFightModel.mp = int(this.txt_num2.text);
            AutoFightModel.fightType = this.rd_type1.selected ? (1) : (2);
            AutoFightModel.fightRange = Math.floor(this.rangeMask.width / this.range.width * 30) + 5;
            if (AutoFightModel.fightRange > 35)
            {
                AutoFightModel.fightRange = 35;
            }
            if (AutoFightModel.fightRange < 5)
            {
                AutoFightModel.fightRange = 5;
            }
            AutoFightModel.autoPick = this.box_pick.selected ? (true) : (false);
            AutoFightModel.pickType = this.selectDrop;
            AutoFightModel.fightSkill = this.rd_skill1.selected ? (1) : (2);
            if (this.rd_sell1.selected)
            {
                AutoFightModel.fightSell = 1;
            }
            else if (this.rd_sell2.selected)
            {
                AutoFightModel.fightSell = 2;
            }
            return;
        }// end function

        public function setTableData() : void
        {
            if (!this.mediator)
            {
                return;
            }
            this.box1.selected = AutoFightModel.autohp;
            this.txt_num1.text = AutoFightModel.hp + "";
            this.box2.selected = AutoFightModel.automp;
            this.txt_num2.text = AutoFightModel.mp + "";
            this.rd_type1.selected = AutoFightModel.fightType == 1;
            this.rd_type2.selected = AutoFightModel.fightType != 1;
            this.rangeMask.width = (AutoFightModel.fightRange - 5) * this.range.width / 30;
            this.rangeBtn.x = this.range.x + (AutoFightModel.fightRange - 5) * this.range.width / 30 - 5;
            this.rangeText.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11899"), [AutoFightModel.fightRange]);
            StringTip.create(this.rangeView, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11900"), [AutoFightModel.fightRange]));
            this.box_pick.selected = AutoFightModel.autoPick;
            this.setPickTypeShow(AutoFightModel.pickType);
            this.rd_skill1.selected = AutoFightModel.fightSkill == 1;
            this.rd_skill2.selected = AutoFightModel.fightSkill != 1;
            this.rd_sell1.selected = AutoFightModel.fightSell == 1;
            this.rd_sell2.selected = AutoFightModel.fightSell == 2;
            return;
        }// end function

        override public function open() : void
        {
            if (this.btn_vip)
            {
                this.btn_vip.visible = UserObj.getInstance().playerInfo.vipid != 0;
            }
            super.open();
            return;
        }// end function

        override public function close() : void
        {
            this.getTableData();
            AutoFightModel.save();
            super.close();
            return;
        }// end function

        private function onRangeDown(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_UP, this.onRangeUp);
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onRangeMove);
            this.beginX = event.stageX;
            this.begin = this.rangeMask.width;
            return;
        }// end function

        private function onRangeMove(event:MouseEvent) : void
        {
            var _loc_2:* = event.stageX;
            var _loc_3:* = this.begin + _loc_2 - this.beginX;
            if (_loc_3 < 0)
            {
                _loc_3 = 0;
            }
            if (_loc_3 > this.range.width)
            {
                _loc_3 = this.range.width;
            }
            var _loc_4:* = Math.floor(_loc_3 / this.range.width * 30) + 5;
            this.rangeMask.width = _loc_3;
            this.rangeBtn.x = this.range.x + _loc_3 - 5;
            this.rangeText.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11899"), [_loc_4]);
            StringTip.create(this.rangeView, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11900"), [_loc_4]));
            return;
        }// end function

        private function onRangeUp(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onRangeUp);
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onRangeMove);
            return;
        }// end function

    }
}
