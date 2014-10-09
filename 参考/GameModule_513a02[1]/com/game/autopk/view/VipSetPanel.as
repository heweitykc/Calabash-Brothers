package com.game.autopk.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.model.*;
    import com.game.autopk.view.render.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VipSetPanel extends BaseBox
    {
        private var btn_close:BaseButton;
        public var box1:CheckBox;
        public var box2:CheckBox;
        public var box3:CheckBox;
        public var box4:CheckBox;
        public var btn_submit:BaseButton;
        public var btn_cancel:BaseButton;
        public var downBox1:DownListBox;
        public var downBox2:DownListBox;

        public function VipSetPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            initBaseBoxUI("AutoFightVIPSet");
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_9:* = undefined;
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn_close.addEvtListener(MouseEvent.CLICK, this.onClosePanel);
            this.box1 = new CheckBox(getDisplayChildByName("box1"));
            this.box1.bindTextField(getDisplayChildByName("t1"));
            this.box2 = new CheckBox(getDisplayChildByName("box2"));
            this.box2.bindTextField(getDisplayChildByName("t2"));
            this.box3 = new CheckBox(getDisplayChildByName("box3"));
            this.box3.bindTextField(getDisplayChildByName("t3"));
            this.btn_submit = new BaseButton(getDisplayChildByName("btn_submit"));
            this.btn_submit.setText(LanguageCfgObj.getInstance().getByIndex("10329"));
            this.btn_submit.addEventListener(MouseEvent.CLICK, this.onSubmitHandle);
            this.btn_cancel = new BaseButton(getDisplayChildByName("btn_cancel"));
            this.btn_cancel.setText(LanguageCfgObj.getInstance().getByIndex("10330"));
            this.btn_cancel.addEventListener(MouseEvent.CLICK, this.onCancelHandle);
            _loc_1 = getDisplayChildByName("label1");
            _loc_2 = getDisplayChildByName("label2");
            var _loc_3:* = new BaseButton(getDisplayChildByName("btn1"));
            _loc_4 = new BaseButton(getDisplayChildByName("btn2"));
            var _loc_5:* = getDisplayChildByName("mc_list1");
            _loc_5.visible = false;
            _loc_6 = getDisplayChildByName("mc_list2");
            _loc_6.visible = false;
            this.downBox1 = new DownListBox(_loc_1, _loc_3, _loc_5);
            this.downBox1.render = GoodItemRender;
            this.downBox2 = new DownListBox(_loc_2, _loc_4, _loc_6);
            this.downBox2.render = GoodItemRender;
            var _loc_8:* = [];
            for each (_loc_9 in DrinkLogic.BLOOD_IDS)
            {
                
                _loc_7 = PropUtil.createItemByCfg(_loc_9);
                _loc_8.push({label:_loc_7.q_name});
            }
            this.downBox1.dataProvider = _loc_8;
            _loc_8 = [];
            for each (_loc_9 in DrinkLogic.MAGIC_IDS)
            {
                
                _loc_7 = PropUtil.createItemByCfg(_loc_9);
                _loc_8.push({label:_loc_7.q_name});
            }
            this.downBox2.dataProvider = _loc_8;
            this.setTableData();
            return;
        }// end function

        private function onClosePanel(event:MouseEvent) : void
        {
            AutoFightController.getInstance().openOrCloseVipSetPanel();
            return;
        }// end function

        private function onSubmitHandle(event:MouseEvent) : void
        {
            this.getTableData();
            AutoFightModel.save();
            close();
            return;
        }// end function

        private function onCancelHandle(event:MouseEvent) : void
        {
            this.setTableData();
            close();
            return;
        }// end function

        public function getTableData() : void
        {
            AutoFightModel.autoBuyBlood = this.box1.selected;
            AutoFightModel.autoBuyMagic = this.box2.selected;
            AutoFightModel.autoBuyBloodType = this.downBox1.selectIndex;
            AutoFightModel.autoBuyMagicType = this.downBox2.selectIndex;
            AutoFightModel.autoBorn = this.box3.selected;
            return;
        }// end function

        public function setTableData() : void
        {
            this.box1.selected = AutoFightModel.autoBuyBlood;
            this.box2.selected = AutoFightModel.autoBuyMagic;
            this.downBox1.selectIndex = AutoFightModel.autoBuyBloodType;
            this.downBox2.selectIndex = AutoFightModel.autoBuyMagicType;
            this.box3.selected = AutoFightModel.autoBorn;
            return;
        }// end function

        public function setBuyData() : void
        {
            this.downBox1.selectIndex = AutoFightModel.autoBuyBloodType;
            this.downBox2.selectIndex = AutoFightModel.autoBuyMagicType;
            return;
        }// end function

    }
}
