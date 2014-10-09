package com.view.tipcell.equip
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.model.vo.*;
    import flash.text.*;

    public class DropItem extends BaseItem
    {
        private var _dropTxt:TextField;

        public function DropItem()
        {
            this._dropTxt = new TextField();
            this._dropTxt.autoSize = "left";
            this._dropTxt.defaultTextFormat = _textFormat;
            this._dropTxt.textColor = 16711680;
            addChild(this._dropTxt);
            return;
        }// end function

        public function repaintDrop(param1:EquipmentInfo, param2:HBox) : void
        {
            var _loc_3:* = "";
            if (!param1.q_drop)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10173");
                if (!param1.q_sell)
                {
                    _loc_3 = _loc_3 + ("/" + LanguageCfgObj.getInstance().getByIndex("10145"));
                }
            }
            else
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10174");
            }
            if (!param1.q_save_warehouse)
            {
                _loc_3 = _loc_3 + ("<br>" + LanguageCfgObj.getInstance().getByIndex("11816"));
            }
            this._dropTxt.htmlText = _loc_3;
            if (param1.q_sell && param1.q_drop && param1.q_save_warehouse)
            {
                param2.remove(this);
            }
            else
            {
                addGapLine(this._dropTxt.y + this._dropTxt.height);
                param2.add(this);
            }
            return;
        }// end function

    }
}
