package com.view.tipcell.equip
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.text.*;

    public class SuitItem extends BaseItem
    {
        private var suitNameTxt:TextField;
        private var suitDescTxt:TextField;

        public function SuitItem()
        {
            var _loc_1:* = false;
            mouseEnabled = false;
            mouseChildren = _loc_1;
            this.suitNameTxt = new TextField();
            _textFormat.color = 49407;
            this.suitNameTxt.defaultTextFormat = _textFormat;
            this.suitNameTxt.height = 20;
            this.suitNameTxt.autoSize = TextFieldAutoSize.LEFT;
            addChild(this.suitNameTxt);
            this.suitDescTxt = new TextField();
            _textFormat.color = 14079702;
            _textFormat.leading = 3;
            this.suitDescTxt.wordWrap = true;
            this.suitDescTxt.multiline = true;
            this.suitDescTxt.defaultTextFormat = _textFormat;
            this.suitDescTxt.width = 175;
            this.suitDescTxt.y = 28;
            addChild(this.suitDescTxt);
            return;
        }// end function

        public function setSuit(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_3:* = SuitCfgObj.instance.getSuitById(param1.suitId);
            if (_loc_3)
            {
                _loc_4 = UserObj.getInstance().playerInfo.job;
                if (param1.euipSource == EquipmentInfo.EUIP_SOURCE_MY && param1.isUseForJob(_loc_4))
                {
                    _loc_5 = ItemTips.equipcompareControl.getSuitCount(param1.suitId, param1.q_kind, param1.pos) + 1;
                    this.suitNameTxt.textColor = PropUtil.getEquipColor(param1);
                    this.suitNameTxt.text = StringUtil.formatString("{0}({1}/{2})", _loc_3.q_name, _loc_5, _loc_3.total_count);
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(_loc_5);
                }
                else if (param1.euipSource == EquipmentInfo.EQUIP_SOURCE_OTHER)
                {
                    _loc_5 = ItemTips.equipcompareControl.getOtherSuitCount(param1.suitId, param1.q_kind, param1.pos);
                    this.suitNameTxt.textColor = PropUtil.getEquipColor(param1);
                    this.suitNameTxt.text = StringUtil.formatString("{0}({1}/{2})", _loc_3.q_name, _loc_5, _loc_3.total_count);
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(_loc_5);
                }
                else if (param1.euipSource == EquipmentInfo.EQUIP_SOURCE_TOPLIST)
                {
                    _loc_5 = ItemTips.equipcompareControl.getToplistSuitCount(param1.suitId, param1.q_kind, param1.pos);
                    this.suitNameTxt.textColor = PropUtil.getEquipColor(param1);
                    this.suitNameTxt.text = StringUtil.formatString("{0}({1}/{2})", _loc_3.q_name, _loc_5, _loc_3.total_count);
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(_loc_5);
                }
                else
                {
                    this.suitNameTxt.textColor = PropUtil.getEquipColor(param1);
                    this.suitNameTxt.text = _loc_3.q_name;
                    this.suitDescTxt.htmlText = _loc_3.attributeDesc(0);
                }
                this.suitDescTxt.height = this.suitDescTxt.textHeight + 5;
                addGapLine(height);
                param2.add(this);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
