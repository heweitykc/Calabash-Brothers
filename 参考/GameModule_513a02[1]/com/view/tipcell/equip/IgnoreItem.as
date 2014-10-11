package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.vo.*;
    import flash.text.*;

    public class IgnoreItem extends BaseItem
    {
        private var _ignoreTxt:TextField;

        public function IgnoreItem()
        {
            this._ignoreTxt = new TextField();
            this._ignoreTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._ignoreTxt.autoSize = TextFieldAutoSize.NONE;
            this._ignoreTxt.multiline = true;
            this._ignoreTxt.mouseEnabled = false;
            this._ignoreTxt.wordWrap = true;
            this._ignoreTxt.width = 215;
            this._ignoreTxt.defaultTextFormat = _textFormat;
            this._ignoreTxt.selectable = false;
            this._ignoreTxt.textColor = 49407;
            return;
        }// end function

        public function repaintIgnore(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = "";
            if (param1.ignore_attack_percent)
            {
                _loc_3 = _loc_3 + ("<font color = \'#00c0ff\'>" + LanguageCfgObj.getInstance().getByIndex("11840") + " +" + param1.ignore_attack_percent * 0.01 + "%</font><br>");
            }
            this._ignoreTxt.htmlText = _loc_3;
            this._ignoreTxt.height = this._ignoreTxt.textHeight + 4;
            if (_loc_3 != "")
            {
                this._ignoreTxt.x = 0;
                if (!this._ignoreTxt.parent)
                {
                    addChild(this._ignoreTxt);
                }
                param2.add(this);
                addGapPoint(this._ignoreTxt.y);
                addGapLine(this._ignoreTxt.y + this._ignoreTxt.height);
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
