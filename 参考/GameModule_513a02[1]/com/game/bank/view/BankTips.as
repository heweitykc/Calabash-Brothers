package com.game.bank.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.bank.control.*;
    import com.game.guide.control.*;
    import com.greensock.*;
    import flash.events.*;

    public class BankTips extends Component
    {
        private var closeBtn:BaseButton;
        private var ok_btn:BaseButton;

        public function BankTips()
        {
            loadDisplay("res/banktips.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("banktipsbox");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.ok_btn = new BaseButton(getDisplayChildByName("ok_btn"));
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.open();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            this.close();
            return;
        }// end function

        private function addEvents() : void
        {
            this.ok_btn.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        public function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.ok_btn:
                {
                    ButtonFlickerControl.getInstance().removeButtonFlicker(this.ok_btn);
                    BankControl.getInstance().openBankBox(2);
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

        public function open() : void
        {
            if (!UILoaded)
            {
                return;
            }
            Global.popManager.addUI(this, new LayoutInfo(Layout.BOTTOM_RIGHT, 0, -this.height));
            if (this.parent)
            {
                this.parent.addChildAt(this, (parent.numChildren - 1));
            }
            TweenLite.to(this, 0.5, {y:y - height - 30});
            ButtonFlickerControl.getInstance().addButtonFlicker(this.ok_btn);
            return;
        }// end function

        private function onCompleteFun() : void
        {
            return;
        }// end function

        public function close() : void
        {
            Global.popManager.removeUI(this);
            return;
        }// end function

    }
}
