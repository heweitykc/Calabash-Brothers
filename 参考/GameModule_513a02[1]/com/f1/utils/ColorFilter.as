package com.f1.utils
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;

    public class ColorFilter extends Object
    {
        private static var sourceBitmap:Bitmap;
        private static var returnBitmapData:BitmapData;
        private static var tempMovieClip:MovieClip;
        private static var _grayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]);

        public function ColorFilter()
        {
            return;
        }// end function

        public static function invert(param1:BitmapData) : BitmapData
        {
            sourceBitmap = new Bitmap(param1);
            tempMovieClip = new MovieClip();
            tempMovieClip.addChild(sourceBitmap);
            var _loc_2:* = new Sprite();
            _loc_2.graphics.lineStyle(0, 0, 100);
            _loc_2.graphics.moveTo(0, 0);
            _loc_2.graphics.beginFill(0);
            _loc_2.graphics.lineTo(sourceBitmap.width, 0);
            _loc_2.graphics.lineTo(sourceBitmap.width, sourceBitmap.height);
            _loc_2.graphics.lineTo(0, sourceBitmap.height);
            _loc_2.graphics.lineTo(0, 0);
            _loc_2.graphics.endFill();
            _loc_2.blendMode = "invert";
            tempMovieClip.addChild(_loc_2);
            returnBitmapData = new BitmapData(tempMovieClip.width, tempMovieClip.height, true, 16777215);
            returnBitmapData.draw(tempMovieClip);
            tempMovieClip.removeChild(_loc_2);
            tempMovieClip.removeChild(sourceBitmap);
            _loc_2 = null;
            return returnBitmapData;
        }// end function

        public static function grayFilter(param1:BitmapData) : BitmapData
        {
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [getGrayFilter(), getGrayFilter()];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function getGrayFilter() : ColorMatrixFilter
        {
            return _grayFilter;
        }// end function

        public static function embossFilter(param1:BitmapData, param2:uint = 315) : BitmapData
        {
            var _loc_3:* = param2 * Math.PI / 180;
            var _loc_4:* = Math.PI / 4;
            var _loc_5:* = false;
            var _loc_6:* = 16711680;
            var _loc_7:* = 256;
            var _loc_8:* = 128;
            var _loc_9:* = false;
            var _loc_10:* = [Math.cos(_loc_3 + _loc_4) * 256, Math.cos(_loc_3 + 2 * _loc_4) * 256, Math.cos(_loc_3 + 3 * _loc_4) * 256, Math.cos(_loc_3) * 256, 0, Math.cos(_loc_3 + 4 * _loc_4) * 256, Math.cos(_loc_3 - _loc_4) * 256, Math.cos(_loc_3 - 2 * _loc_4) * 256, Math.cos(_loc_3 - 3 * _loc_4) * 256];
            var _loc_11:* = 3;
            var _loc_12:* = 3;
            var _loc_13:* = new ConvolutionFilter(_loc_11, _loc_12, _loc_10, _loc_10.length, _loc_8, _loc_9, _loc_5, _loc_6, _loc_7);
            var _loc_14:* = new Array();
            _loc_14.push(_loc_13);
            _loc_14.push(getGrayFilter());
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = _loc_14;
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function blurFilter(param1:BitmapData, param2:Number = 5, param3:Number = 5) : BitmapData
        {
            var _loc_4:* = new BlurFilter(param2, param3, BitmapFilterQuality.HIGH);
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_4];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function sharpenFilter(param1:BitmapData, param2:Number = 0.7) : BitmapData
        {
            var _loc_3:* = [0, 0, 0, 0, 0, 0, 0, 0, 0];
            var _loc_5:* = -param2;
            _loc_3[7] = -param2;
            _loc_3[5] = _loc_5;
            _loc_3[3] = _loc_5;
            _loc_3[1] = _loc_5;
            _loc_3[4] = 1 + param2 * 4;
            var _loc_4:* = new ConvolutionFilter(3, 3, _loc_3);
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_4];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function raiseFilter(param1:BitmapData, param2:Number = 5, param3:Number = 45) : BitmapData
        {
            var _loc_4:* = 13421772;
            var _loc_5:* = 0.8;
            var _loc_6:* = 8421504;
            var _loc_7:* = 0.8;
            var _loc_8:* = 5;
            var _loc_9:* = 5;
            var _loc_10:* = 5;
            var _loc_11:* = BitmapFilterQuality.HIGH;
            var _loc_12:* = BitmapFilterType.INNER;
            var _loc_13:* = false;
            var _loc_14:* = new BevelFilter(param2, param3, _loc_4, _loc_5, _loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12, _loc_13);
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_14];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function oldPictureFilter(param1:BitmapData) : BitmapData
        {
            var _loc_2:* = getGrayFilter();
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_2];
            param1 = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            param1.draw(sourceBitmap);
            var _loc_3:* = new Array();
            _loc_3 = _loc_3.concat([0.94, 0, 0, 0, 0]);
            _loc_3 = _loc_3.concat([0, 0.9, 0, 0, 0]);
            _loc_3 = _loc_3.concat([0, 0, 0.8, 0, 0]);
            _loc_3 = _loc_3.concat([0, 0, 0, 0.8, 0]);
            _loc_2 = new ColorMatrixFilter(_loc_3);
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_2];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function noiseFilter(param1:BitmapData, param2:Number = 128) : BitmapData
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_9:* = 0;
            returnBitmapData = param1.clone();
            var _loc_8:* = 0;
            while (_loc_8 < param1.height)
            {
                
                _loc_9 = 0;
                while (_loc_9 < param1.width)
                {
                    
                    _loc_3 = int(Math.random() * param2 * 2) - param2;
                    _loc_4 = param1.getPixel(_loc_9, _loc_8);
                    _loc_5 = (_loc_4 & 16711680) >> 16;
                    _loc_6 = (_loc_4 & 65280) >> 8;
                    _loc_7 = _loc_4 & 255;
                    _loc_5 = _loc_5 + _loc_3 < 0 ? (0) : (_loc_5 + _loc_3 > 255 ? (255) : (_loc_5 + _loc_3));
                    _loc_6 = _loc_6 + _loc_3 < 0 ? (0) : (_loc_6 + _loc_3 > 255 ? (255) : (_loc_6 + _loc_3));
                    _loc_7 = _loc_7 + _loc_3 < 0 ? (0) : (_loc_7 + _loc_3 > 255 ? (255) : (_loc_7 + _loc_3));
                    returnBitmapData.setPixel(_loc_9, _loc_8, _loc_5 * 65536 + _loc_6 * 256 + _loc_7);
                    _loc_9 = _loc_9 + 1;
                }
                _loc_8 = _loc_8 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function sketchFilter(param1:BitmapData, param2:Number = 30) : BitmapData
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_8:* = undefined;
            var _loc_3:* = getGrayFilter();
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_3];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            var _loc_7:* = 0;
            while (_loc_7 < (param1.height - 1))
            {
                
                _loc_8 = 0;
                while (_loc_8 < (param1.width - 1))
                {
                    
                    _loc_4 = param1.getPixel(_loc_8, _loc_7);
                    _loc_5 = (_loc_4 & 16711680) >> 16;
                    _loc_4 = param1.getPixel((_loc_8 + 1), (_loc_7 + 1));
                    _loc_6 = (_loc_4 & 16711680) >> 16;
                    if (Math.abs(_loc_5 - _loc_6) >= param2)
                    {
                        returnBitmapData.setPixel(_loc_8, _loc_7, 2236962);
                    }
                    else
                    {
                        returnBitmapData.setPixel(_loc_8, _loc_7, 16777215);
                    }
                    _loc_8 = _loc_8 + 1;
                }
                _loc_7 = _loc_7 + 1;
            }
            _loc_7 = 0;
            while (_loc_7 < param1.height)
            {
                
                returnBitmapData.setPixel((param1.width - 1), _loc_7, 16777215);
                _loc_7 = _loc_7 + 1;
            }
            _loc_7 = 0;
            while (_loc_7 < param1.width)
            {
                
                returnBitmapData.setPixel(_loc_7, (param1.height - 1), 16777215);
                _loc_7 = _loc_7 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function waterColorFilter(param1:BitmapData, param2:Number = 5, param3:Number = 5) : BitmapData
        {
            var _loc_4:* = 1;
            var _loc_5:* = 1;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = new BitmapData(param1.width, param1.height, true, 16777215);
            _loc_8.perlinNoise(3, 3, 1, 1, false, true, 1, false);
            sourceBitmap = new Bitmap(param1);
            var _loc_9:* = new DisplacementMapFilter(_loc_8, new Point(0, 0), _loc_4, _loc_5, param2, param3, DisplacementMapFilterMode.COLOR, _loc_6, _loc_7);
            sourceBitmap.filters = [_loc_9];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function diffuseFilter(param1:BitmapData, param2:Number = 5, param3:Number = 5) : BitmapData
        {
            var _loc_4:* = 1;
            var _loc_5:* = 1;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = new BitmapData(param1.width, param1.height, true, 16777215);
            _loc_8.noise(888888);
            sourceBitmap = new Bitmap(param1);
            var _loc_9:* = new DisplacementMapFilter(_loc_8, new Point(0, 0), _loc_4, _loc_5, param2, param3, DisplacementMapFilterMode.COLOR, _loc_6, _loc_7);
            sourceBitmap.filters = [_loc_9];
            returnBitmapData = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            returnBitmapData.draw(sourceBitmap);
            return returnBitmapData;
        }// end function

        public static function spherizeFilter(param1:BitmapData) : BitmapData
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_2:* = int(param1.width / 2);
            var _loc_3:* = int(param1.height / 2);
            var _loc_4:* = _loc_2 > _loc_3 ? (_loc_2) : (_loc_3);
            returnBitmapData = param1.clone();
            var _loc_13:* = 0;
            while (_loc_13 < (param1.height - 1))
            {
                
                _loc_14 = 0;
                while (_loc_14 < (param1.width - 1))
                {
                    
                    _loc_7 = _loc_14 - _loc_2;
                    _loc_8 = _loc_13 - _loc_3;
                    _loc_5 = Math.atan2(_loc_8, _loc_7);
                    _loc_6 = (_loc_7 * _loc_7 + _loc_8 * _loc_8) / _loc_4;
                    _loc_15 = int(_loc_6 * Math.cos(_loc_5)) + _loc_2;
                    _loc_16 = int(_loc_6 * Math.sin(_loc_5)) + _loc_3;
                    if (_loc_15 < 0)
                    {
                        _loc_15 = 0;
                    }
                    if (_loc_15 >= param1.width)
                    {
                        _loc_15 = param1.width - 1;
                    }
                    if (_loc_16 < 0)
                    {
                        _loc_16 = 0;
                    }
                    if (_loc_16 >= param1.height)
                    {
                        _loc_16 = param1.height - 1;
                    }
                    _loc_9 = param1.getPixel(_loc_15, _loc_16);
                    _loc_10 = (_loc_9 & 16711680) >> 16;
                    _loc_11 = (_loc_9 & 65280) >> 8;
                    _loc_12 = _loc_9 & 255;
                    returnBitmapData.setPixel(_loc_14, _loc_13, _loc_10 * 65536 + _loc_11 * 256 + _loc_12);
                    _loc_14 = _loc_14 + 1;
                }
                _loc_13 = _loc_13 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function pinchFilter(param1:BitmapData, param2:Number = 16) : BitmapData
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_3:* = int(param1.width / 2);
            var _loc_4:* = int(param1.height / 2);
            returnBitmapData = param1.clone();
            var _loc_13:* = 0;
            while (_loc_13 < (param1.height - 1))
            {
                
                _loc_14 = 0;
                while (_loc_14 < (param1.width - 1))
                {
                    
                    _loc_7 = _loc_14 - _loc_3;
                    _loc_8 = _loc_13 - _loc_4;
                    _loc_5 = Math.atan2(_loc_8, _loc_7);
                    _loc_6 = Math.sqrt(_loc_7 * _loc_7 + _loc_8 * _loc_8);
                    _loc_6 = Math.sqrt(_loc_6) * param2;
                    _loc_15 = int(_loc_6 * Math.cos(_loc_5)) + _loc_3;
                    _loc_16 = int(_loc_6 * Math.sin(_loc_5)) + _loc_4;
                    if (_loc_15 < 0)
                    {
                        _loc_15 = 0;
                    }
                    if (_loc_15 >= param1.width)
                    {
                        _loc_15 = param1.width - 1;
                    }
                    if (_loc_16 < 0)
                    {
                        _loc_16 = 0;
                    }
                    if (_loc_16 >= param1.height)
                    {
                        _loc_16 = param1.height - 1;
                    }
                    _loc_9 = param1.getPixel(_loc_15, _loc_16);
                    _loc_10 = (_loc_9 & 16711680) >> 16;
                    _loc_11 = (_loc_9 & 65280) >> 8;
                    _loc_12 = _loc_9 & 255;
                    returnBitmapData.setPixel(_loc_14, _loc_13, _loc_10 * 65536 + _loc_11 * 256 + _loc_12);
                    _loc_14 = _loc_14 + 1;
                }
                _loc_13 = _loc_13 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function lightingFilter(param1:BitmapData, param2:Number = 128, param3:Number = 0.5, param4:Number = 0.5, param5:Number = 0) : BitmapData
        {
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_17:* = undefined;
            var _loc_6:* = int(param1.width * param3);
            var _loc_7:* = int(param1.height * param4);
            if (param5 == 0)
            {
                param5 = Math.sqrt(_loc_6 * _loc_6 + _loc_7 * _loc_7);
            }
            if (param5 == 0)
            {
                param5 = Math.sqrt(param1.width * param1.width / 4 + param1.height * param1.height / 4);
            }
            var _loc_8:* = int(param5);
            var _loc_9:* = param5 * param5;
            returnBitmapData = param1.clone();
            var _loc_16:* = 0;
            while (_loc_16 < param1.height)
            {
                
                _loc_17 = 0;
                while (_loc_17 < param1.width)
                {
                    
                    _loc_10 = (_loc_17 - _loc_6) * (_loc_17 - _loc_6) + (_loc_16 - _loc_7) * (_loc_16 - _loc_7);
                    if (_loc_10 < _loc_9)
                    {
                        _loc_11 = param1.getPixel(_loc_17, _loc_16);
                        param5 = (_loc_11 & 16711680) >> 16;
                        _loc_12 = (_loc_11 & 65280) >> 8;
                        _loc_13 = _loc_11 & 255;
                        _loc_14 = Math.sqrt(_loc_10);
                        _loc_15 = int(param2 * (_loc_8 - _loc_14) / _loc_8);
                        param5 = param5 + _loc_15 > 255 ? (255) : (param5 + _loc_15);
                        _loc_12 = _loc_12 + _loc_15 > 255 ? (255) : (_loc_12 + _loc_15);
                        _loc_13 = _loc_13 + _loc_15 > 255 ? (255) : (_loc_13 + _loc_15);
                        returnBitmapData.setPixel(_loc_17, _loc_16, param5 * 65536 + _loc_12 * 256 + _loc_13);
                    }
                    _loc_17 = _loc_17 + 1;
                }
                _loc_16 = _loc_16 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function mosaicFilter(param1:BitmapData, param2:Number = 6) : BitmapData
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            returnBitmapData = param1.clone();
            var _loc_14:* = 0;
            while (_loc_14 < param1.height)
            {
                
                _loc_15 = 0;
                while (_loc_15 < param1.width)
                {
                    
                    _loc_3 = 0;
                    _loc_4 = 0;
                    _loc_5 = 0;
                    _loc_6 = 0;
                    _loc_16 = 0;
                    while (_loc_16 < param2)
                    {
                        
                        _loc_17 = 0;
                        while (_loc_17 < param2)
                        {
                            
                            if (_loc_15 + _loc_17 < param1.width && _loc_14 + _loc_16 < param1.height)
                            {
                                _loc_7 = param1.getPixel(_loc_15 + _loc_17, _loc_14 + _loc_16);
                                _loc_8 = (_loc_7 & 16711680) >> 16;
                                _loc_9 = (_loc_7 & 65280) >> 8;
                                _loc_10 = _loc_7 & 255;
                                _loc_3 = _loc_3 + _loc_8;
                                _loc_4 = _loc_4 + _loc_9;
                                _loc_5 = _loc_5 + _loc_10;
                                _loc_6 = _loc_6 + 1;
                            }
                            _loc_17 = _loc_17 + 1;
                        }
                        _loc_16 = _loc_16 + 1;
                    }
                    _loc_11 = int(_loc_3 / _loc_6);
                    _loc_12 = int(_loc_4 / _loc_6);
                    _loc_13 = int(_loc_5 / _loc_6);
                    _loc_16 = 0;
                    while (_loc_16 < param2)
                    {
                        
                        _loc_17 = 0;
                        while (_loc_17 < param2)
                        {
                            
                            if (_loc_15 + _loc_17 < param1.width && _loc_14 + _loc_16 < param1.height)
                            {
                                returnBitmapData.setPixel(_loc_15 + _loc_17, _loc_14 + _loc_16, _loc_11 * 65536 + _loc_12 * 256 + _loc_13);
                            }
                            _loc_17 = _loc_17 + 1;
                        }
                        _loc_16 = _loc_16 + 1;
                    }
                    _loc_15 = _loc_15 + param2;
                }
                _loc_14 = _loc_14 + param2;
            }
            return returnBitmapData;
        }// end function

        public static function oilPaintingFilter(param1:BitmapData, param2:Number = 1, param3:Number = 32) : BitmapData
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_17:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_23:* = undefined;
            var _loc_24:* = undefined;
            var _loc_25:* = undefined;
            var _loc_26:* = undefined;
            var _loc_27:* = undefined;
            var _loc_28:* = undefined;
            var _loc_10:* = param3 + 1;
            var _loc_11:* = new Array();
            var _loc_12:* = new Array();
            var _loc_13:* = new Array();
            var _loc_14:* = new Array();
            var _loc_15:* = new Array();
            var _loc_16:* = getGrayFilter();
            sourceBitmap = new Bitmap(param1);
            sourceBitmap.filters = [_loc_16];
            _loc_17 = new BitmapData(sourceBitmap.width, sourceBitmap.height, true, 16777215);
            _loc_17.draw(sourceBitmap);
            returnBitmapData = _loc_17.clone();
            var _loc_22:* = 0;
            while (_loc_22 < param1.height)
            {
                
                _loc_18 = _loc_22 - param2;
                _loc_19 = _loc_22 + param2 + 1;
                if (_loc_18 < 0)
                {
                    _loc_18 = 0;
                }
                if (_loc_19 >= param1.height)
                {
                    _loc_19 = param1.height - 1;
                }
                _loc_23 = 0;
                while (_loc_23 < param1.width)
                {
                    
                    _loc_20 = _loc_23 - param2;
                    _loc_21 = _loc_23 + param2 + 1;
                    if (_loc_20 < 0)
                    {
                        _loc_20 = 0;
                    }
                    if (_loc_21 >= param1.width)
                    {
                        _loc_21 = param1.width;
                    }
                    _loc_24 = 0;
                    while (_loc_24 < _loc_10)
                    {
                        
                        _loc_11[_loc_24] = 0;
                        _loc_12[_loc_24] = 0;
                        _loc_13[_loc_24] = 0;
                        _loc_14[_loc_24] = 0;
                        _loc_15[_loc_24] = 0;
                        _loc_24 = _loc_24 + 1;
                    }
                    _loc_25 = _loc_18;
                    while (_loc_25 < _loc_19)
                    {
                        
                        _loc_24 = _loc_20;
                        while (_loc_24 < _loc_21)
                        {
                            
                            _loc_4 = _loc_17.getPixel(_loc_24, _loc_25);
                            _loc_5 = (_loc_4 & 16711680) >> 16;
                            _loc_4 = param1.getPixel32(_loc_24, _loc_25);
                            _loc_9 = _loc_4 >> 24 & 255;
                            _loc_6 = _loc_4 >> 16 & 255;
                            _loc_7 = _loc_4 >> 8 & 255;
                            _loc_8 = _loc_4 & 255;
                            _loc_28 = int(param3 * _loc_5 / 255);
                            var _loc_29:* = _loc_11;
                            var _loc_30:* = _loc_28;
                            var _loc_31:* = _loc_11[_loc_28] + 1;
                            _loc_29[_loc_30] = _loc_31;
                            _loc_12[_loc_28] = _loc_12[_loc_28] + _loc_6;
                            _loc_13[_loc_28] = _loc_13[_loc_28] + _loc_7;
                            _loc_14[_loc_28] = _loc_14[_loc_28] + _loc_8;
                            _loc_15[_loc_28] = _loc_15[_loc_28] + _loc_9;
                            _loc_24 = _loc_24 + 1;
                        }
                        _loc_25 = _loc_25 + 1;
                    }
                    _loc_26 = 0;
                    _loc_27 = _loc_11[0];
                    _loc_24 = 1;
                    while (_loc_24 < _loc_10)
                    {
                        
                        if (_loc_11[_loc_24] > _loc_27)
                        {
                            _loc_26 = _loc_24;
                            _loc_27 = _loc_11[_loc_24];
                        }
                        _loc_24 = _loc_24 + 1;
                    }
                    _loc_9 = int(_loc_15[_loc_26] / _loc_27);
                    _loc_6 = int(_loc_12[_loc_26] / _loc_27);
                    _loc_7 = int(_loc_13[_loc_26] / _loc_27);
                    _loc_8 = int(_loc_14[_loc_26] / _loc_27);
                    returnBitmapData.setPixel32(_loc_23, _loc_22, _loc_9 * 16777216 + _loc_6 * 65536 + _loc_7 * 256 + _loc_8);
                    _loc_23 = _loc_23 + 1;
                }
                _loc_22 = _loc_22 + 1;
            }
            return returnBitmapData;
        }// end function

        public static function thresholdFilter(param1:BitmapData, param2:uint = 128) : BitmapData
        {
            var _loc_3:* = new BitmapData(param1.width, param1.height, true, 4278190080);
            var _loc_4:* = new Point(0, 0);
            var _loc_5:* = new Rectangle(0, 0, param1.width, param1.height);
            param2 = param2 < 0 ? (0) : (param2 > 255 ? (255) : (param2));
            var _loc_6:* = 255 * 16777215 + param2 * 65535 + param2 * 255 + param2;
            var _loc_7:* = 16777215;
            var _loc_8:* = 4294967295;
            _loc_3.threshold(param1, _loc_5, _loc_4, ">", _loc_6, _loc_7, _loc_8, false);
            return _loc_3;
        }// end function

        public static function brightness(param1:Number) : Array
        {
            var _loc_2:* = [1, 0, 0, 0, param1, 0, 1, 0, 0, param1, 0, 0, 1, 0, param1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            var _loc_3:* = new ColorMatrixFilter(_loc_2);
            return [_loc_3];
        }// end function

        public static function saturation(param1:Number = 1, param2:Number = 1, param3:Number = 1) : Array
        {
            var _loc_4:* = new Array();
            _loc_4 = _loc_4.concat([param1, 0, 0, 0, 0]);
            _loc_4 = _loc_4.concat([0, param2, 0, 0, 0]);
            _loc_4 = _loc_4.concat([0, 0, param3, 0, 0]);
            _loc_4 = _loc_4.concat([0, 0, 0, 1, 0]);
            var _loc_5:* = new ColorMatrixFilter(_loc_4);
            return [new ColorMatrixFilter(_loc_4)];
        }// end function

        public static function contrast(param1:Number = 0, param2:Number = 0, param3:Number = 0) : Array
        {
            var _loc_4:* = [param1 / 127, 0, 0, 0, 0.5 * (127 - param1), 0, param2 / 127, 0, 0, 0.5 * (127 - param2), 0, 0, param3 / 127, 0, 0.5 * (127 - param3), 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            var _loc_5:* = new ColorMatrixFilter(_loc_4);
            return [new ColorMatrixFilter(_loc_4)];
        }// end function

        public static function saturationPer(param1:Number) : Array
        {
            var _loc_2:* = Math.min(100, Math.max(-100, param1));
            if (_loc_2 == 0 || isNaN(_loc_2))
            {
                return null;
            }
            var _loc_3:* = 1 + (_loc_2 > 0 ? (3 * _loc_2 / 100) : (_loc_2 / 100));
            var _loc_4:* = 0.3086;
            var _loc_5:* = 0.6094;
            var _loc_6:* = 0.082;
            return [_loc_4 * (1 - _loc_3) + _loc_3, _loc_5 * (1 - _loc_3), _loc_6 * (1 - _loc_3), 0, 0, _loc_4 * (1 - _loc_3), _loc_5 * (1 - _loc_3) + _loc_3, _loc_6 * (1 - _loc_3), 0, 0, _loc_4 * (1 - _loc_3), _loc_5 * (1 - _loc_3), _loc_6 * (1 - _loc_3) + _loc_3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
        }// end function

    }
}
