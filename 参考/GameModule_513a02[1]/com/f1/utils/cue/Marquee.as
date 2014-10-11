package com.f1.utils.cue
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class Marquee extends BaseSprite
    {
        private var marqueeTxt:TextField;
        private var marqueeBuffer:Array;
        private var SPEED:uint = 33;
        private var marqueeTxtBgMc:Sprite;
        private var marqueeMoving:Boolean = false;
        private var lastMar:int = 0;
        private static const MARQUEE_W:uint = 600;
        private static const MARQUEE_H:uint = 30;
        public static const FONT2:String = "宋体";

        public function Marquee()
        {
            this.initMarquee();
            return;
        }// end function

        private function initMarquee() : void
        {
            this.setWH(MARQUEE_W, MARQUEE_H);
            var _loc_3:* = false;
            this.mouseEnabled = false;
            this.mouseChildren = _loc_3;
            this.marqueeTxt = new TextField();
            this.marqueeTxt.y = 8;
            this.marqueeTxt.name = "marqueeTxt";
            this.marqueeTxt.mouseEnabled = false;
            this.marqueeTxt.mouseWheelEnabled = false;
            var _loc_1:* = new TextFormat();
            _loc_1.align = TextFormatAlign.LEFT;
            _loc_1.font = FONT2;
            _loc_1.bold = true;
            _loc_1.color = 49408;
            _loc_1.size = 12;
            this.marqueeTxt.defaultTextFormat = _loc_1;
            this.marqueeTxt.height = MARQUEE_H;
            this.marqueeTxt.autoSize = TextFieldAutoSize.LEFT;
            this.marqueeTxt.selectable = false;
            this.marqueeTxt.multiline = false;
            this.marqueeTxt.wordWrap = false;
            this.marqueeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            var _loc_2:* = new Shape();
            _loc_2.graphics.beginFill(0);
            _loc_2.graphics.drawRect(0, 0, MARQUEE_W, MARQUEE_H);
            _loc_2.filters = [new BlurFilter(50, 0)];
            this.addChild(this.marqueeTxt);
            this.addChild(_loc_2);
            this.marqueeTxt.mask = _loc_2;
            this.marqueeBuffer = [];
            this.marqueeStopMove();
            return;
        }// end function

        private function marqueeStopMove() : void
        {
            this.marqueeMoving = false;
            FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__moveMarquee, false);
            this.lastMar = -1;
            if (this.marqueeTxtBgMc)
            {
                if (this.marqueeBuffer.length <= 0)
                {
                    if (this.marqueeTxtBgMc.parent)
                    {
                        this.marqueeTxtBgMc.parent.removeChild(this.marqueeTxtBgMc);
                        this.marqueeTxtBgMc = null;
                    }
                }
            }
            return;
        }// end function

        private function __moveMarquee(event:Event = null) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            if (this.marqueeTxt.x < -this.marqueeTxt.width - 50)
            {
                this.marqueeStopMove();
                this.nextMarquee();
            }
            else
            {
                _loc_2 = 1;
                _loc_3 = getTimer();
                if (this.lastMar > 0)
                {
                    _loc_2 = (_loc_3 - this.lastMar) / this.SPEED;
                    this.lastMar = _loc_3;
                    if (_loc_2 > 1.2)
                    {
                        _loc_2 = Math.ceil(_loc_2);
                    }
                }
                this.marqueeTxt.x = this.marqueeTxt.x - 1 * _loc_2;
            }
            return;
        }// end function

        public function marquee(param1:String) : void
        {
            this.marqueeBuffer.push(param1);
            this.nextMarquee();
            return;
        }// end function

        private function nextMarquee() : void
        {
            var _loc_1:* = null;
            if (this.marqueeMoving)
            {
                return;
            }
            if (this.marqueeBuffer.length > 0)
            {
                _loc_1 = this.marqueeBuffer.shift();
                if (_loc_1)
                {
                    this.marqueeTxt.htmlText = _loc_1;
                    this.marqueeTxt.x = MARQUEE_W;
                    this.marqueeStartMove();
                }
            }
            return;
        }// end function

        private function marqueeStartMove() : void
        {
            this.marqueeMoving = true;
            FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.__moveMarquee, false);
            FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.__moveMarquee, false, 0, true);
            this.lastMar = getTimer();
            if (this.marqueeTxtBgMc == null)
            {
                this.marqueeTxtBgMc = ToolKit.getNew("mar_quee_romor_bg");
                var _loc_1:* = false;
                this.marqueeTxtBgMc.mouseEnabled = false;
                this.marqueeTxtBgMc.mouseChildren = _loc_1;
                this.marqueeTxtBgMc.height = 32;
                this.marqueeTxtBgMc.width = MARQUEE_W + 40;
                this.marqueeTxtBgMc.x = -20;
                this.addChildAt(this.marqueeTxtBgMc, 0);
            }
            return;
        }// end function

    }
}
