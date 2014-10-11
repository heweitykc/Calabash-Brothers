package com.game.zones.view.base
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.staticdata.*;
    import flash.events.*;

    public class ZonesBaseWelcome extends Component
    {
        private var _btnJoin:BaseButton;
        private var _btnclose:BaseButton;

        public function ZonesBaseWelcome()
        {
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnJoin = new BaseButton(getDisplayChildByName("btn_join"));
            this._btnclose = new BaseButton(getDisplayChildByName("btn_close"));
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnJoin:
                {
                    this.clickJoin();
                    break;
                }
                case this._btnclose:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function clickJoin() : void
        {
            this.close();
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT_CENTER, 240, 0), GroupPanelType.GROUP_LOW);
            return;
        }// end function

    }
}
