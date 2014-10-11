package com.game.operationpanel.view
{
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.staticdata.*;
    import flash.events.*;

    public class LoadWeiDuanPanel extends BaseBox
    {
        private var _btnClose:BaseButton;
        private var _loadBtn:BaseButton;
        private static var swf:String = "res/weiduan.swf";

        public function LoadWeiDuanPanel()
        {
            loadDisplay(swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("weiduan_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("closeBtn"));
            this._loadBtn = new BaseButton(getDisplayChildByName("loadBtn"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._loadBtn:
                {
                    JSTools.openWindow("http://" + Params.wdUrl);
                    this.close();
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
