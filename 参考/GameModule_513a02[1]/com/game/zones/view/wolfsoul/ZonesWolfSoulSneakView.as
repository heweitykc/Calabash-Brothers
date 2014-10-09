package com.game.zones.view.wolfsoul
{
    import com.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;

    public class ZonesWolfSoulSneakView extends Component
    {
        private var countView:MovieClip;
        private var text:TextField;
        private var filter:GlowFilter;
        private const STRENARR:Array;
        private var strenIndex:int;
        private var count:int;

        public function ZonesWolfSoulSneakView()
        {
            this.STRENARR = [15, 3];
            super(null, null);
            this.filter = new GlowFilter(16711680, 1, 15, 15, 3);
            loadDisplay("res/zonetasktrace.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("wolfsoulsneak");
            this.countView = display as MovieClip;
            var _loc_1:* = false;
            this.countView.mouseEnabled = false;
            this.countView.mouseChildren = _loc_1;
            this.text = this.countView["txt"];
            super.displayReady();
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 120));
            this.setAuto(true);
            return;
        }// end function

        public function setCountDown(param1:int) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            this.count = param1;
            this.setCountTxt(this.count);
            Ticker.killTimer(this.countDown);
            Ticker.registerTimer(1, this.countDown);
            return;
        }// end function

        private function countDown() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.count - 1;
            _loc_1.count = _loc_2;
            this.setCountTxt(this.count);
            if (this.count == 0)
            {
                Ticker.killTimer(this.countDown);
                this.close();
            }
            return;
        }// end function

        private function setCountTxt(param1:int) : void
        {
            if (UILoaded)
            {
                this.text.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12351"), [param1]);
            }
            return;
        }// end function

        public function close() : void
        {
            if (this.parent)
            {
                this.setAuto(false);
                if (this.countView)
                {
                    this.countView.stop();
                }
                parent.removeChild(this);
            }
            return;
        }// end function

        private function setAuto(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            if (UILoaded)
            {
                if (this.strenIndex == 0)
                {
                    this.filter.blurX = this.filter.blurX - 0.4;
                    this.filter.blurY = this.filter.blurY - 0.4;
                    if (this.filter.blurX <= 3)
                    {
                        var _loc_2:* = 3;
                        this.filter.blurY = 3;
                        this.filter.blurX = _loc_2;
                        this.strenIndex = 1;
                    }
                }
                else
                {
                    this.filter.blurX = this.filter.blurX + 0.4;
                    this.filter.blurY = this.filter.blurY + 0.4;
                    if (this.filter.blurX >= 15)
                    {
                        var _loc_2:* = 15;
                        this.filter.blurY = 15;
                        this.filter.blurX = _loc_2;
                        this.strenIndex = 0;
                    }
                }
                this.text.filters = [this.filter];
            }
            return;
        }// end function

    }
}
