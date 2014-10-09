package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;

    public class WarTimePanel extends Component
    {
        private var _timeCount:int;
        private var titleView:MovieClip;
        private var day1:MovieClip;
        private var day0:MovieClip;
        private var hour1:MovieClip;
        private var hour0:MovieClip;
        private var minute1:MovieClip;
        private var minute0:MovieClip;
        private var second1:MovieClip;
        private var second0:MovieClip;

        public function WarTimePanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.titleView = getDisplayChildByName("titleView");
            this.titleView.stop();
            this.day1 = getDisplayChildByName("day1");
            this.day1.gotoAndStop(1);
            this.day0 = getDisplayChildByName("day0");
            this.day0.gotoAndStop(1);
            this.hour1 = getDisplayChildByName("hour1");
            this.hour1.gotoAndStop(1);
            this.hour0 = getDisplayChildByName("hour0");
            this.hour0.gotoAndStop(1);
            this.minute1 = getDisplayChildByName("minute1");
            this.minute1.gotoAndStop(1);
            this.minute0 = getDisplayChildByName("minute0");
            this.minute0.gotoAndStop(1);
            this.second1 = getDisplayChildByName("second1");
            this.second1.gotoAndStop(1);
            this.second0 = getDisplayChildByName("second0");
            this.second0.gotoAndStop(1);
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            Ticker.killTimer(this.updateCountTime);
            if (param1 == NewActivityConfig.ACTID_WAR2_MERGE)
            {
                this.titleView.gotoAndStop(1);
            }
            else if (param1 == NewActivityConfig.ACTID_WAR4_MERGE)
            {
                this.titleView.gotoAndStop(2);
            }
            else
            {
                this.titleView.gotoAndStop(1);
            }
            this._timeCount = param2.endTime - ToolKit.getServerTime() / 1000;
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
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 3600 * 24;
            var _loc_6:* = this._timeCount;
            _loc_1 = this._timeCount / _loc_5;
            _loc_6 = this._timeCount % _loc_5;
            _loc_2 = _loc_6 / 3600;
            _loc_6 = _loc_6 % 3600;
            _loc_3 = _loc_6 / 60;
            _loc_6 = _loc_6 % 60;
            _loc_4 = _loc_6;
            this.updateMc(_loc_1, [this.day0, this.day1]);
            this.updateMc(_loc_2, [this.hour0, this.hour1]);
            this.updateMc(_loc_3, [this.minute0, this.minute1]);
            this.updateMc(_loc_4, [this.second0, this.second1]);
            return;
        }// end function

        private function updateMc(param1:int, param2:Array) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < 2)
            {
                
                _loc_4 = param1 % 10;
                _loc_5 = param2[_loc_3];
                _loc_5.gotoAndStop((_loc_4 + 1));
                param1 = param1 / 10;
                _loc_3++;
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            Ticker.killTimer(this.updateCountTime);
            return;
        }// end function

    }
}
