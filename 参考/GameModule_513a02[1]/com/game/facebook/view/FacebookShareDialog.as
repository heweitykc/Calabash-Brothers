package com.game.facebook.view
{
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.facebook.locale.*;
    import com.util.*;
    import flash.events.*;

    public class FacebookShareDialog extends BaseBox
    {
        private var btnOk:BaseButton;
        private var btnCancel:BaseButton;
        private var okCallback:Function;

        public function FacebookShareDialog()
        {
            loadDisplay("res/facebookSharePanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("facebookShareDialog");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnOk = UiUtil.createButton(this, "btnOk", this.onOk);
            this.btnOk.setText(FacebookText.btnShareAndGain);
            this.btnCancel = UiUtil.createButton(this, "btnCancel", this.onCancel);
            this.btnCancel.setText(LanguageCfgObj.getInstance().getByIndex("10005"));
            return;
        }// end function

        public function show(param1:Function) : void
        {
            this.okCallback = param1;
            open();
            return;
        }// end function

        private function onOk(event:MouseEvent) : void
        {
            var _loc_2:* = this.okCallback;
            this.close();
            if (_loc_2 != null)
            {
                this._loc_2();
            }
            return;
        }// end function

        private function onCancel(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            this.okCallback = null;
            super.close();
            return;
        }// end function

    }
}
