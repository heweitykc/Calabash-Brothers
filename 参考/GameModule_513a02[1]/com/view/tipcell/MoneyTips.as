package com.view.tipcell
{
    import com.f1.*;
    import com.model.vo.*;

    public class MoneyTips extends CurrencyTips
    {
        private var data:MoneyInfo;

        public function MoneyTips()
        {
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            this.data = param1 as MoneyInfo;
            _image.load(this.data.url);
            _nameTxt.text = this.data.name;
            _countTxt.text = LanguageCfgObj.getInstance().getByIndex("11788") + param1.num;
            _backImg.width = 32 + _content.width;
            _backImg.height = 34 + _content.height;
            return;
        }// end function

    }
}
