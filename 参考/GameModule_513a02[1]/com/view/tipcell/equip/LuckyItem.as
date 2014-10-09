package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.text.*;

    public class LuckyItem extends BaseItem
    {
        private var _luckyTxt:TextField;

        public function LuckyItem()
        {
            this._luckyTxt = new TextField();
            this._luckyTxt.defaultTextFormat = _textFormat;
            this._luckyTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._luckyTxt.autoSize = TextFieldAutoSize.NONE;
            this._luckyTxt.multiline = true;
            this._luckyTxt.wordWrap = true;
            this._luckyTxt.width = 215;
            this._luckyTxt.mouseEnabled = false;
            this._luckyTxt.selectable = false;
            return;
        }// end function

        public function repaintLuck(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = "";
            if (param1.knowing_attackpercent)
            {
                _loc_3 = _loc_3 + ("<font color = \'#00c0ff\'>" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11841"), [param1.knowing_attackpercent * 0.01]) + "</font><br>");
            }
            this._luckyTxt.htmlText = _loc_3;
            this._luckyTxt.height = this._luckyTxt.textHeight + 4;
            if (_loc_3 != "")
            {
                this._luckyTxt.x = 0;
                addChild(this._luckyTxt);
                param2.add(this);
                addGapPoint(this._luckyTxt.y);
                addGapLine(this._luckyTxt.y + this._luckyTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

        public function repaintLuckCount(param1:HBox) : void
        {
            var _loc_2:* = "";
            _loc_2 = _loc_2 + (LanguageCfgObj.getInstance().getByIndex("11842") + "<br>");
            this._luckyTxt.htmlText = _loc_2;
            this._luckyTxt.height = this._luckyTxt.textHeight + 4;
            if (_loc_2 != "")
            {
                addChild(this._luckyTxt);
                param1.add(this);
                addGapPoint(this._luckyTxt.y);
                addGapLine(this._luckyTxt.y + this._luckyTxt.height);
            }
            else
            {
                param1.remove(this);
            }
            return;
        }// end function

    }
}
