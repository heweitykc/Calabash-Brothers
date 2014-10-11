package com.game.zones.view.wolfsoul
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.guide.control.*;
    import com.game.prompt.control.*;
    import com.model.vo.*;
    import flash.text.*;

    public class ZonesWolfSoulSpecialView extends Component
    {
        private var countTxt:TextField;
        private var eventTxt:TextField;
        private var count:int;
        private var buffId:int;

        public function ZonesWolfSoulSpecialView()
        {
            super(null, null);
            loadDisplay("res/wolfsoulspecial.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("wolfsoul_special");
            this.initUI();
            super.displayReady();
            this.setBuff(this.buffId, false);
            return;
        }// end function

        private function initUI() : void
        {
            this.countTxt = getDisplayChildByName("count");
            this.eventTxt = getDisplayChildByName("event");
            return;
        }// end function

        public function setCountDown(param1:int) : void
        {
            if (param1 < 0)
            {
                param1 = 0;
            }
            this.count = param1;
            var _loc_2:* = Math.ceil(ToolKit.getServerTime() * 0.001);
            param1 = this.count - _loc_2;
            param1 = param1 >= 0 ? (param1) : (0);
            this.setCountTxt(param1);
            Ticker.killTimer(this.countDown);
            Ticker.registerTimer(1, this.countDown);
            return;
        }// end function

        private function countDown() : void
        {
            var _loc_1:* = Math.ceil(ToolKit.getServerTime() * 0.001);
            var _loc_2:* = this.count - _loc_1;
            if (_loc_2 <= 10)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this);
            }
            else
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this);
            }
            if (_loc_2 == 0)
            {
                Ticker.killTimer(this.countDown);
            }
            this.setCountTxt(_loc_2);
            return;
        }// end function

        private function setCountTxt(param1:int) : void
        {
            if (UILoaded)
            {
                this.countTxt.text = ToolKit.second2TimeStr(param1, "ms");
            }
            return;
        }// end function

        public function setBuff(param1:int, param2:Boolean = true) : void
        {
            this.buffId = param1;
            var _loc_3:* = BuffCfgObj.getInstance().getBuffInfo(this.buffId);
            if (_loc_3 && param2)
            {
                PromptControl.getInstance().addedToBroadcastMarquee(LanguageCfgObj.getInstance().getByIndex("12352") + _loc_3.q_buff_name);
            }
            if (UILoaded)
            {
                if (_loc_3)
                {
                    this.eventTxt.htmlText = _loc_3.q_buff_name;
                }
                else
                {
                    this.eventTxt.text = "";
                }
            }
            return;
        }// end function

        public function open() : void
        {
            x = 700;
            y = 30;
            Global.mainUIManager.addUI(this, null);
            return;
        }// end function

        public function close() : void
        {
            if (this.parent)
            {
                parent.removeChild(this);
            }
            this.buffId = 0;
            return;
        }// end function

    }
}
