package com.game.zones.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.game.guide.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.zones.control.*;
    import flash.events.*;

    public class ZonesTopIconPanel extends Component
    {
        private var _iconZonesQuit:TopActivateIcon;

        public function ZonesTopIconPanel()
        {
            this.initUI();
            this.addEvents();
            return;
        }// end function

        private function initUI() : void
        {
            this._iconZonesQuit = new TopActivateIcon("top_icon_zones_quit");
            this.addChild(this._iconZonesQuit);
            this._iconZonesQuit.move(-this._iconZonesQuit.width, 0);
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
                case this._iconZonesQuit:
                {
                    this.clickQuit();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function clickQuit() : void
        {
            Global.popManager.cue(LanguageCfgObj.getInstance().getByIndex("12336"), LanguageCfgObj.getInstance().getByIndex("12335"), null, this.callQuitZones);
            return;
        }// end function

        private function callQuitZones() : void
        {
            ZonesControl.getInstance().reqZoneOut();
            return;
        }// end function

        public function addFilter() : void
        {
            ButtonFlickerControl.getInstance().addButtonFlicker(this._iconZonesQuit);
            return;
        }// end function

        public function removeFilter() : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._iconZonesQuit);
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 240, 15));
            return;
        }// end function

        public function close() : void
        {
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

    }
}
