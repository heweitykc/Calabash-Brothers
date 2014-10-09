package com.riaidea.text
{
    import com.riaidea.text.plugins.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class RichTextField extends Sprite
    {
        private var _width:Number;
        private var _height:Number;
        private var _textRenderer:TextRenderer;
        private var _spriteRenderer:SpriteRenderer;
        private var _formatCalculator:TextField;
        private var _plugins:Array;
        private var _placeholder:String;
        private var _placeholderColor:uint;
        private var _placeholderMarginH:int;
        private var _placeholderMarginV:int;
        public var html:Boolean;
        public var lineHeight:int;
        public var autoScroll:Boolean;
        public static const DYNAMIC:String = "dynamic";
        public static const INPUT:String = "input";
        public static const version:String = "2.0.2";

        public function RichTextField()
        {
            this._textRenderer = new TextRenderer();
            addChild(this._textRenderer);
            this._spriteRenderer = new SpriteRenderer(this);
            addChild(this._spriteRenderer.container);
            this.setSize(100, 100);
            this.type = DYNAMIC;
            this.lineHeight = 0;
            this.html = false;
            this.autoScroll = false;
            this._placeholder = String.fromCharCode(12288);
            this._placeholderColor = 0;
            this._placeholderMarginH = 1;
            this._placeholderMarginV = 0;
            this._formatCalculator = new TextField();
            this._formatCalculator.text = this._placeholder;
            this._textRenderer.restrict = "^" + this._placeholder;
            return;
        }// end function

        public function append(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null) : void
        {
            var _loc_5:* = this._textRenderer.scrollV;
            var _loc_6:* = this._textRenderer.length;
            var _loc_7:* = 0;
            if (!param1)
            {
                param1 = "";
            }
            if (param1 || param3)
            {
                if (param1)
                {
                    param1 = param1.split("\r").join("\n");
                }
                if (param3 && !this.html)
                {
                    param1 = param1 + "\n";
                }
                this._textRenderer.recoverDefaultFormat();
                if (this.html)
                {
                    this._textRenderer.htmlText = this._textRenderer.htmlText + ("<p>" + param1 + "</p>");
                }
                else
                {
                    this._textRenderer.appendText(param1);
                    if (param4 == null)
                    {
                        param4 = this._textRenderer.defaultTextFormat;
                    }
                    this._textRenderer.setTextFormat(param4, _loc_6, this._textRenderer.length);
                }
                if (this.html || param3 && !this.html)
                {
                    _loc_7 = this._textRenderer.length - _loc_6 - 1;
                }
                else
                {
                    _loc_7 = this._textRenderer.length - _loc_6;
                }
            }
            var _loc_8:* = this.html && _loc_6 != 0;
            this.insertSprites(param2, _loc_6, _loc_6 + _loc_7, _loc_8);
            if (this.autoScroll && this._textRenderer.scrollV != this._textRenderer.maxScrollV)
            {
                this._textRenderer.scrollV = this._textRenderer.maxScrollV;
            }
            else if (!this.autoScroll && this._textRenderer.scrollV != _loc_5)
            {
                this._textRenderer.scrollV = _loc_5;
            }
            if (param2 != null)
            {
                this._spriteRenderer.render();
            }
            return;
        }// end function

        public function replace(param1:int, param2:int, param3:String, param4:Array = null) : void
        {
            var _loc_5:* = this._textRenderer.length;
            var _loc_6:* = 0;
            if (param2 > _loc_5)
            {
                param2 = _loc_5;
            }
            param3 = param3.split(this._placeholder).join("");
            this._textRenderer.replaceText(param1, param2, param3);
            _loc_6 = this._textRenderer.length - _loc_5 + (param2 - param1);
            if (_loc_6 > 0)
            {
                this._textRenderer.setTextFormat(this._textRenderer.defaultTextFormat, param1, param1 + _loc_6);
            }
            var _loc_7:* = param1;
            while (_loc_7 < param2)
            {
                
                this._spriteRenderer.removeSprite(_loc_7);
                _loc_7++;
            }
            var _loc_8:* = this._spriteRenderer.adjustSpritesIndex((param1 - 1), this._textRenderer.length - _loc_5);
            this.insertSprites(param4, param1, param1 + _loc_6);
            if (_loc_8 || param4 && param4.length > 0)
            {
                this._spriteRenderer.render();
            }
            return;
        }// end function

        private function insertSprites(param1:Array, param2:int, param3:int, param4:Boolean = false) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            if (param1 == null)
            {
                return;
            }
            param1.sortOn("index", Array.NUMERIC);
            var _loc_5:* = 0;
            while (_loc_5 < param1.length)
            {
                
                _loc_6 = param1[_loc_5];
                _loc_7 = _loc_6.src;
                _loc_8 = _loc_6.index;
                if (_loc_6.index == undefined || _loc_8 < 0 || (_loc_8 - 1) > param3 - param2)
                {
                    _loc_6.index = param3 - param2;
                    param1.splice(_loc_5, 1);
                    param1.push(_loc_6);
                    _loc_5 = _loc_5 - 1;
                }
                else
                {
                    if (param4 && _loc_8 > 0 && _loc_8 < param3 - param2)
                    {
                        _loc_8 = _loc_8 + (param2 + _loc_5);
                    }
                    else
                    {
                        _loc_8 = _loc_8 + (param2 + _loc_5);
                    }
                    this.insertSprite(_loc_7, _loc_8, false, _loc_6.cache);
                }
                _loc_5++;
            }
            return;
        }// end function

        public function insertSprite(param1:Object, param2:int = -1, param3:Boolean = true, param4:Boolean = false) : void
        {
            var _loc_7:* = NaN;
            var _loc_5:* = this.getSpriteFromObject(param1);
            if (this.getSpriteFromObject(param1) == null)
            {
                throw Error("Specific sprite:" + param1 + " is not a valid display object!");
            }
            if (param4)
            {
                _loc_5.cacheAsBitmap = true;
            }
            if (this.lineHeight > 0 && _loc_5.height > this.lineHeight)
            {
                _loc_7 = this.lineHeight / _loc_5.height;
                _loc_5.height = this.lineHeight;
                _loc_5.width = _loc_5.width * _loc_7;
            }
            if (param2 < 0 || param2 > this._textRenderer.length)
            {
                param2 = this._textRenderer.length;
            }
            this._textRenderer.replaceText(param2, param2, this._placeholder);
            var _loc_6:* = this.calcPlaceholderFormat(_loc_5.width, _loc_5.height);
            this._textRenderer.setTextFormat(_loc_6, param2, (param2 + 1));
            this._spriteRenderer.adjustSpritesIndex(param2, 1);
            this._spriteRenderer.insertSprite(_loc_5, param2);
            if (param3)
            {
                this._spriteRenderer.render();
            }
            return;
        }// end function

        private function getSpriteFromObject(param1:Object) : DisplayObject
        {
            var _loc_2:* = null;
            if (param1 is String)
            {
                _loc_2 = getDefinitionByName(String(param1)) as Class;
                return new _loc_2 as DisplayObject;
            }
            if (param1 is Class)
            {
                return new param1 as DisplayObject;
            }
            return param1 as DisplayObject;
        }// end function

        private function calcPlaceholderFormat(param1:Number, param2:Number) : TextFormat
        {
            var _loc_3:* = new TextFormat();
            _loc_3.color = this._placeholderColor;
            _loc_3.size = param2;
            this._formatCalculator.setTextFormat(_loc_3);
            var _loc_4:* = this._formatCalculator.getLineMetrics(0);
            _loc_3.letterSpacing = param1 - param2 + 2;
            var _loc_5:* = false;
            _loc_3.bold = false;
            _loc_3.italic = _loc_5;
            _loc_3.underline = _loc_5;
            return _loc_3;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            if (this._width == param1 && this._height == param2)
            {
                return;
            }
            this._width = param1;
            this._height = param2;
            this._textRenderer.width = this._width;
            this._textRenderer.height = this._height;
            this.scrollRect = new Rectangle(0, 0, this._width, this._height);
            this._spriteRenderer.render();
            return;
        }// end function

        public function updateWH(param1:Number, param2:Number) : void
        {
            this._width = param1;
            this._height = param2;
            this.scrollRect = new Rectangle(0, 0, this._width, this._height);
            this._spriteRenderer.render();
            return;
        }// end function

        public function isSpriteAt(param1:int) : Boolean
        {
            if (param1 < 0 || param1 >= this._textRenderer.length)
            {
                return false;
            }
            return this._textRenderer.text.charAt(param1) == this._placeholder;
        }// end function

        private function scrollHandler(event:Event) : void
        {
            this._spriteRenderer.render();
            return;
        }// end function

        private function changeHandler(event:Event) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = this._textRenderer.caretIndex;
            var _loc_3:* = this._textRenderer.length - this._textRenderer.oldLength;
            if (_loc_3 > 0)
            {
                this._spriteRenderer.adjustSpritesIndex((_loc_2 - 1), _loc_3);
            }
            else
            {
                _loc_4 = _loc_2;
                while (_loc_4 < _loc_2 - _loc_3)
                {
                    
                    this._spriteRenderer.removeSprite(_loc_4);
                    _loc_4++;
                }
                this._spriteRenderer.adjustSpritesIndex(_loc_2 + _loc_3, _loc_3);
            }
            this._spriteRenderer.render();
            return;
        }// end function

        public function clear() : void
        {
            this._spriteRenderer.clear();
            this._textRenderer.clear();
            return;
        }// end function

        public function get type() : String
        {
            return this._textRenderer.type;
        }// end function

        public function set type(param1:String) : void
        {
            this._textRenderer.type = param1;
            this._textRenderer.addEventListener(Event.SCROLL, this.scrollHandler);
            if (param1 == INPUT)
            {
                this._textRenderer.addEventListener(Event.CHANGE, this.changeHandler);
            }
            return;
        }// end function

        public function get textfield() : TextField
        {
            return this._textRenderer;
        }// end function

        public function set placeholderMarginH(param1:int) : void
        {
            this._placeholderMarginH = param1;
            return;
        }// end function

        public function set placeholderMarginV(param1:int) : void
        {
            this._placeholderMarginV = param1;
            return;
        }// end function

        public function get viewWidth() : Number
        {
            return this._width;
        }// end function

        override public function get height() : Number
        {
            return this._height;
        }// end function

        public function get viewHeight() : Number
        {
            return this._height;
        }// end function

        public function get content() : String
        {
            return this._textRenderer.text;
        }// end function

        public function get contentLength() : int
        {
            return this._textRenderer.length;
        }// end function

        public function get text() : String
        {
            return this._textRenderer.text.split(this._placeholder).join("");
        }// end function

        public function get textLength() : int
        {
            return this._textRenderer.length - this._spriteRenderer.numSprites;
        }// end function

        public function getSprite(param1:int) : DisplayObject
        {
            return this._spriteRenderer.getSprite(param1);
        }// end function

        public function get numSprites() : int
        {
            return this._spriteRenderer.numSprites;
        }// end function

        public function get caretIndex() : int
        {
            return this._textRenderer.caretIndex;
        }// end function

        public function set caretIndex(param1:int) : void
        {
            this._textRenderer.setSelection(param1, param1);
            return;
        }// end function

        public function get defaultTextFormat() : TextFormat
        {
            return this._textRenderer.defaultTextFormat;
        }// end function

        public function set defaultTextFormat(param1:TextFormat) : void
        {
            if (param1.color != null)
            {
                this._placeholderColor = uint(param1.color);
            }
            this._textRenderer.defaultTextFormat = param1;
            return;
        }// end function

        public function exportXML() : XML
        {
            var _loc_1:* = <rtf/>;
            if (this.html)
            {
                _loc_1.htmlText = this._textRenderer.htmlText.split(this._placeholder).join("");
            }
            else
            {
                _loc_1.text = this._textRenderer.text.split(this._placeholder).join("");
            }
            _loc_1.sprites = this._spriteRenderer.exportXML();
            return _loc_1;
        }// end function

        public function importXML(param1:XML) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = "";
            if (param1.hasOwnProperty("htmlText"))
            {
                _loc_2 = _loc_2 + param1.htmlText;
            }
            if (param1.hasOwnProperty("text"))
            {
                _loc_2 = _loc_2 + param1.text;
            }
            var _loc_3:* = [];
            var _loc_4:* = 0;
            while (_loc_4 < param1.sprites.sprite.length())
            {
                
                _loc_5 = param1.sprites.sprite[_loc_4];
                _loc_6 = {};
                _loc_6.src = String(_loc_5.@src);
                if (this.html)
                {
                    _loc_6.index = int(_loc_5.@index) + 1;
                }
                else
                {
                    _loc_6.index = int(_loc_5.@index);
                }
                _loc_3.push(_loc_6);
                _loc_4++;
            }
            this.append(_loc_2, _loc_3);
            return;
        }// end function

        public function addPlugin(param1:IRTFPlugin) : void
        {
            param1.setup(this);
            if (this._plugins == null)
            {
                this._plugins = [];
            }
            this._plugins.push(param1);
            return;
        }// end function

    }
}
