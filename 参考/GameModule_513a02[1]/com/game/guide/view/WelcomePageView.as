package com.game.guide.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.clickstream.*;
    import com.game.guide.control.*;
    import com.game.task.*;
    import flash.events.*;

    public class WelcomePageView extends Component
    {
        private var _layout:LayoutInfo;
        private var btn:BaseButton;

        public function WelcomePageView()
        {
            setWH(554, 306);
            loadDisplay(WelcomePageControl.getInstance().RES_URL);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("welcome_page");
            this.initUI();
            super.displayReady();
            addEventListener(MouseEvent.CLICK, this.__clickHandler);
            GuideControl.getInstance().hideArrow();
            return;
        }// end function

        public function open() : void
        {
            if (!this._layout)
            {
                this._layout = new LayoutInfo(Layout.CENTER, 0, -80);
            }
            Global.mainUIManager.addUI(this, this._layout);
            return;
        }// end function

        public function close() : void
        {
            ClickStream.add(ClickStreamId.START_JOURNEY);
            Global.mainUIManager.removeUI(this);
            if (this.btn)
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.btn);
            }
            return;
        }// end function

        private function __clickHandler(event:MouseEvent) : void
        {
            if (TaskGlobal.task)
            {
                TaskGlobal.manager.continueTask(TaskGlobal.task);
            }
            this.close();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn = new BaseButton(getDisplayChildByName("okBtn"));
            ButtonFlickerControl.getInstance().addButtonFlicker(this.btn);
            return;
        }// end function

    }
}
