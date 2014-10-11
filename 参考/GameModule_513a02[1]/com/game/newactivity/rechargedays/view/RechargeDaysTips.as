package com.game.newactivity.rechargedays.view
{
    import com.f1.utils.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class RechargeDaysTips extends BaseTips
    {
        private var _titleTxt:TextField;
        private var _contentTxt:TextField;
        private var _content:Sprite;
        private var _backImg:Sprite;
        private var _lines:Array;
        private var _txtWidth:int = 300;
        private var _gap:int = 8;
        private var _content1:TextField;
        private var _content2:TextField;
        private var _content3:TextField;
        private var _content4:TextField;

        public function RechargeDaysTips()
        {
            this._lines = [];
            this._backImg = ToolKit.getNew("generalHoverWndBg");
            addChild(this._backImg);
            this._content = new Sprite();
            this._content.x = 16;
            this._content.y = 12;
            addChild(this._content);
            this._titleTxt = ToolKit.createText(14, this._txtWidth, 0, 16766079, false, false);
            this._contentTxt = ToolKit.createText(12, this._txtWidth);
            this._content.addChild(this._titleTxt);
            this._content1 = ToolKit.createText(12, this._txtWidth);
            this._content2 = ToolKit.createText(12, this._txtWidth, 0, 16773836);
            this._content3 = ToolKit.createText(12, this._txtWidth, 0, 16773836);
            this._content4 = ToolKit.createText(12, this._txtWidth, 0, 16773836);
            this._content.addChild(this._content1);
            this._content.addChild(this._content2);
            this._content.addChild(this._content3);
            this._content.addChild(this._content4);
            return;
        }// end function

        override public function repaint(param1:Object) : void
        {
            var _loc_2:* = null;
            this._titleTxt.htmlText = param1.title;
            this._titleTxt.height = this._titleTxt.textHeight + 4;
            _loc_2 = ToolKit.getNewDO("excisionLine") as Bitmap;
            _loc_2.x = 10;
            _loc_2.y = this._titleTxt.y + this._titleTxt.height + this._gap - 4;
            this._content.addChild(_loc_2);
            this._content1.y = _loc_2.y + _loc_2.height + this._gap;
            this._content1.htmlText = param1.content1;
            this._content1.height = this._content1.textHeight + 4;
            this._content2.y = this._content1.y + this._content1.height + 5;
            this._content2.htmlText = param1.content2;
            this._content2.height = this._content2.textHeight + 4;
            this._content3.y = this._content2.y + this._content2.height + 3;
            this._content3.htmlText = param1.content3;
            this._content3.height = this._content3.textHeight + 4;
            this._content4.y = this._content3.y + this._content3.height + 3;
            this._content4.htmlText = param1.content4;
            this._content4.height = this._content4.textHeight + 4;
            this._backImg.width = 32 + this._content.width;
            this._backImg.height = 24 + this._content.height;
            addEventListener(Event.REMOVED_FROM_STAGE, this.removeFromStage);
            return;
        }// end function

        private function removeFromStage(event:Event) : void
        {
            this.remove();
            return;
        }// end function

        override public function remove() : void
        {
            this._lines.splice(0);
            return;
        }// end function

    }
}
