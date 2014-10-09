package com.f1.utils.cue
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class ScrollSystemItem extends BaseSprite
    {
        private var _htmlText:String = "";
        private var _backCont:Sprite;
        private var _back:Sprite;
        private var _text:TextField;
        private var _sign:Sprite;
        private var _type:String = "system_notice";

        public function ScrollSystemItem()
        {
            this._backCont = new Sprite();
            this.initText();
            this.addChild(this._backCont);
            this.addChild(this._text);
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            if (this._back && this._back.parent)
            {
                this._back.parent.removeChild(this._back);
            }
            if (this._sign && this._sign.parent)
            {
                this._sign.parent.removeChild(this._sign);
                this._sign = null;
            }
            if (this.type == ScrollSystemCue.FIGHT_NOTICE)
            {
                this._back = this.drawBack();
            }
            else if (this.type == ScrollSystemCue.SYSTEM_NOTICE)
            {
                this._back = ToolKit.getNew("system_hit_back");
                this._sign = ToolKit.getNew("system_hit_sign");
            }
            else if (this.type == ScrollSystemCue.MOUSE_RESPOND)
            {
                this._back = new Sprite();
            }
            this._backCont.addChild(this._back);
            if (this._sign)
            {
                this._backCont.addChild(this._sign);
                this._sign.x = 15;
                this._sign.y = 8;
            }
            return;
        }// end function

        private function drawBack() : Sprite
        {
            var _loc_1:* = new Sprite();
            _loc_1.graphics.beginFill(2236962, 0);
            _loc_1.graphics.drawRect(0, 0, 50, 22);
            _loc_1.graphics.endFill();
            return _loc_1;
        }// end function

        private function initText() : void
        {
            var _loc_1:* = new TextFormat();
            _loc_1.align = TextFormatAlign.CENTER;
            _loc_1.font = "宋体";
            _loc_1.bold = true;
            _loc_1.color = 49408;
            _loc_1.size = 20;
            var _loc_2:* = new GlowFilter(13056, 1, 2, 2, 100, BitmapFilterQuality.LOW);
            var _loc_3:* = new DropShadowFilter(13056, 0, 0, 1, 2, 2, 50, BitmapFilterQuality.LOW);
            this._text = new TextField();
            this._text.defaultTextFormat = _loc_1;
            this._text.filters = [_loc_2];
            this._text.mouseEnabled = false;
            this._text.mouseWheelEnabled = false;
            this._text.cacheAsBitmap = true;
            this._text.height = 30;
            this._text.autoSize = TextFieldAutoSize.LEFT;
            this._text.selectable = false;
            this._text.multiline = false;
            this._text.wordWrap = false;
            this._text.y = 7;
            return;
        }// end function

        public function get htmlText() : String
        {
            return this._htmlText;
        }// end function

        public function set htmlText(param1:String) : void
        {
            this._htmlText = "<font size = \'14\'>" + param1 + "</font>";
            this.setText();
            return;
        }// end function

        private function setText() : void
        {
            this._text.htmlText = this._htmlText;
            if (this.type == ScrollSystemCue.SYSTEM_NOTICE)
            {
                this._back.width = this._text.textWidth + 65;
                this._text.x = 40;
            }
            else
            {
                this._text.x = 15;
                this._back.width = this._text.textWidth + 30;
            }
            return;
        }// end function

    }
}
