package com.riaidea.text
{
    import flash.events.*;
    import flash.text.*;

    class TextRenderer extends TextField
    {
        private var _length:int = 0;
        private var _oldLength:int = 0;
        private var _scrollHeight:Number = 0;
        private var _defaultTextFormat:TextFormat;

        function TextRenderer()
        {
            var _loc_1:* = new TextFormat("Arial", 12, 0, false, false, false);
            _loc_1.letterSpacing = 0;
            this.defaultTextFormat = _loc_1;
            this.multiline = true;
            this.wordWrap = true;
            this.type = TextFieldType.DYNAMIC;
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            super.text = param1;
            this._length = this.length;
            return;
        }// end function

        override public function set htmlText(param1:String) : void
        {
            super.htmlText = param1;
            this._length = this.length;
            return;
        }// end function

        override public function replaceText(param1:int, param2:int, param3:String) : void
        {
            super.replaceText(param1, param2, param3);
            this._length = this.length;
            return;
        }// end function

        override public function get defaultTextFormat() : TextFormat
        {
            return this._defaultTextFormat;
        }// end function

        override public function set defaultTextFormat(param1:TextFormat) : void
        {
            if (param1.letterSpacing == null)
            {
                param1.letterSpacing = 0;
            }
            this._defaultTextFormat = param1;
            super.defaultTextFormat = param1;
            return;
        }// end function

        override public function set type(param1:String) : void
        {
            super.type = param1;
            this.addEventListener(Event.SCROLL, this.onScroll);
            if (type == TextFieldType.INPUT)
            {
                this.addEventListener(Event.CHANGE, this.onTextChange);
                this.addEventListener(TextEvent.TEXT_INPUT, this.onTextInput);
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            return;
        }// end function

        private function onScroll(event:Event) : void
        {
            this.calcScrollHeight();
            return;
        }// end function

        private function onTextChange(event:Event) : void
        {
            this._oldLength = this._length;
            this._length = this.length;
            return;
        }// end function

        private function onTextInput(event:TextEvent) : void
        {
            this.recoverDefaultFormat();
            return;
        }// end function

        private function calcScrollHeight() : void
        {
            if (this.length == 0)
            {
                this._scrollHeight = 0;
                return;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < (this.scrollV - 1))
            {
                
                _loc_1 = _loc_1 + getLineMetrics(_loc_2).height;
                _loc_2++;
            }
            this._scrollHeight = _loc_1;
            return;
        }// end function

        function recoverDefaultFormat() : void
        {
            this.defaultTextFormat = this.defaultTextFormat;
            return;
        }// end function

        function get scrollHeight() : Number
        {
            return this._scrollHeight;
        }// end function

        public function get oldLength() : int
        {
            return this._oldLength;
        }// end function

        function clear() : void
        {
            this.text = "";
            this._oldLength = 0;
            this._scrollHeight = 0;
            return;
        }// end function

    }
}
