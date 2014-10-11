package com.game.country.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.country.control.*;
    import flash.events.*;
    import flash.text.*;

    public class BannerBox extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var txt_playerName:TextField;
        private var yes_btn:BaseButton;

        public function BannerBox()
        {
            loadDisplay("res/countrybanner.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("bannerBox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_playerName = getDisplayChildByName("txt_playerName");
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 5, 5);
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.yes_btn:
                {
                    _loc_2 = this.txt_playerName.text;
                    if (!_loc_2)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10560"));
                        return;
                    }
                    CountryControl.getInstance().reqCJinYan(_loc_2);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
