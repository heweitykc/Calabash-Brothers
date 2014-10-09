package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VIPCaptionPanel extends BaseBox
    {
        private var _bg:Sprite;
        private var _text:TextField;
        private var _btn:BaseButton;
        private var _closeBtn:BaseButton;

        public function VIPCaptionPanel(param1:String = "vipcaptionpanel")
        {
            super(param1);
            _combinedBox = ["com.game.vip.view::VIPPanel"];
            this.initUI();
            this.addlistener();
            return;
        }// end function

        private function initUI() : void
        {
            this._text = getDisplayChildByName("txt");
            this._btn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._btn.setText(LanguageCfgObj.getInstance().getByIndex("11404"));
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._text.htmlText = VIPShowCfgObj.getInstance().getProfession(10);
            return;
        }// end function

        private function __confirmClick(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        private function addlistener() : void
        {
            this._btn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__confirmClick);
            return;
        }// end function

    }
}
