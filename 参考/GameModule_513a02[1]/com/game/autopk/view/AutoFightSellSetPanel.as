package com.game.autopk.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.mediator.*;
    import com.game.autopk.model.*;
    import com.game.autopk.view.render.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class AutoFightSellSetPanel extends BaseBox
    {
        private var mediator:AutoFightSellMediator;
        private var btn_close:BaseButton;
        private var btn_clean:UIButton;
        public var btn_submit:BaseButton;
        public var btn_cancel:BaseButton;
        public var downBox1:DownListBox;
        public var downBox2:DownListBox;
        public var downBox3:DownListBox;
        public var downBox4:DownListBox;
        public var label2:TextField;
        public var label3:TextField;
        public var dropList:Vector.<CheckBox>;

        public function AutoFightSellSetPanel()
        {
            initBaseBoxUI("AutoFightSellSet");
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_clean = new UIButton(getDisplayChildByName("btn_clean"));
            this.btn_clean.setText(LanguageCfgObj.getInstance().getByIndex("10322"));
            this.btn_clean.visible = false;
            this.btn_clean.addEventListener(MouseEvent.CLICK, this.onCleanHandle);
            this.btn_close.addEvtListener(MouseEvent.CLICK, this.onClosePanel);
            this.dropList = new Vector.<CheckBox>(8);
            var _loc_1:* = 1;
            while (_loc_1 <= 8)
            {
                
                if (_loc_1 == 4 || _loc_1 == 7)
                {
                }
                else
                {
                    _loc_10 = new CheckBox(getDisplayChildByName("box" + _loc_1));
                    _loc_11 = getDisplayChildByName("t" + _loc_1) as TextField;
                    _loc_10.bindTextField(_loc_11);
                    _loc_10.selected = true;
                    this.dropList[(_loc_1 - 1)] = _loc_10;
                }
                _loc_1++;
            }
            this.dropList[1].visible = false;
            this.dropList[1].selected = true;
            this.dropList[2].visible = false;
            this.dropList[2].selected = true;
            var _loc_2:* = getDisplayChildByName("t1") as TextField;
            _loc_2.htmlText = LanguageCfgObj.getInstance().getByIndex("10323");
            var _loc_3:* = getDisplayChildByName("t5") as TextField;
            this.btn_submit = new BaseButton(getDisplayChildByName("btn_submit"));
            this.btn_submit.setText(LanguageCfgObj.getInstance().getByIndex("10325"));
            this.btn_cancel = new BaseButton(getDisplayChildByName("btn_cancel"));
            this.btn_cancel.setText(LanguageCfgObj.getInstance().getByIndex("10326"));
            this.btn_cancel.addEventListener(MouseEvent.CLICK, this.onCancelHandle);
            var _loc_4:* = new BaseButton(getDisplayChildByName("btn2"));
            var _loc_5:* = new BaseButton(getDisplayChildByName("btn3"));
            var _loc_6:* = getDisplayChildByName("mc_list1");
            _loc_6.visible = false;
            _loc_7 = getDisplayChildByName("mc_list2");
            _loc_7.visible = false;
            _loc_8 = getDisplayChildByName("mc_list3");
            _loc_8.visible = false;
            var _loc_9:* = getDisplayChildByName("mc_list4");
            _loc_9.visible = false;
            this.label2 = getDisplayChildByName("label2");
            this.label2.defaultTextFormat = new TextFormat(null, 12, 16750848, false, null, false);
            this.label3 = getDisplayChildByName("label3");
            this.label3.defaultTextFormat = new TextFormat(null, 12, 16750848, false, null, false);
            this.downBox2 = new DownListBox(this.label2, _loc_4, _loc_7);
            this.downBox2.render = NumItemRender;
            this.downBox3 = new DownListBox(this.label3, _loc_5, _loc_8);
            this.downBox3.render = NumItemRender;
            this.downBox2.dataProvider = [{label:"+1"}, {label:"+2"}, {label:"+3"}, {label:"+4"}, {label:"+5"}, {label:"+6"}, {label:"+7"}, {label:"+8"}, {label:"+9"}, {label:"+10"}, {label:"+11"}, {label:"+12"}, {label:"+13"}];
            this.downBox3.dataProvider = [{label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [1])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [2])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [3])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [4])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [5])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [6])}, {label:StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11901"), [7])}];
            this.mediator = new AutoFightSellMediator(this);
            this.setTableData();
            return;
        }// end function

        private function onClosePanel(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openOrCloseSellSetPanel();
            return;
        }// end function

        private function onCancelHandle(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openOrCloseSellSetPanel();
            return;
        }// end function

        private function onCleanHandle(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < this.dropList.length)
            {
                
                this.dropList[_loc_2].selected = false;
                _loc_2++;
            }
            this.label2.text = "";
            this.label3.text = "";
            return;
        }// end function

        public function getTableData() : void
        {
            AutoFightModel.sellLimit1 = this.dropList[0].selected;
            AutoFightModel.sellLimit2 = this.dropList[1].selected;
            AutoFightModel.sellLimit3 = this.dropList[2].selected;
            AutoFightModel.sellLimit5 = this.dropList[4].selected;
            AutoFightModel.sellLimit6 = this.dropList[5].selected;
            AutoFightModel.sellLimit8 = this.dropList[7].selected;
            AutoFightModel.sellRank1 = this.downBox2.selectIndex;
            AutoFightModel.sellRank2 = this.downBox3.selectIndex;
            return;
        }// end function

        public function setTableData() : void
        {
            this.dropList[0].selected = AutoFightModel.sellLimit1;
            this.dropList[1].selected = AutoFightModel.sellLimit2;
            this.dropList[2].selected = AutoFightModel.sellLimit3;
            this.dropList[4].selected = AutoFightModel.sellLimit5;
            this.dropList[5].selected = AutoFightModel.sellLimit6;
            this.dropList[7].selected = AutoFightModel.sellLimit8;
            this.downBox2.selectIndex = AutoFightModel.sellRank1;
            this.downBox3.selectIndex = AutoFightModel.sellRank2;
            return;
        }// end function

    }
}
