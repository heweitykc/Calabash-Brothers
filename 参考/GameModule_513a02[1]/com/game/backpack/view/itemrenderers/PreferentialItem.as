package com.game.backpack.view.itemrenderers
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import flash.text.*;

    public class PreferentialItem extends Component
    {
        private var _nameTxt:TextField;
        private var _tipsTxt:TextField;
        private var _costTxt:TextField;
        private var _buyBtn:BaseButton;

        public function PreferentialItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            return;
        }// end function

        override protected function initComponentUI(param1, param2 = null) : void
        {
            super.initComponentUI(param1, param2);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._nameTxt = getDisplayChildByName("txt_itemName");
            this._tipsTxt = getDisplayChildByName("txt_tips");
            this._costTxt = getDisplayChildByName("txt_cost");
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10373"));
            return;
        }// end function

    }
}
