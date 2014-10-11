package com.view.tipcell.equip
{
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.vo.*;
    import flash.text.*;

    public class AddAttribute extends BaseItem
    {
        private var _addAttTxt:TextField;

        public function AddAttribute()
        {
            this._addAttTxt = new TextField();
            this._addAttTxt.defaultTextFormat = _textFormat;
            this._addAttTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._addAttTxt.autoSize = TextFieldAutoSize.NONE;
            this._addAttTxt.multiline = true;
            this._addAttTxt.wordWrap = true;
            this._addAttTxt.width = 215;
            this._addAttTxt.mouseEnabled = false;
            this._addAttTxt.selectable = false;
            return;
        }// end function

        public function repaintAddAttribute(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_3:* = "";
            var _loc_4:* = 0;
            if (param1.addAttributLevel)
            {
                _loc_5 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(param1.itemModelId + "_" + param1.addAttributLevel);
                _loc_6 = ItemCfgObj.getInstance().getCfgBy(param1.itemModelId);
                _loc_7 = "<font color = \'#\'>" + LanguageCfgObj.getInstance().getByIndex("11828") + "（%c + %s）</font><br>";
                _loc_7 = _loc_7.replace("%d", param1.addAttributLevel);
                if (_loc_5.q_min_physicattack)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11829")).replace("%s", _loc_5.q_min_physicattack);
                    _loc_4++;
                }
                if (_loc_5.q_min_magicattack)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11830")).replace("%s", _loc_5.q_min_magicattack);
                    _loc_4++;
                }
                if (_loc_5.q_physicattack_Percent)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11831")).replace("%s", _loc_5.q_physicattack_Percent + "%");
                    _loc_4++;
                }
                if (_loc_5.q_magicattack_Percent)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11832")).replace("%s", _loc_5.q_magicattack_Percent + "%");
                    _loc_4++;
                }
                if (_loc_5.q_defence)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11833")).replace("%s", _loc_5.q_defence);
                    _loc_4++;
                }
                if (_loc_5.q_hit)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11834")).replace("%s", _loc_5.q_hit);
                    _loc_4++;
                }
                if (_loc_5.q_dodge)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11835")).replace("%s", _loc_5.q_dodge);
                    _loc_4++;
                }
                if (_loc_5.q_max_hp)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11836")).replace("%s", _loc_5.q_max_hp);
                    _loc_4++;
                }
                if (_loc_5.q_max_mp)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11837")).replace("%s", _loc_5.q_max_mp);
                    _loc_4++;
                }
                if (_loc_5.q_attackspeed)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11838")).replace("%s", _loc_5.q_attackspeed);
                    _loc_4++;
                }
                if (_loc_5.q_speed)
                {
                    _loc_3 = _loc_3 + _loc_7.replace("%c", LanguageCfgObj.getInstance().getByIndex("11839")).replace("%s", _loc_5.q_speed);
                    _loc_4++;
                }
            }
            this._addAttTxt.htmlText = _loc_3;
            this._addAttTxt.height = this._addAttTxt.textHeight + 4;
            if (_loc_3 != "")
            {
                this._addAttTxt.x = 0;
                addChild(this._addAttTxt);
                param2.add(this);
                addGapPoint(this._addAttTxt.y, _loc_4);
                addGapLine(this._addAttTxt.y + this._addAttTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

        public function repaintAddAttributeCount(param1:HBox) : void
        {
            var _loc_2:* = LanguageCfgObj.getInstance().getByIndex("10171");
            this._addAttTxt.htmlText = _loc_2;
            this._addAttTxt.height = this._addAttTxt.textHeight + 4;
            if (_loc_2 != "")
            {
                addChild(this._addAttTxt);
                param1.add(this);
                addGapPoint(this._addAttTxt.y);
                addGapLine(this._addAttTxt.y + this._addAttTxt.height);
            }
            else
            {
                param1.remove(this);
            }
            return;
        }// end function

    }
}
