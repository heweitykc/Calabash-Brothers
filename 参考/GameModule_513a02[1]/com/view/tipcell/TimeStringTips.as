package com.view.tipcell
{
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import com.manager.cd.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TimeStringTips extends BaseTips
    {
        private var txt:TextField;
        private var _backImg:Sprite;
        private var _content:Sprite;
        private var _info:CdTipsInfo;
        private var _times:int;
        private var isEnd:Boolean = false;

        public function TimeStringTips()
        {
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this.txt = new TextField();
            var _loc_1:* = 5;
            this.txt.y = 5;
            this.txt.x = _loc_1;
            this.txt.mouseEnabled = false;
            this.txt.autoSize = TextFieldAutoSize.LEFT;
            this.txt.multiline = true;
            this.txt.defaultTextFormat = new TextFormat("SimSun", 12, 16777215, null, null, null, null, null, null, null, null, null, 5);
            this._content.addChild(this.txt);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            this._info = param1 as CdTipsInfo;
            if (this._info)
            {
                this.doShow();
                this._times = Math.ceil(this._info.endTime - ToolKit.getServerTime()) * 0.001 + 1;
                if (this._times > 0)
                {
                    Ticker.registerTimer(1, this.doShow, this.doComplete);
                }
                else
                {
                    this.doShow();
                }
                addEvtListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            }
            return;
        }// end function

        private function __removeFromStage(event:Event) : void
        {
            Ticker.killTimer(this.doShow);
            return;
        }// end function

        private function doComplete(event:TimerManagerEvent = null) : void
        {
            Ticker.killTimer(this.doShow);
            this.txt.htmlText = this._info.endTemplate;
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 34 + this._content.height;
            return;
        }// end function

        private function doShow(event:TimerManagerEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this._info)
            {
                _loc_2 = CDManager.getInstance().getCD(CDTypes.BACKPACK_OPEN);
                _loc_3 = _loc_2[0] * 0.001 + 1;
                if (_loc_3 < 0)
                {
                    _loc_3 = 0;
                }
                _loc_4 = ToolKit.second2TimeStr(_loc_3);
                if (_loc_3 == 0 || this.isEnd)
                {
                    _loc_4 = this._info.endTemplate ? (this._info.endTemplate) : (this._info.template);
                    Ticker.killTimer(this.doShow);
                    this.isEnd = true;
                }
                else
                {
                    _loc_4 = this._info.template.replace("%s", _loc_4);
                    if (_loc_3 == 1)
                    {
                        this.isEnd = true;
                    }
                }
                this.txt.htmlText = _loc_4;
                this._backImg.width = 32 + this._content.width;
                this._backImg.height = 34 + this._content.height;
            }
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            Ticker.killTimer(this.doShow);
            return;
        }// end function

    }
}
