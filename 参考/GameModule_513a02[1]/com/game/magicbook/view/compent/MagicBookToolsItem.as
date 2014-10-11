package com.game.magicbook.view.compent
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.game.magicbook.bean.*;
    import com.game.magicbook.control.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.ui.list.*;
    import flash.events.*;
    import flash.text.*;

    public class MagicBookToolsItem extends ListItem
    {
        private var _useBtn:BaseButton;
        private var _toolNameTxt:TextField;
        private var _toolPropTxt:TextField;
        private var _toolValueTxt:TextField;
        private var _toolUseTxt:TextField;
        private var _toolIco:IconItem;

        public function MagicBookToolsItem(param1:String = "magicBook_toolItem", param2:String = "")
        {
            super(param1, param2);
            return;
        }// end function

        override protected function getComp() : void
        {
            this._useBtn = new BaseButton(_content.getChildByName("getBtn"));
            this._useBtn.setText(LanguageCfgObj.getInstance().getByIndex("10009", MagicBookControl.MAGICBOOK_LANG));
            this._toolNameTxt = _content.getChildByName("toolNameTxt") as TextField;
            this._toolPropTxt = _content.getChildByName("toolPropTxt") as TextField;
            this._toolValueTxt = _content.getChildByName("toolValueTxt") as TextField;
            this._toolUseTxt = _content.getChildByName("toolUseTxt") as TextField;
            this._toolIco = new IconItem("horseSkillBoxBack");
            this._useBtn.addEventListener(MouseEvent.CLICK, this.__useItem);
            this._toolIco.move(8, 7);
            this._toolIco.image.move(5, 5);
            addChild(this._toolIco);
            return;
        }// end function

        public function update(param1:MagicUseOnceInfo) : void
        {
            obj = param1;
            return;
        }// end function

        override protected function receive() : void
        {
            var _loc_1:* = obj;
            var _loc_2:* = PropUtil.createItemByCfg(_loc_1.itemId);
            this._toolIco.setInfo(_loc_2);
            this._toolNameTxt.text = _loc_2.q_name;
            this._toolValueTxt.text = "+" + this.getValueString(_loc_2, _loc_1.useOnceNum);
            this._toolUseTxt.text = "(" + _loc_1.useOnceNum + "/" + _loc_1.maxUseNum + ")";
            this._toolPropTxt.text = ItemEffictType.getTypeString(_loc_2.q_effict_type);
            return;
        }// end function

        private function __useItem(event:MouseEvent) : void
        {
            MagicBookControl.getIntance().reqUse(obj.itemId);
            return;
        }// end function

        private function getValueString(param1:PropInfo, param2:int) : String
        {
            if (param1.q_effict_type.search(ItemEffictType.MAGICBOOK_HEAT_DEEP) != -1 || param1.q_effict_type.search(ItemEffictType.MAGICBOOK_INORGE_INFENCE) != -1)
            {
                return param2 * param1.effictValues[0] / 100 + "%";
            }
            return param2 * param1.effictValues[0] + "";
        }// end function

        override public function finalize() : void
        {
            this._useBtn.removeEvtListener(MouseEvent.CLICK, this.__useItem);
            super.finalize();
            return;
        }// end function

    }
}
