package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.text.*;

    public class DoubleExpPanel extends Component
    {
        private var overTxt:TextField;
        private var bh1:MovieClip;
        private var bh0:MovieClip;
        private var bm1:MovieClip;
        private var bm0:MovieClip;
        private var eh1:MovieClip;
        private var eh0:MovieClip;
        private var em1:MovieClip;
        private var em0:MovieClip;

        public function DoubleExpPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.overTxt = getDisplayChildByName("overTxt");
            this.overTxt.visible = false;
            this.bh1 = getDisplayChildByName("bh1");
            this.bh1.gotoAndStop(1);
            this.bh0 = getDisplayChildByName("bh0");
            this.bh0.gotoAndStop(1);
            this.bm1 = getDisplayChildByName("bm1");
            this.bm1.gotoAndStop(1);
            this.bm0 = getDisplayChildByName("bm0");
            this.bm0.gotoAndStop(1);
            this.eh1 = getDisplayChildByName("eh1");
            this.eh1.gotoAndStop(1);
            this.eh0 = getDisplayChildByName("eh0");
            this.eh0.gotoAndStop(1);
            this.em1 = getDisplayChildByName("em1");
            this.em1.gotoAndStop(1);
            this.em0 = getDisplayChildByName("em0");
            this.em0.gotoAndStop(1);
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            this.overTxt.visible = param2.endTime < ToolKit.getServerTime() / 1000;
            if (param2.condDesc)
            {
                _loc_3 = param2.condDesc.split("-");
                _loc_4 = _loc_3[0];
                _loc_5 = _loc_4.split(":");
                this.formatTime(int(_loc_5[0]), int(_loc_5[1]), [this.bh1, this.bh0, this.bm1, this.bm0]);
                _loc_4 = _loc_3[1];
                _loc_5 = _loc_4.split(":");
                this.formatTime(int(_loc_5[0]), int(_loc_5[1]), [this.eh1, this.eh0, this.em1, this.em0]);
            }
            return;
        }// end function

        private function formatTime(param1:int, param2:int, param3:Array) : void
        {
            var _loc_11:* = null;
            var _loc_4:* = param1 / 10;
            var _loc_5:* = param1 % 10;
            var _loc_6:* = param2 / 10;
            var _loc_7:* = param2 % 10;
            var _loc_8:* = [_loc_4, _loc_5, _loc_6, _loc_7];
            var _loc_9:* = param3.length;
            var _loc_10:* = 0;
            while (_loc_10 < _loc_9)
            {
                
                _loc_11 = param3[_loc_10];
                _loc_11.gotoAndStop((_loc_8[_loc_10] + 1));
                _loc_10++;
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            return;
        }// end function

    }
}
