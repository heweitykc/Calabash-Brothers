package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.text.*;

    public class PreFightNumberItem extends BaseItem
    {
        private var _preFightNumberTxt:TextField;

        public function PreFightNumberItem()
        {
            this._preFightNumberTxt = new TextField();
            this._preFightNumberTxt.width = 232;
            _textFormat.align = TextFormatAlign.CENTER;
            this._preFightNumberTxt.defaultTextFormat = _textFormat;
            this._preFightNumberTxt.textColor = 16766079;
            addChild(this._preFightNumberTxt);
            return;
        }// end function

        public function repaintIntensify(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = null;
            if (param1.q_kind != Params.SHOW && param1.q_kind != Params.PET)
            {
                if (param1.intensify < 15)
                {
                    _loc_3 = param1.cloneEquip();
                    _loc_3.intensify = 15;
                    this._preFightNumberTxt.text = LanguageCfgObj.getInstance().getByIndex("11843") + _loc_3.fightNumber;
                    this._preFightNumberTxt.height = this._preFightNumberTxt.textHeight + 4;
                    if (param1.q_sell)
                    {
                        addGapLine(0);
                        this._preFightNumberTxt.y = 15;
                    }
                    else
                    {
                        this._preFightNumberTxt.y = 0;
                    }
                    param2.add(this);
                }
                else
                {
                    param2.remove(this);
                }
            }
            else
            {
                param2.remove(this);
            }
            return;
        }// end function

    }
}
