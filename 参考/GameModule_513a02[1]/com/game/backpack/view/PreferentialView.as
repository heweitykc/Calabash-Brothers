package com.game.backpack.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.backpack.view.itemrenderers.*;
    import flash.text.*;

    public class PreferentialView extends Component
    {
        private var _preferentialItem1:PreferentialItem;
        private var _preferentialItem2:PreferentialItem;
        private var _lastTimeTxt:TextField;
        private var _moreBtn:BaseButton;

        public function PreferentialView(param1 = null, param2:String = null)
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
            this._preferentialItem1 = new PreferentialItem(getDisplayChildByName("sp_item1"));
            this._preferentialItem2 = new PreferentialItem(getDisplayChildByName("sp_item2"));
            this._lastTimeTxt = getDisplayChildByName("txt_lastTime");
            this._moreBtn = new BaseButton(getDisplayChildByName("btn_more"));
            this._moreBtn.setText(LanguageCfgObj.getInstance().getByIndex("10368"));
            return;
        }// end function

    }
}
