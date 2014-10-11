package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import flash.text.*;

    public class LimitItem extends BaseItem
    {
        private var _limitTxt:TextField;

        public function LimitItem()
        {
            this._limitTxt = new TextField();
            this._limitTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._limitTxt.autoSize = TextFieldAutoSize.NONE;
            this._limitTxt.multiline = true;
            this._limitTxt.wordWrap = true;
            this._limitTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._limitTxt.width = 215;
            _textFormat.leading = 2;
            this._limitTxt.defaultTextFormat = _textFormat;
            this._limitTxt.selectable = false;
            this._limitTxt.mouseEnabled = false;
            addChild(this._limitTxt);
            return;
        }// end function

        public function initLimitContainer(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_6:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = UserObj.getInstance().playerInfo;
            var _loc_5:* = "";
            if (param1.q_level)
            {
                if (_loc_4.level >= param1.q_level)
                {
                    _loc_6 = 16777215;
                }
                else
                {
                    _loc_6 = 16711680;
                }
                _loc_5 = _loc_5 + ("<font color = \'#" + _loc_6.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11809") + param1.q_level + "</font><br>");
            }
            _loc_5 = _loc_5 + this.setProfession(param1);
            if (param1.q_str_limit)
            {
                if (_loc_4.strength >= param1.q_str_limit)
                {
                    _loc_6 = 16777215;
                }
                else
                {
                    _loc_6 = 16711680;
                }
                _loc_5 = _loc_5 + ("<font color = \'#" + _loc_6.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11810") + param1.q_str_limit + "</font><br>");
            }
            if (param1.q_agile_limit)
            {
                if (_loc_4.agile >= param1.q_agile_limit)
                {
                    _loc_6 = 16777215;
                }
                else
                {
                    _loc_6 = 16711680;
                }
                _loc_5 = _loc_5 + ("<font color = \'#" + _loc_6.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11811") + param1.q_agile_limit + "</font><br>");
            }
            if (param1.q_int_limit)
            {
                if (_loc_4.intelligence >= param1.q_int_limit)
                {
                    _loc_6 = 16777215;
                }
                else
                {
                    _loc_6 = 16711680;
                }
                _loc_5 = _loc_5 + ("<font color = \'#" + _loc_6.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11812") + param1.q_int_limit + "</font><br>");
            }
            if (param1.q_vit_limit)
            {
                if (_loc_4.vitality >= param1.q_vit_limit)
                {
                    _loc_6 = 16777215;
                }
                else
                {
                    _loc_6 = 16711680;
                }
                _loc_5 = _loc_5 + ("<font color = \'#" + _loc_6.toString(16) + "\'>" + LanguageCfgObj.getInstance().getByIndex("11813") + param1.q_vit_limit + "</font><br>");
            }
            this._limitTxt.htmlText = _loc_5;
            this._limitTxt.height = this._limitTxt.textHeight + 4;
            if (_loc_5 != "")
            {
                param2.add(this);
                addGapLine(this._limitTxt.y + this._limitTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

        private function setProfession(param1:EquipmentInfo) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.isUseForJob(UserObj.getInstance().playerInfo.job);
            if (param1.q_job_limit == 0)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10175");
                _loc_2 = true;
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10176");
                _loc_3 = _loc_3 + PropUtil.getProfessionStr(param1.q_job_limit);
                if (_loc_2)
                {
                    _loc_3 = "<font color = \'#ffffff\'>" + _loc_3 + "</font>";
                }
                else
                {
                    _loc_3 = "<font color = \'#ff0000\'>" + _loc_3 + "</font>";
                }
            }
            return _loc_3 + "<br>";
        }// end function

    }
}
