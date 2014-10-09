package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.text.*;

    public class BigGiftPanel extends Component
    {
        private var _timeCount:int;
        private var restTime:TextField;
        private var _rewardItem:BigGiftRewardItem;

        public function BigGiftPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.restTime = getDisplayChildByName("restTime");
            this._rewardItem = new BigGiftRewardItem(getDisplayChildByName("item_1"));
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            Ticker.killTimer(this.updateCountTime);
            this._rewardItem.setInfo(param1, param2);
            this._timeCount = Math.ceil(param2.endTime - ToolKit.getServerTime() / 1000);
            this.updateCountText();
            if (this._timeCount > 0)
            {
                Ticker.registerTimer(1, this.updateCountTime, null, this._timeCount);
            }
            return;
        }// end function

        private function updateCountTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._timeCount - 1;
            _loc_1._timeCount = _loc_2;
            this.updateCountText();
            return;
        }// end function

        private function updateCountText() : void
        {
            if (this._timeCount > 0)
            {
                this.restTime.text = "" + ToolKit.second2CountDown(this._timeCount);
            }
            else
            {
                this.restTime.text = "" + LanguageCfgObj.getInstance().getByIndex("12429");
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            Ticker.killTimer(this.updateCountTime);
            this._rewardItem.clearInfo();
            return;
        }// end function

    }
}
