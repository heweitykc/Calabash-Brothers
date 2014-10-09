package starling.text
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.textures.*;
    import starling.utils.*;

    public class BitmapFont extends Object
    {
        private var mTexture:Texture;
        private var mChars:Dictionary;
        private var mName:String;
        private var mSize:Number;
        private var mLineHeight:Number;
        private var mBaseline:Number;
        private var mHelperImage:Image;
        private var mCharLocationPool:Vector.<CharLocation>;
        public static const NATIVE_SIZE:int = -1;
        public static const MINI:String = "mini";
        private static const CHAR_SPACE:int = 32;
        private static const CHAR_TAB:int = 9;
        private static const CHAR_NEWLINE:int = 10;
        private static const CHAR_CARRIAGE_RETURN:int = 13;

        public function BitmapFont(param1:Texture = null, param2:XML = null)
        {
            if (param1 == null && param2 == null)
            {
                param1 = MiniBitmapFont.texture;
                param2 = MiniBitmapFont.xml;
            }
            this.mName = "unknown";
            var _loc_3:* = 14;
            this.mBaseline = 14;
            this.mSize = _loc_3;
            this.mLineHeight = _loc_3;
            this.mTexture = param1;
            this.mChars = new Dictionary();
            this.mHelperImage = new Image(param1);
            this.mCharLocationPool = new Vector.<CharLocation>(0);
            if (param2)
            {
                this.parseFontXml(param2);
            }
            return;
        }// end function

        public function dispose() : void
        {
            if (this.mTexture)
            {
                this.mTexture.dispose();
            }
            return;
        }// end function

        private function parseFontXml(param1:XML) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_2:* = this.mTexture.scale;
            var _loc_3:* = this.mTexture.frame;
            this.mName = param1.info.attribute("face");
            this.mSize = parseFloat(param1.info.attribute("size")) / _loc_2;
            this.mLineHeight = parseFloat(param1.common.attribute("lineHeight")) / _loc_2;
            this.mBaseline = parseFloat(param1.common.attribute("base")) / _loc_2;
            if (param1.info.attribute("smooth").toString() == "0")
            {
                this.smoothing = TextureSmoothing.NONE;
            }
            if (this.mSize <= 0)
            {
                trace("[Starling] Warning: invalid font size in \'" + this.mName + "\' font.");
                this.mSize = this.mSize == 0 ? (16) : (this.mSize * -1);
            }
            for each (_loc_4 in param1.chars.char)
            {
                
                _loc_6 = parseInt(_loc_4.attribute("id"));
                _loc_7 = parseFloat(_loc_4.attribute("xoffset")) / _loc_2;
                _loc_8 = parseFloat(_loc_4.attribute("yoffset")) / _loc_2;
                _loc_9 = parseFloat(_loc_4.attribute("xadvance")) / _loc_2;
                _loc_10 = new Rectangle();
                _loc_10.x = parseFloat(_loc_4.attribute("x")) / _loc_2 + _loc_3.x;
                _loc_10.y = parseFloat(_loc_4.attribute("y")) / _loc_2 + _loc_3.y;
                _loc_10.width = parseFloat(_loc_4.attribute("width")) / _loc_2;
                _loc_10.height = parseFloat(_loc_4.attribute("height")) / _loc_2;
                _loc_11 = Texture.fromTexture(this.mTexture, _loc_10);
                _loc_12 = new BitmapChar(_loc_6, _loc_11, _loc_7, _loc_8, _loc_9);
                this.addChar(_loc_6, _loc_12);
            }
            for each (_loc_5 in param1.kernings.kerning)
            {
                
                _loc_13 = parseInt(_loc_5.attribute("first"));
                _loc_14 = parseInt(_loc_5.attribute("second"));
                _loc_15 = parseFloat(_loc_5.attribute("amount")) / _loc_2;
                if (_loc_14 in this.mChars)
                {
                    this.getChar(_loc_14).addKerning(_loc_13, _loc_15);
                }
            }
            return;
        }// end function

        public function getChar(param1:int) : BitmapChar
        {
            return this.mChars[param1];
        }// end function

        public function addChar(param1:int, param2:BitmapChar) : void
        {
            this.mChars[param1] = param2;
            return;
        }// end function

        public function createSprite(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:uint = 16777215, param6:String = "center", param7:String = "center", param8:Boolean = true, param9:Boolean = true) : Sprite
        {
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_10:* = this.arrangeChars(param1, param2, param3, param4, param6, param7, param8, param9);
            var _loc_11:* = _loc_10.length;
            var _loc_12:* = new Sprite();
            var _loc_13:* = 0;
            while (_loc_13 < _loc_11)
            {
                
                _loc_14 = _loc_10[_loc_13];
                _loc_15 = _loc_14.char.createImage();
                _loc_15.x = _loc_14.x;
                _loc_15.y = _loc_14.y;
                var _loc_16:* = _loc_14.scale;
                _loc_15.scaleY = _loc_14.scale;
                _loc_15.scaleX = _loc_16;
                _loc_15.color = param5;
                _loc_12.addChild(_loc_15);
                _loc_13++;
            }
            return _loc_12;
        }// end function

        public function fillQuadBatch(param1:QuadBatch, param2:Number, param3:Number, param4:String, param5:Number = -1, param6:uint = 16777215, param7:String = "center", param8:String = "center", param9:Boolean = true, param10:Boolean = true) : void
        {
            var _loc_14:* = null;
            var _loc_11:* = this.arrangeChars(param2, param3, param4, param5, param7, param8, param9, param10);
            var _loc_12:* = _loc_11.length;
            this.mHelperImage.color = param6;
            if (_loc_12 > 8192)
            {
                throw new ArgumentError("Bitmap Font text is limited to 8192 characters.");
            }
            var _loc_13:* = 0;
            while (_loc_13 < _loc_12)
            {
                
                _loc_14 = _loc_11[_loc_13];
                this.mHelperImage.texture = _loc_14.char.texture;
                this.mHelperImage.readjustSize();
                this.mHelperImage.x = _loc_14.x;
                this.mHelperImage.y = _loc_14.y;
                var _loc_15:* = _loc_14.scale;
                this.mHelperImage.scaleY = _loc_14.scale;
                this.mHelperImage.scaleX = _loc_15;
                param1.addImage(this.mHelperImage);
                _loc_13++;
            }
            return;
        }// end function

        private function arrangeChars(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:String = "center", param6:String = "center", param7:Boolean = true, param8:Boolean = true) : Vector.<CharLocation>
        {
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = null;
            var _loc_26:* = 0;
            var _loc_27:* = false;
            var _loc_28:* = 0;
            var _loc_29:* = null;
            var _loc_30:* = 0;
            var _loc_31:* = 0;
            var _loc_32:* = null;
            var _loc_33:* = 0;
            var _loc_34:* = null;
            var _loc_35:* = NaN;
            var _loc_36:* = 0;
            if (param3 == null || param3.length == 0)
            {
                return new Vector.<CharLocation>(0);
            }
            if (param4 < 0)
            {
                param4 = param4 * (-this.mSize);
            }
            var _loc_10:* = false;
            while (!_loc_10)
            {
                
                _loc_15 = param4 / this.mSize;
                _loc_13 = param1 / _loc_15;
                _loc_14 = param2 / _loc_15;
                _loc_9 = new Vector.<Vector.<CharLocation>>;
                if (this.mLineHeight <= _loc_14)
                {
                    _loc_21 = -1;
                    _loc_22 = -1;
                    _loc_23 = 0;
                    _loc_24 = 0;
                    _loc_25 = new Vector.<CharLocation>(0);
                    _loc_12 = param3.length;
                    _loc_26 = 0;
                    while (_loc_26 < _loc_12)
                    {
                        
                        _loc_27 = false;
                        _loc_28 = param3.charCodeAt(_loc_26);
                        _loc_29 = this.getChar(_loc_28);
                        if (_loc_28 == CHAR_NEWLINE || _loc_28 == CHAR_CARRIAGE_RETURN)
                        {
                            _loc_27 = true;
                        }
                        else if (_loc_29 == null)
                        {
                            trace("[Starling] Missing character: " + _loc_28);
                        }
                        else
                        {
                            if (_loc_28 == CHAR_SPACE || _loc_28 == CHAR_TAB)
                            {
                                _loc_21 = _loc_26;
                            }
                            if (param8)
                            {
                                _loc_23 = _loc_23 + _loc_29.getKerning(_loc_22);
                            }
                            _loc_11 = this.mCharLocationPool.length ? (this.mCharLocationPool.pop()) : (new CharLocation(_loc_29));
                            _loc_11.char = _loc_29;
                            _loc_11.x = _loc_23 + _loc_29.xOffset;
                            _loc_11.y = _loc_24 + _loc_29.yOffset;
                            _loc_25.push(_loc_11);
                            _loc_23 = _loc_23 + _loc_29.xAdvance;
                            _loc_22 = _loc_28;
                            if (_loc_11.x + _loc_29.width > _loc_13)
                            {
                                _loc_30 = _loc_21 == -1 ? (1) : (_loc_26 - _loc_21);
                                _loc_31 = _loc_25.length - _loc_30;
                                _loc_25.splice(_loc_31, _loc_30);
                                if (_loc_25.length == 0)
                                {
                                    break;
                                }
                                _loc_26 = _loc_26 - _loc_30;
                                _loc_27 = true;
                            }
                        }
                        if (_loc_26 == (_loc_12 - 1))
                        {
                            _loc_9.push(_loc_25);
                            _loc_10 = true;
                        }
                        else if (_loc_27)
                        {
                            _loc_9.push(_loc_25);
                            if (_loc_21 == _loc_26)
                            {
                                _loc_25.pop();
                            }
                            if (_loc_24 + 2 * this.mLineHeight <= _loc_14)
                            {
                                _loc_25 = new Vector.<CharLocation>(0);
                                _loc_23 = 0;
                                _loc_24 = _loc_24 + this.mLineHeight;
                                _loc_21 = -1;
                                _loc_22 = -1;
                            }
                            else
                            {
                                break;
                            }
                        }
                        _loc_26++;
                    }
                }
                if (param7 && !_loc_10 && param4 > 3)
                {
                    param4 = param4 - 1;
                    _loc_9.length = 0;
                    continue;
                }
                _loc_10 = true;
            }
            var _loc_16:* = new Vector.<CharLocation>(0);
            var _loc_17:* = _loc_9.length;
            var _loc_18:* = _loc_24 + this.mLineHeight;
            var _loc_19:* = 0;
            if (param6 == VAlign.BOTTOM)
            {
                _loc_19 = _loc_14 - _loc_18;
            }
            else if (param6 == VAlign.CENTER)
            {
                _loc_19 = (_loc_14 - _loc_18) / 2;
            }
            var _loc_20:* = 0;
            while (_loc_20 < _loc_17)
            {
                
                _loc_32 = _loc_9[_loc_20];
                _loc_12 = _loc_32.length;
                if (_loc_12 == 0)
                {
                }
                else
                {
                    _loc_33 = 0;
                    _loc_34 = _loc_32[(_loc_32.length - 1)];
                    _loc_35 = _loc_34.x - _loc_34.char.xOffset + _loc_34.char.xAdvance;
                    if (param5 == HAlign.RIGHT)
                    {
                        _loc_33 = _loc_13 - _loc_35;
                    }
                    else if (param5 == HAlign.CENTER)
                    {
                        _loc_33 = (_loc_13 - _loc_35) / 2;
                    }
                    _loc_36 = 0;
                    while (_loc_36 < _loc_12)
                    {
                        
                        _loc_11 = _loc_32[_loc_36];
                        _loc_11.x = _loc_15 * (_loc_11.x + _loc_33);
                        _loc_11.y = _loc_15 * (_loc_11.y + _loc_19);
                        _loc_11.scale = _loc_15;
                        if (_loc_11.char.width > 0 && _loc_11.char.height > 0)
                        {
                            _loc_16.push(_loc_11);
                        }
                        this.mCharLocationPool.push(_loc_11);
                        _loc_36++;
                    }
                }
                _loc_20++;
            }
            return _loc_16;
        }// end function

        public function get name() : String
        {
            return this.mName;
        }// end function

        public function get size() : Number
        {
            return this.mSize;
        }// end function

        public function get lineHeight() : Number
        {
            return this.mLineHeight;
        }// end function

        public function set lineHeight(param1:Number) : void
        {
            this.mLineHeight = param1;
            return;
        }// end function

        public function get smoothing() : String
        {
            return this.mHelperImage.smoothing;
        }// end function

        public function set smoothing(param1:String) : void
        {
            this.mHelperImage.smoothing = param1;
            return;
        }// end function

        public function get baseline() : Number
        {
            return this.mBaseline;
        }// end function

    }
}

import __AS3__.vec.*;

import flash.geom.*;

import flash.utils.*;

import starling.display.*;

import starling.textures.*;

import starling.utils.*;

class CharLocation extends Object
{
    public var char:BitmapChar;
    public var scale:Number;
    public var x:Number;
    public var y:Number;

    function CharLocation(param1:BitmapChar)
    {
        this.char = param1;
        return;
    }// end function

}

