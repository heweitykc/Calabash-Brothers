package com.game.zones.view.bosshome
{
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.player.control.*;
    import com.staticdata.*;
    import flash.events.*;

    public class BossHomeDefeatPanel extends BaseBox
    {
        private var _btnSure:BaseButton;
        private var _btnClose:BaseButton;

        public function BossHomeDefeatPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay("res/bosshomedefeat.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("bosshomedefeat");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnSure = new BaseButton(getDisplayChildByName("btn_sure"));
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
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
                case this._btnSure:
                {
                    this.close();
                    break;
                }
                case this._btnClose:
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

        override public function close() : void
        {
            super.close();
            PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
            return;
        }// end function

    }
}
