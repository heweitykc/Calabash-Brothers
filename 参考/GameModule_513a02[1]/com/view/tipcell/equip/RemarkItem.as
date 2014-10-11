package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.text.*;

    public class RemarkItem extends BaseItem
    {
        private var _remarkTxt:TextField;

        public function RemarkItem()
        {
            this._remarkTxt = new TextField();
            _textFormat.leading = 4;
            this._remarkTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._remarkTxt.autoSize = TextFieldAutoSize.NONE;
            this._remarkTxt.multiline = true;
            this._remarkTxt.wordWrap = true;
            this._remarkTxt.width = 215;
            this._remarkTxt.mouseEnabled = false;
            this._remarkTxt.defaultTextFormat = _textFormat;
            this._remarkTxt.selectable = false;
            this._remarkTxt.textColor = 2031360;
            addChild(this._remarkTxt);
            return;
        }// end function

        public function repaintRemark(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_4:* = 0;
            var _loc_3:* = "";
            if (param1.q_remarkable_attack)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11846"), [param1.q_remarkable_attack / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.allattack_bylevel)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11847"), [param1.allattack_bylevel]) + "<br>");
                _loc_4++;
            }
            if (param1.allattack_percent)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11848"), [param1.allattack_percent / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_physicattack_bylevel)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11849"), [param1.q_physicattack_bylevel]) + "<br>");
                _loc_4++;
            }
            if (param1.q_remark_physicattack_percent)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11850"), [param1.q_remark_physicattack_percent / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_magicattack_bylevel)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11851"), [param1.q_magicattack_bylevel]) + "<br>");
                _loc_4++;
            }
            if (param1.q_remark_magicattack_percent)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11852"), [param1.q_remark_magicattack_percent / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_remarkable_attackSpeed)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11853"), [param1.q_remarkable_attackSpeed]) + "<br>");
                _loc_4++;
            }
            if (param1.q_addhp_whenkill)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11854"), [param1.q_addhp_whenkill]) + "<br>");
                _loc_4++;
            }
            if (param1.q_addmp_whenkill)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11855"), [param1.q_addmp_whenkill]) + "<br>");
                _loc_4++;
            }
            if (param1.q_hp_cover)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11856"), [param1.q_hp_cover / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_add_hplimit)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11857"), [param1.q_add_hplimit / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_add_mplimit)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11858"), [param1.q_add_mplimit / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_reduce_damage)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11859"), [param1.q_reduce_damage / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_rebound_damage)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11860"), [param1.q_rebound_damage / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_defence_remark)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11861"), [param1.q_defence_remark / 100]) + "<br>");
                _loc_4++;
            }
            if (param1.q_add_money)
            {
                _loc_3 = _loc_3 + (StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11862"), [param1.q_add_money / 100]) + "<br>");
                _loc_4++;
            }
            this._remarkTxt.htmlText = _loc_3;
            this._remarkTxt.height = this._remarkTxt.textHeight + 4;
            if (_loc_3 != "")
            {
                param2.add(this);
                addGapPoint(this._remarkTxt.y, _loc_4);
                addGapLine(this._remarkTxt.y + this._remarkTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

        public function repaintRemarkCount(param1:int, param2:HBox) : void
        {
            var _loc_3:* = "";
            var _loc_4:* = 0;
            while (_loc_4 < param1)
            {
                
                _loc_3 = _loc_3 + (LanguageCfgObj.getInstance().getByIndex("11845") + "<br>");
                _loc_4++;
            }
            this._remarkTxt.htmlText = _loc_3;
            this._remarkTxt.height = this._remarkTxt.textHeight + 4;
            if (_loc_3 != "")
            {
                param2.add(this);
                addGapPoint(this._remarkTxt.y, param1);
                addGapLine(this._remarkTxt.y + this._remarkTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
