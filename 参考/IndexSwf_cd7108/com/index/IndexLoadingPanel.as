package com.index
{
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class IndexLoadingPanel extends Component
    {
        private var progressBar:LoadStripe;
        private var cueTxt:TextField;
        private var _reloadTxt:Sprite;
        private var _tips:Tips;
        private var _img:Image;

        public function IndexLoadingPanel()
        {
            setWH(1200, 620);
            loadDisplay("res/loading.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("fileLoadMC");
            layoutMC(display, Layout.BOTTOM_CENTER);
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.progressBar = new LoadStripe("load_move_sp", getDisplayChildByName("bar1"));
            this.progressBar.setValue(0, 0);
            this.cueTxt = TextField(getDisplayChildByName("statTxt"));
            this._reloadTxt = getDisplayChildByName("reloadTxt");
            this._reloadTxt.buttonMode = true;
            this._reloadTxt.addEventListener(MouseEvent.CLICK, this.onLinkHandler, false, 0, true);
            return;
        }// end function

        public function setValueAll(param1:uint, param2:uint) : void
        {
            this.progressBar.setValue(param1, param2);
            this.progressBar.setTxt(param1 + "/" + param2);
            return;
        }// end function

        public function setBgMsg(param1:String) : void
        {
            this.cueTxt.htmlText = param1;
            return;
        }// end function

        public function getBgMsg() : String
        {
            return this.cueTxt.text;
        }// end function

        private function onLinkHandler(event:MouseEvent) : void
        {
            JSTools.reload();
            return;
        }// end function

    }
}
