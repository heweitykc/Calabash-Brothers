package com.f1.utils
{
    import com.f1.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;
    import flash.utils.*;

    public class ToolKit extends Object
    {
        public static var timeOffset:Number = 0;
        private static var colorFilters:Dictionary = new Dictionary();
        private static const ZEROS:String = "0000000000";
        public static var NumArr:Array = [LanguageCfgObj.getInstance().getByIndex("12298"), LanguageCfgObj.getInstance().getByIndex("12299"), LanguageCfgObj.getInstance().getByIndex("12300"), LanguageCfgObj.getInstance().getByIndex("12301"), LanguageCfgObj.getInstance().getByIndex("12302"), LanguageCfgObj.getInstance().getByIndex("12303"), LanguageCfgObj.getInstance().getByIndex("12304"), LanguageCfgObj.getInstance().getByIndex("12305"), LanguageCfgObj.getInstance().getByIndex("12306"), LanguageCfgObj.getInstance().getByIndex("12307")];

        public function ToolKit()
        {
            return;
        }// end function

        public static function clearMcChild(param1, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            if (param1)
            {
                if (param1 is DisplayObjectContainer)
                {
                    while (param1.numChildren > 0)
                    {
                        
                        _loc_4 = param1.getChildAt(0);
                        if (_loc_4 is MovieClip)
                        {
                            (_loc_4 as MovieClip).stop();
                        }
                        if (_loc_4 is Loader)
                        {
                            Loader(_loc_4).unloadAndStop(false);
                        }
                        if (param2)
                        {
                            if (_loc_4 is BaseSprite)
                            {
                                (_loc_4 as BaseSprite).finalize();
                            }
                            else if (_loc_4 is Image)
                            {
                                (_loc_4 as Image).dispose();
                            }
                            else if (_loc_4 is ImageSP)
                            {
                                (_loc_4 as ImageSP).dispose();
                            }
                            else if (_loc_4 is Bitmap)
                            {
                            }
                            _loc_4.filters = [];
                        }
                        if (param3)
                        {
                            _loc_5 = _loc_4["reset"];
                            if (_loc_5 != null)
                            {
                                _loc_5.call(null);
                            }
                            ObjectPool.CheckIn(_loc_4);
                        }
                        if (_loc_4.parent == param1)
                        {
                            param1.removeChild(_loc_4);
                        }
                    }
                }
            }
            return;
        }// end function

        public static function loadTool(param1:String, param2 = null, param3:Function = null, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:Boolean = false) : Loader
        {
            var loader:Loader;
            var onComplete:Function;
            var onProgress:Function;
            var ioError:Function;
            var theUrl:* = param1;
            var targets:* = param2;
            var comFun:* = param3;
            var progressFun:* = param4;
            var errFun:* = param5;
            var addToAppDomain:* = param6;
            var ifCheckPolicyFile:* = param7;
            onComplete = function (event:Event) : void
            {
                if (comFun != null)
                {
                    comFun(loader);
                }
                clear(event.currentTarget);
                return;
            }// end function
            ;
            onProgress = function (event:ProgressEvent) : void
            {
                if (progressFun != null)
                {
                    progressFun(event.bytesLoaded, event.bytesTotal);
                }
                return;
            }// end function
            ;
            ioError = function (event:IOErrorEvent) : void
            {
                event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
                if (errFun != null)
                {
                    errFun();
                }
                clear(event.currentTarget);
                return;
            }// end function
            ;
            var clear:* = function (param1:LoaderInfo) : void
            {
                param1.removeEventListener(Event.COMPLETE, onComplete);
                param1.removeEventListener(ProgressEvent.PROGRESS, onProgress);
                param1.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
                comFun = null;
                progressFun = null;
                errFun = null;
                return;
            }// end function
            ;
            loader = new Loader();
            var request:* = new URLRequest(theUrl);
            if (targets != null)
            {
                targets.addChild(loader);
            }
            if (comFun != null)
            {
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            }
            if (progressFun != null)
            {
                loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            }
            if (errFun != null)
            {
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
            }
            try
            {
                if (addToAppDomain)
                {
                    loader.load(request, new LoaderContext(ifCheckPolicyFile, ApplicationDomain.currentDomain));
                }
                else
                {
                    loader.load(request, new LoaderContext(ifCheckPolicyFile));
                }
            }
            catch (error:IOError)
            {
                trace("未加载完毕！");
            }
            return loader;
        }// end function

        public static function loadVarTool(param1:String, param2:Function = null, param3 = null, param4:Array = null, param5:int = 1, param6:int = 1, param7:Boolean = true) : void
        {
            var loader:URLLoader;
            var errorHandler:Function;
            var completeHandler:Function;
            var url:* = param1;
            var responseFun:* = param2;
            var sendObj:* = param3;
            var params:* = param4;
            var requestType:* = param5;
            var responseType:* = param6;
            var compress:* = param7;
            errorHandler = function (event:Event) : void
            {
                return;
            }// end function
            ;
            completeHandler = function (event:Event) : void
            {
                var _loc_2:* = undefined;
                var _loc_3:* = null;
                loader.removeEventListener(Event.COMPLETE, completeHandler);
                if (responseType == 1)
                {
                    _loc_2 = event.target.data;
                }
                else if (responseType == 2)
                {
                    _loc_3 = event.target.data as ByteArray;
                    if (compress)
                    {
                        _loc_3.uncompress();
                    }
                    _loc_2 = _loc_3.readObject();
                }
                if (responseFun != null)
                {
                    if (params)
                    {
                        responseFun.call(null, _loc_2, params);
                    }
                    else
                    {
                        responseFun.call(null, _loc_2);
                    }
                }
                return;
            }// end function
            ;
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            var request:* = new URLRequest(url + "&ver=" + Math.random());
            if (requestType == 2)
            {
                loader.dataFormat = URLLoaderDataFormat.BINARY;
                if (sendObj != null && compress)
                {
                    request.contentType = "application/x-gzip-compressed";
                    sendObj.compress();
                }
            }
            if (sendObj != null)
            {
                request.data = sendObj;
            }
            request.method = "POST";
            try
            {
                loader.load(request);
            }
            catch (error:Error)
            {
                trace("不能加载数据");
            }
            return;
        }// end function

        public static function reflection(param1:String) : Class
        {
            var theClass:Class;
            var str:* = param1;
            try
            {
                theClass = getDefinitionByName(str) as Class;
                return theClass;
            }
            catch (e:Error)
            {
                Log.log("Error:未找到元件类", str);
            }
            return null;
        }// end function

        public static function getNew(param1:String, param2:Boolean = false, param3:ApplicationDomain = null)
        {
            var theClass:Class;
            var obj:*;
            var className:* = param1;
            var mcStop:* = param2;
            var appDomain:* = param3;
            if (!className)
            {
                return null;
            }
            try
            {
                if (appDomain)
                {
                    if (appDomain.hasDefinition(className))
                    {
                        theClass = appDomain.getDefinition(className) as Class;
                    }
                }
                else
                {
                    theClass = getDefinitionByName(className) as Class;
                }
                if (getQualifiedSuperclassName(theClass) != "flash.display::BitmapData")
                {
                    obj = new theClass;
                    if (mcStop)
                    {
                        if (obj && obj is MovieClip)
                        {
                            MovieClip(obj).gotoAndStop(1);
                        }
                    }
                    return obj;
                }
                else
                {
                    return new theClass(0, 0);
                }
            }
            catch (e:Error)
            {
                Log.log("Error:未找到元件", className);
            }
            return null;
        }// end function

        public static function getNewDO(param1:String, param2:ApplicationDomain = null) : DisplayObject
        {
            var _loc_3:* = getNew(param1, true, param2);
            if (_loc_3 is BitmapData)
            {
                return new Bitmap(_loc_3 as BitmapData);
            }
            return _loc_3;
        }// end function

        public static function CLength(param1:String) : String
        {
            var _loc_2:* = null;
            switch(chGetLength(chGetLength(param1).toString()))
            {
                case 1:
                {
                    _loc_2 = "000" + chGetLength(param1).toString();
                    break;
                }
                case 2:
                {
                    _loc_2 = "00" + chGetLength(param1).toString();
                    break;
                }
                case 3:
                {
                    _loc_2 = "0" + chGetLength(param1).toString();
                    break;
                }
                case 4:
                {
                    _loc_2 = chGetLength(param1).toString();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2 + param1;
        }// end function

        public static function chGetLength(param1:String) : uint
        {
            var _loc_3:* = 0;
            var _loc_4:* = NaN;
            param1 = param1 + "";
            var _loc_2:* = 0;
            _loc_3 = 0;
            while (_loc_3 < param1.length)
            {
                
                _loc_4 = param1.charCodeAt(_loc_3);
                if (_loc_4 < 127)
                {
                    _loc_2 = _loc_2 + 1;
                }
                else if (_loc_4 >= 128 && _loc_4 <= 2047)
                {
                    _loc_2 = _loc_2 + 2;
                }
                else if (_loc_4 >= 2048 && _loc_4 <= 65535)
                {
                    _loc_2 = _loc_2 + 3;
                }
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public static function checkName(param1:String) : Boolean
        {
            if (StringUtil.isInteger(param1))
            {
                return false;
            }
            var _loc_2:* = /^(\w|[^\x00-\xff])*$/;
            var _loc_3:* = param1.match(_loc_2);
            if (_loc_3)
            {
                if (chChineseLength(param1) > 14)
                {
                    return false;
                }
                return true;
            }
            else
            {
                return false;
            }
        }// end function

        public static function chChineseLength(param1:String) : uint
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1.charCodeAt(_loc_3) > 255)
                {
                    _loc_2 = _loc_2 + 2;
                }
                else
                {
                    _loc_2 = _loc_2 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return _loc_2;
        }// end function

        public static function gotoWeb(param1:String, param2:String = "_blank", param3:uint = 0) : void
        {
            var request:URLRequest;
            var gotoURL:Function;
            var url:* = param1;
            var target:* = param2;
            var time:* = param3;
            gotoURL = function () : void
            {
                navigateToURL(request, target);
                return;
            }// end function
            ;
            trace("跳转到--" + url);
            request = new URLRequest(url);
            if (time == 0)
            {
                navigateToURL(request, target);
            }
            else
            {
                setTimeout(gotoURL, time * 1000);
            }
            return;
        }// end function

        public static function distanceSQ(param1:Number, param2:Number, param3:Number, param4:Number) : uint
        {
            var _loc_5:* = param1 - param3;
            var _loc_6:* = param2 - param4;
            var _loc_7:* = _loc_5 * _loc_5 + _loc_6 * _loc_6;
            return _loc_5 * _loc_5 + _loc_6 * _loc_6;
        }// end function

        public static function distance(param1:Number, param2:Number, param3:Number, param4:Number) : uint
        {
            return Math.sqrt(distanceSQ(param1, param2, param3, param4));
        }// end function

        public static function feet(param1:uint, param2:uint, param3:uint, param4:uint) : uint
        {
            return Math.abs(param1 - param3) + Math.abs(param2 - param4);
        }// end function

        public static function creatCircle(param1:Number, param2:Number, param3:Number, param4:int = 16711680, param5:int = -1, param6:Number = 0) : Sprite
        {
            var _loc_7:* = new Sprite();
            if (param5 > 0)
            {
                _loc_7.graphics.lineStyle(2, param5);
            }
            if (param4 > 0)
            {
                _loc_7.graphics.beginFill(param4);
            }
            _loc_7.graphics.drawCircle(param1, param2, param3);
            _loc_7.alpha = param6;
            _loc_7.buttonMode = true;
            _loc_7.useHandCursor = false;
            return _loc_7;
        }// end function

        public static function creatRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = 16711680, param6:int = -1, param7:Number = 0) : Sprite
        {
            var _loc_8:* = new Sprite();
            if (param6 >= 0)
            {
                _loc_8.graphics.lineStyle(2, param6);
            }
            if (param5 >= 0)
            {
                _loc_8.graphics.beginFill(param5);
            }
            _loc_8.graphics.drawRect(param1, param2, param3, param4);
            _loc_8.alpha = param7;
            _loc_8.buttonMode = true;
            _loc_8.useHandCursor = false;
            return _loc_8;
        }// end function

        public static function reverseString(param1:String) : String
        {
            var _loc_2:* = param1.split("");
            _loc_2.reverse();
            var _loc_3:* = _loc_2.join("");
            return _loc_3;
        }// end function

        public static function paserTime(param1:uint) : Date
        {
            var _loc_2:* = new Date(param1 * 1000);
            return _loc_2;
        }// end function

        public static function parseSecond2Date(param1:uint) : String
        {
            var _loc_2:* = new Date(param1 * 1000);
            var _loc_3:* = _loc_2.getUTCFullYear();
            var _loc_4:* = _loc_2.getUTCMonth() + 1;
            var _loc_5:* = _loc_2.getUTCDate();
            var _loc_6:* = _loc_2.getHours();
            var _loc_7:* = _loc_2.getMinutes();
            var _loc_8:* = _loc_2.getSeconds();
            return _loc_3 + "-" + _loc_4 + "-" + _loc_5 + " " + _loc_6 + ":" + _loc_7 + ":" + _loc_8;
        }// end function

        public static function parseSecond3Date(param1:uint) : String
        {
            var _loc_2:* = new Date(param1 * 1000);
            var _loc_3:* = _loc_2.getUTCFullYear();
            var _loc_4:* = _loc_2.getUTCMonth() + 1;
            var _loc_5:* = _loc_2.date;
            var _loc_6:* = _loc_2.getHours();
            var _loc_7:* = _loc_2.getMinutes();
            var _loc_8:* = _loc_2.getSeconds();
            return _loc_3 + "-" + _loc_4 + "-" + _loc_5 + " " + _loc_6 + ":" + _loc_7 + ":" + _loc_8;
        }// end function

        public static function parseString2Time(param1:String) : Number
        {
            var _loc_2:* = param1.split(" ");
            var _loc_3:* = _loc_2[0].split("-");
            var _loc_4:* = _loc_2[1].split(":");
            var _loc_5:* = new Date(int(_loc_3[0]), (int(_loc_3[1]) - 1), int(_loc_3[2]), int(_loc_4[0]), int(_loc_4[1]), int(_loc_4[2]));
            return _loc_5.time;
        }// end function

        public static function getDate() : String
        {
            var _loc_1:* = new Date();
            var _loc_2:* = _loc_1.getUTCFullYear();
            var _loc_3:* = _loc_1.getUTCMonth() + 1;
            var _loc_4:* = _loc_1.getUTCDate();
            var _loc_5:* = _loc_1.getHours();
            var _loc_6:* = _loc_1.getMinutes();
            var _loc_7:* = _loc_1.getSeconds();
            return _loc_2 + "-" + _loc_3 + "-" + _loc_4 + " " + _loc_5 + ":" + _loc_6 + ":" + _loc_7;
        }// end function

        public static function formatDateToString(param1:Date) : String
        {
            var _loc_2:* = param1.getUTCFullYear();
            var _loc_3:* = param1.getUTCMonth() + 1;
            var _loc_4:* = param1.getUTCDate();
            var _loc_5:* = param1.getHours();
            var _loc_6:* = param1.getMinutes();
            var _loc_7:* = param1.getSeconds();
            return _loc_2 + "-" + add0(_loc_3) + "-" + add0(_loc_4) + " " + add0(_loc_5) + ":" + add0(_loc_6) + ":" + add0(_loc_7);
        }// end function

        public static function getLogDateByServer() : String
        {
            return getLogDate(getServerTime());
        }// end function

        public static function getWeekSec(param1:Date = null) : uint
        {
            if (!param1)
            {
                param1 = new Date();
                param1.setTime(getServerTime());
            }
            return param1.seconds + param1.day * 86400 + param1.hours * 3600 + param1.minutes * 60;
        }// end function

        public static function getDaySec(param1:Date = null) : uint
        {
            if (!param1)
            {
                param1 = new Date();
                param1.setTime(getServerTime());
            }
            return param1.seconds + param1.hours * 3600 + param1.minutes * 60;
        }// end function

        public static function getServerTime() : Number
        {
            return new Date().time + timeOffset;
        }// end function

        public static function getServerDate() : Date
        {
            var _loc_1:* = new Date();
            _loc_1.setTime(getServerTime());
            return _loc_1;
        }// end function

        public static function getLogDate(param1:Number = 0) : String
        {
            var _loc_2:* = new Date();
            if (param1 > 0)
            {
                _loc_2.setTime(param1);
            }
            var _loc_3:* = _loc_2.getFullYear();
            var _loc_4:* = _loc_2.getMonth() + 1;
            var _loc_5:* = _loc_2.getDate();
            var _loc_6:* = _loc_2.getHours();
            var _loc_7:* = _loc_2.getMinutes();
            var _loc_8:* = _loc_2.getSeconds();
            var _loc_9:* = _loc_2.getMilliseconds();
            return "[" + _loc_3 + "-" + add0(_loc_4) + "-" + add0(_loc_5) + " " + add0(_loc_6) + ":" + add0(_loc_7) + ":" + add0(_loc_8) + "." + add0(_loc_9, 3) + "]";
        }// end function

        public static function getLastLoginTime(param1:Number) : String
        {
            if (param1 <= 0)
            {
                return LanguageCfgObj.getInstance().getByIndex("10011");
            }
            var _loc_2:* = new Date();
            var _loc_3:* = _loc_2.time / 60000;
            _loc_2.setTime(param1);
            var _loc_4:* = _loc_2.time / 60000;
            var _loc_5:* = _loc_3 - _loc_4;
            if (_loc_3 - _loc_4 < 0)
            {
                return LanguageCfgObj.getInstance().getByIndex("10011");
            }
            if (_loc_5 < 60)
            {
                return LanguageCfgObj.getInstance().getByIndex("10013");
            }
            if (_loc_5 < 60 * 24)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11767"), [int(_loc_5 / 60)]);
            }
            if (_loc_5 < 60 * 24 * 30)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11768"), [int(_loc_5 / 60 / 24)]);
            }
            if (_loc_5 < 60 * 24 * 365)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11769"), [int(_loc_5 / 60 / 24 / 30)]);
            }
            return LanguageCfgObj.getInstance().getByIndex("10014");
        }// end function

        public static function getLastLoginTime2(param1:Number) : String
        {
            if (param1 <= 0)
            {
                return LanguageCfgObj.getInstance().getByIndex("10011");
            }
            var _loc_2:* = new Date();
            var _loc_3:* = getServerTime() / 60000;
            _loc_2.setTime(param1);
            var _loc_4:* = _loc_2.time / 60000;
            var _loc_5:* = _loc_3 - _loc_4;
            if (_loc_3 - _loc_4 < 0)
            {
                return LanguageCfgObj.getInstance().getByIndex("10011");
            }
            if (_loc_5 < 1)
            {
                return LanguageCfgObj.getInstance().getByIndex("10017");
            }
            if (_loc_5 < 30)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11770"), [_loc_5]);
            }
            if (_loc_5 < 60)
            {
                return LanguageCfgObj.getInstance().getByIndex("10018");
            }
            if (_loc_5 < 60 * 24)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11771"), [int(_loc_5 / 60)]);
            }
            if (_loc_5 < 60 * 24 * 7)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11772"), [int(_loc_5 / 60 / 24)]);
            }
            if (_loc_5 < 60 * 24 * 30)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11773"), [int(_loc_5 / 60 / 24 / 7)]);
            }
            if (_loc_5 < 60 * 24 * 365)
            {
                return StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11774"), [int(_loc_5 / 60 / 24 / 30)]);
            }
            return LanguageCfgObj.getInstance().getByIndex("10019");
        }// end function

        public static function getFormatDate(param1:Number = 0, param2:String = "YMDhmsS") : String
        {
            var _loc_3:* = new Date();
            if (param1 > 0)
            {
                _loc_3.setTime(param1);
            }
            var _loc_4:* = _loc_3.getFullYear();
            var _loc_5:* = _loc_3.getMonth() + 1;
            var _loc_6:* = _loc_3.getDate();
            var _loc_7:* = _loc_3.getHours();
            var _loc_8:* = _loc_3.getMinutes();
            var _loc_9:* = _loc_3.getSeconds();
            var _loc_10:* = _loc_3.getMilliseconds();
            var _loc_11:* = "";
            if (param2.indexOf("Y") >= 0)
            {
                _loc_11 = _loc_11 + _loc_4;
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11563")) >= 0)
            {
                _loc_11 = _loc_11 + (_loc_4 + LanguageCfgObj.getInstance().getByIndex("11563"));
            }
            if (param2.indexOf("M") >= 0)
            {
                _loc_11 = _loc_11 + ((param2.indexOf("Y") >= 0 ? ("-") : ("")) + add0(_loc_5));
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11564")) >= 0)
            {
                _loc_11 = _loc_11 + (add0(_loc_5) + LanguageCfgObj.getInstance().getByIndex("11564"));
            }
            if (param2.indexOf("D") >= 0)
            {
                _loc_11 = _loc_11 + ("-" + add0(_loc_6));
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11565")) >= 0)
            {
                _loc_11 = _loc_11 + (add0(_loc_6) + LanguageCfgObj.getInstance().getByIndex("11565"));
            }
            if (param2.indexOf("h") >= 0)
            {
                _loc_11 = _loc_11 + (" " + add0(_loc_7));
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11566")) >= 0)
            {
                _loc_11 = _loc_11 + (add0(_loc_7) + LanguageCfgObj.getInstance().getByIndex("11566"));
            }
            if (param2.indexOf("m") >= 0)
            {
                _loc_11 = _loc_11 + ((param2.indexOf("h") >= 0 ? (":") : ("")) + add0(_loc_8));
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11567")) >= 0)
            {
                _loc_11 = _loc_11 + (add0(_loc_8) + LanguageCfgObj.getInstance().getByIndex("11567"));
            }
            if (param2.indexOf("s") >= 0)
            {
                _loc_11 = _loc_11 + ((param2.indexOf("m") >= 0 ? (":") : ("")) + add0(_loc_9));
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("11552")) >= 0)
            {
                _loc_11 = _loc_11 + (add0(_loc_8) + LanguageCfgObj.getInstance().getByIndex("11552"));
            }
            if (param2.indexOf("S") >= 0)
            {
                _loc_11 = _loc_11 + ((param2.indexOf("s") >= 0 ? (".") : ("")) + add0(_loc_10, 3));
            }
            return _loc_11;
        }// end function

        public static function millsecond2TimeStr(param1:int) : String
        {
            var _loc_3:* = 0;
            if (param1 < 0)
            {
                return "";
            }
            var _loc_2:* = param1;
            var _loc_4:* = "";
            _loc_3 = _loc_2 / 60000;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            _loc_4 = _loc_4 + ":";
            _loc_2 = _loc_2 % 60000;
            _loc_3 = _loc_2 / 1000;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            _loc_2 = _loc_2 % 1000;
            _loc_4 = _loc_4 + ":";
            _loc_3 = _loc_2 / 10;
            _loc_4 = _loc_4 + (_loc_3 < 10 ? ("0" + _loc_3) : (_loc_3.toString()));
            return _loc_4;
        }// end function

        public static function second2CountDown(param1:uint) : String
        {
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_2:* = param1;
            var _loc_4:* = "";
            var _loc_5:* = param1 / 86400;
            if (param1 / 86400 > 0)
            {
                _loc_4 = _loc_5 + LanguageCfgObj.getInstance().getByIndex("11569");
            }
            else
            {
                _loc_6 = param1 / 3600;
                if (_loc_6 > 0)
                {
                    _loc_4 = _loc_6 + LanguageCfgObj.getInstance().getByIndex("11570");
                }
                else
                {
                    _loc_7 = param1 / 60;
                    if (_loc_7 > 0)
                    {
                        _loc_4 = _loc_7 + LanguageCfgObj.getInstance().getByIndex("10024");
                    }
                    _loc_8 = param1 % 60;
                    _loc_4 = _loc_4 + (_loc_8 + LanguageCfgObj.getInstance().getByIndex("10025"));
                }
            }
            return _loc_4;
        }// end function

        public static function second3CountDown(param1:uint) : String
        {
            var _loc_3:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = param1;
            var _loc_4:* = "";
            var _loc_5:* = param1 / 3600;
            if (param1 / 3600 > 0)
            {
                _loc_4 = _loc_5 + LanguageCfgObj.getInstance().getByIndex("11570");
            }
            else
            {
                _loc_6 = param1 / 60;
                if (_loc_6 > 0)
                {
                    _loc_4 = _loc_6 + LanguageCfgObj.getInstance().getByIndex("10024");
                }
                _loc_7 = param1 % 60;
                _loc_4 = _loc_4 + (_loc_7 + LanguageCfgObj.getInstance().getByIndex("10025"));
            }
            return _loc_4;
        }// end function

        public static function second2TimeStr(param1:uint, param2:String = "hms") : String
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_3:* = "";
            var _loc_4:* = -1;
            var _loc_5:* = -1;
            var _loc_6:* = -1;
            var _loc_7:* = -1;
            if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10026")) >= 0 || param2.indexOf("d") >= 0)
            {
                _loc_7 = int(param1 / 86400);
                _loc_4 = int((param1 - _loc_7 * 86400) / 3600);
                _loc_5 = int((param1 - _loc_7 * 86400 - 3600 * _loc_4) / 60);
                _loc_6 = param1 - (86400 * _loc_7 + 3600 * _loc_4 + _loc_5 * 60);
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10027")) >= 0 || param2.indexOf("h") >= 0)
            {
                _loc_4 = int(param1 / 3600);
                _loc_5 = int((param1 - _loc_4 * 3600) / 60);
                _loc_6 = param1 - 3600 * _loc_4 - 60 * _loc_5;
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10028")) >= 0 || param2.indexOf("m") >= 0)
            {
                _loc_5 = int(param1 / 60);
                _loc_6 = param1 - 60 * _loc_5;
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10029")) >= 0 || param2.indexOf("s") >= 0)
            {
                _loc_6 = param1;
            }
            if (param2.indexOf("d") >= 0)
            {
                if (_loc_7 > 0)
                {
                    _loc_3 = _loc_3 + (_loc_7 + LanguageCfgObj.getInstance().getByIndex("10026"));
                }
            }
            else if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10026")) >= 0)
            {
                if (_loc_7 > 0)
                {
                    _loc_3 = _loc_3 + (_loc_7 + LanguageCfgObj.getInstance().getByIndex("10026"));
                }
            }
            if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10027")) >= 0)
            {
                if (_loc_4 > 0)
                {
                    _loc_3 = _loc_3 + (_loc_4 + LanguageCfgObj.getInstance().getByIndex("10027"));
                }
            }
            else if (param2.indexOf("h") >= 0)
            {
                _loc_3 = _loc_3 + add0(_loc_4);
            }
            if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10028")) >= 0)
            {
                if (_loc_5 > 0)
                {
                    _loc_3 = _loc_3 + (add0(_loc_5) + LanguageCfgObj.getInstance().getByIndex("10028"));
                }
            }
            else if (param2.indexOf("m") >= 0)
            {
                _loc_3 = _loc_3 + ((_loc_4 > -1 ? (":") : ("")) + add0(_loc_5));
            }
            if (param2.indexOf(LanguageCfgObj.getInstance().getByIndex("10025")) >= 0)
            {
                if (_loc_6)
                {
                    _loc_3 = _loc_3 + (add0(_loc_6) + LanguageCfgObj.getInstance().getByIndex("10025"));
                }
            }
            else if (param2.indexOf("s") >= 0)
            {
                _loc_3 = _loc_3 + ((_loc_5 > -1 ? (":") : ("")) + add0(_loc_6));
            }
            return _loc_3;
        }// end function

        public static function getTimeBySecond(param1:uint) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = new Date(param1 * 1000);
            _loc_2 = _loc_2 + (add0(_loc_3.hoursUTC) + ":");
            _loc_2 = _loc_2 + (add0(_loc_3.minutes) + ":");
            _loc_2 = _loc_2 + add0(_loc_3.seconds);
            return _loc_2;
        }// end function

        public static function getTimeBySecond2(param1:Number) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = new Date(Number(param1 * 1000));
            _loc_2 = _loc_2 + (add0(_loc_3.hours) + ":");
            _loc_2 = _loc_2 + (add0(_loc_3.minutes) + ":");
            _loc_2 = _loc_2 + add0(_loc_3.seconds);
            return _loc_2;
        }// end function

        public static function marquee(param1:String, param2:TextField, param3:Number = 500) : void
        {
            var t:Timer;
            var __st:Function;
            var __en:Function;
            var s1:String;
            var s2:String;
            var __timer:Function;
            var str:* = param1;
            var textField:* = param2;
            var inter:* = param3;
            __st = function (event:MouseEvent) : void
            {
                trace("开始滚动");
                t.start();
                return;
            }// end function
            ;
            __en = function (event:MouseEvent) : void
            {
                textField.text = str;
                s2 = s1;
                t.stop();
                return;
            }// end function
            ;
            __timer = function (event:TimerEvent) : void
            {
                if (s2 != "")
                {
                    s2 = s2.slice(1, s2.length);
                }
                else
                {
                    s2 = s1;
                }
                textField.text = s2;
                return;
            }// end function
            ;
            t = new Timer(inter, 0);
            t.addEventListener(TimerEvent.TIMER, __timer, false, 0, true);
            textField.addEventListener(MouseEvent.ROLL_OVER, __st, false, 0, true);
            textField.addEventListener(MouseEvent.ROLL_OUT, __en, false, 0, true);
            textField.text = str;
            s1 = str;
            s2 = str;
            return;
        }// end function

        public static function cloneObject(param1:Object)
        {
            if (!param1)
            {
                return null;
            }
            var _loc_2:* = getQualifiedClassName(param1);
            var _loc_3:* = _loc_2.split("::")[0];
            var _loc_4:* = getDefinitionByName(_loc_2) as Class;
            registerClassAlias(_loc_3, _loc_4);
            var _loc_5:* = new ByteArray();
            _loc_5.writeObject(param1);
            _loc_5.position = 0;
            return _loc_5.readObject();
        }// end function

        public static function Vector2Array(param1, param2:uint) : Array
        {
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            while (_loc_4 < param2)
            {
                
                _loc_3[_loc_4] = param1[_loc_4];
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function splitText(param1:String, param2:uint = 20) : String
        {
            var _loc_3:* = "";
            var _loc_4:* = Math.ceil(param1.length / param2);
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = _loc_3 + (param1.substr(_loc_5 * param2, param2) + "\n");
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public static function getMoneyString(param1:Number) : String
        {
            param1 = param1 >> 0;
            var _loc_2:* = "" + param1;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = Math.ceil(_loc_3 / 3);
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < (_loc_4 - 1))
            {
                
                _loc_5.unshift(_loc_2.substr(_loc_3 - (1 + _loc_6) * 3, 3));
                _loc_6++;
            }
            _loc_5.unshift(_loc_2.substr(0, 3 - (_loc_4 * 3 - _loc_3)));
            return _loc_5.join(",");
        }// end function

        public static function getMoneyStringByString(param1:String) : String
        {
            var _loc_2:* = "" + param1;
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = Math.ceil(_loc_3 / 3);
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (_loc_6 < (_loc_4 - 1))
            {
                
                _loc_5.unshift(_loc_2.substr(_loc_3 - (1 + _loc_6) * 3, 3));
                _loc_6++;
            }
            _loc_5.unshift(_loc_2.substr(0, 3 - (_loc_4 * 3 - _loc_3)));
            return _loc_5.join(",");
        }// end function

        public static function getAngle(param1:Number, param2:Number, param3:Number, param4:Number) : int
        {
            var _loc_5:* = param3 - param1;
            var _loc_6:* = param4 - param2;
            var _loc_7:* = Math.sqrt(_loc_5 * _loc_5 + _loc_6 * _loc_6);
            var _loc_8:* = _loc_5 / _loc_7;
            var _loc_9:* = int(Math.floor(Math.acos(_loc_8) * 180 / Math.PI));
            if (_loc_6 < 0)
            {
                _loc_9 = 360 - _loc_9;
            }
            return _loc_9;
        }// end function

        public static function bringToTop(param1:DisplayObject) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1.parent;
            if (_loc_2)
            {
                _loc_3 = _loc_2.numChildren - 1;
                if (_loc_2.getChildIndex(param1) != _loc_3)
                {
                    _loc_2.setChildIndex(param1, _loc_3);
                }
            }
            return;
        }// end function

        public static function autoGC() : void
        {
            var _loc_1:* = new Timer(5 * 60 * 1000);
            _loc_1.addEventListener(TimerEvent.TIMER, forceGC);
            _loc_1.start();
            return;
        }// end function

        public static function forceGC(event:Event = null) : void
        {
            gc();
            setTimeout(gc, 5000);
            return;
        }// end function

        public static function gc() : void
        {
            try
            {
                new LocalConnection().connect("MicahSun forceGC");
                new LocalConnection().connect("MicahSun forceGC");
            }
            catch (e2:Error)
            {
            }
            return;
        }// end function

        public static function hasChildInArray(param1:DisplayObjectContainer, param2:Array) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_4 in param2)
            {
                
                _loc_3 = _loc_4.parent;
                while (_loc_3)
                {
                    
                    if (_loc_3 == param1)
                    {
                        return true;
                    }
                    _loc_3 = _loc_3.parent;
                }
            }
            return false;
        }// end function

        public static function htmlspecialchars(param1:String) : String
        {
            param1 = param1.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&apos;").replace(/"/g, "&quot;");
            return param1;
        }// end function

        public static function shine(param1:DisplayObject, param2:uint = 16773120) : void
        {
            if (param1 != null)
            {
                param1.filters = [new GlowFilter(param2, 0.8, 5, 5, 5)];
            }
            return;
        }// end function

        public static function isTrueInLine(param1:uint, param2:uint) : Boolean
        {
            return (param1 & param2) != 0;
        }// end function

        public static function isTrueAtPos(param1:uint, param2:uint) : Boolean
        {
            return (param1 >> param2 & 1) == 1;
        }// end function

        public static function setTrueAtPos(param1:uint, param2:uint, param3:Boolean) : uint
        {
            if (isTrueAtPos(param1, param2) == param3)
            {
                return param1;
            }
            return param1 ^ 1 << param2;
        }// end function

        public static function getPingColor(param1:uint) : uint
        {
            if (param1 == 0)
            {
                return 13421772;
            }
            if (param1 < 200)
            {
                return 65280;
            }
            if (param1 < 600)
            {
                return 13434624;
            }
            if (param1 < 1200)
            {
                return 16737792;
            }
            return 16711680;
        }// end function

        public static function getTipColorStr(param1:uint) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case 2:
                {
                    _loc_2 = "3399ff";
                    break;
                }
                case 3:
                {
                    _loc_2 = "a335ee";
                    break;
                }
                case 4:
                {
                    _loc_2 = "ff8888";
                    break;
                }
                case 5:
                {
                    _loc_2 = "e9b137";
                    break;
                }
                case 6:
                {
                    _loc_2 = "00bb00";
                    break;
                }
                case 7:
                {
                    _loc_2 = "ff0000";
                    break;
                }
                case 1:
                {
                    _loc_2 = "00FF00";
                    break;
                }
                default:
                {
                    _loc_2 = "ffffff";
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getTipColor(param1:uint, param2:Boolean = false) : uint
        {
            var _loc_3:* = 0;
            switch(param1)
            {
                case 2:
                {
                    _loc_3 = 3381759;
                    break;
                }
                case 3:
                {
                    _loc_3 = 10696174;
                    break;
                }
                case 4:
                {
                    _loc_3 = 16746632;
                    break;
                }
                case 5:
                {
                    _loc_3 = 15315255;
                    break;
                }
                case 6:
                {
                    _loc_3 = 47872;
                    break;
                }
                case 7:
                {
                    _loc_3 = 16711680;
                    break;
                }
                case 1:
                {
                    _loc_3 = 65280;
                    break;
                }
                default:
                {
                    _loc_3 = 16777215;
                    break;
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function getColorFilter(param1:uint = 0) : GlowFilter
        {
            if (param1 == 0)
            {
                return null;
            }
            var _loc_2:* = colorFilters[param1];
            if (_loc_2 == null)
            {
                _loc_2 = new GlowFilter(getTipColor(param1), param1 == 0 || param1 == 1 ? (0.6) : (0.8), 5, 5, 3, 3, true);
                colorFilters[param1] = _loc_2;
            }
            return _loc_2;
        }// end function

        public static function removeElementOfArray(param1, param2)
        {
            var _loc_3:* = param1.indexOf(param2);
            if (_loc_3 != -1)
            {
                param1.splice(_loc_3, 1);
            }
            return param1;
        }// end function

        public static function add0(param1:Number, param2:int = 2) : String
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (param2 == 2)
            {
                return (param1 > 9 ? ("") : ("0")) + param1;
            }
            else
            {
                _loc_3 = param1 + "";
                _loc_4 = param2 - _loc_3.length;
                if (_loc_4 > 0)
                {
                    return ZEROS.substr(0, _loc_4) + _loc_3;
                }
                return _loc_3;
            }
        }// end function

        public static function saveXiaoShu(param1:Number, param2:uint) : Number
        {
            return Math.round(param1 * param2 * 10) / (param2 * 10);
        }// end function

        public static function getSpliceStr(param1:uint, param2:uint = 100000) : String
        {
            var _loc_3:* = "";
            if (param1 > param2)
            {
                param1 = uint(param1 / 10000);
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10030");
            }
            return param1 + _loc_3;
        }// end function

        public static function getUintStr(param1:Number) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_2:* = param1.toString();
            var _loc_3:* = "";
            var _loc_4:* = 0;
            if (_loc_2.length >= 9)
            {
                _loc_4 = _loc_2.length - 8;
                _loc_6 = param1 * 1e-008;
                if (_loc_6 >= 1000)
                {
                    _loc_5 = getMoneyString(_loc_6);
                }
                else
                {
                    _loc_5 = int(param1 * 1e-008).toString();
                }
                _loc_3 = _loc_5 + LanguageCfgObj.getInstance().getByIndex("11783");
            }
            else if (_loc_2.length > 4)
            {
                _loc_6 = param1 * 0.0001;
                if (_loc_6 >= 1000)
                {
                    _loc_5 = getMoneyString(_loc_6);
                }
                else
                {
                    _loc_5 = int(param1 * 0.0001).toString();
                }
                _loc_3 = _loc_5 + LanguageCfgObj.getInstance().getByIndex("11782");
            }
            else
            {
                _loc_3 = ToolKit.getMoneyString(int(_loc_2));
            }
            return _loc_3;
        }// end function

        public static function getUint64Str(param1:String) : String
        {
            var _loc_2:* = param1;
            var _loc_3:* = "";
            var _loc_4:* = 0;
            if (_loc_2.length >= 9)
            {
                _loc_4 = _loc_2.length - 8;
                _loc_3 = _loc_2.substr(0, _loc_4) + LanguageCfgObj.getInstance().getByIndex("11783");
                _loc_2 = _loc_2.substr(_loc_4);
                _loc_4 = _loc_2.length - 4;
                _loc_2 = _loc_2.substr(0, _loc_4);
                if (parseInt(_loc_2) != 0)
                {
                    _loc_3 = _loc_3 + (parseInt(_loc_2) + LanguageCfgObj.getInstance().getByIndex("11782"));
                }
            }
            else if (_loc_2.length >= 4)
            {
                _loc_4 = _loc_2.length - 4;
                _loc_3 = _loc_2.substr(0, _loc_4) + LanguageCfgObj.getInstance().getByIndex("11782");
            }
            else if (_loc_2.length == 0)
            {
                _loc_3 = "0";
            }
            return _loc_3;
        }// end function

        public static function getMCInLine(param1:uint, param2:String, param3:uint) : HBox
        {
            var _loc_5:* = 0;
            var _loc_4:* = new HBox();
            _loc_4.horizontal = true;
            _loc_4.intervalX = param3;
            while (_loc_5 < param1)
            {
                
                _loc_4.add(getNew(param2));
                _loc_5++;
            }
            return _loc_4;
        }// end function

        public static function get isInputTextField() : Boolean
        {
            var _loc_1:* = FrameworkGlobal.stage.focus;
            return _loc_1 is TextField && (_loc_1 as TextField).type == "input";
        }// end function

        public static function trimDistrict(param1:String) : String
        {
            param1 = param1.replace(/s.*?\./, "");
            return param1;
        }// end function

        public static function bmdScale(param1:BitmapData, param2:Number) : BitmapData
        {
            if (param2 == 1)
            {
                return param1;
            }
            var _loc_3:* = new BitmapData(Math.round(param1.width * param2), Math.round(param1.height * param2), true, 0);
            var _loc_4:* = new Matrix(param2, 0, 0, param2);
            _loc_3.draw(param1, _loc_4, null, null, null, true);
            return _loc_3;
        }// end function

        public static function checkRoleName(param1:String) : String
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = "";
            if (_loc_2 < 2)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10031");
                return _loc_3;
            }
            if (_loc_2 > 7)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10032");
                return _loc_3;
            }
            if (param1.substr(0, 1) == "_" || param1.substr((param1.length - 1), 1) == "_")
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10033");
                return _loc_3;
            }
            if (param1.indexOf("　") >= 0)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10034");
                return _loc_3;
            }
            if (param1.indexOf(" ") >= 0)
            {
                _loc_3 = LanguageCfgObj.getInstance().getByIndex("10035");
                return _loc_3;
            }
            return _loc_3;
        }// end function

        public static function getPointInRect(param1:Rectangle) : Array
        {
            return [param1.x + Math.random() * param1.width, param1.y + Math.random() * param1.height];
        }// end function

        public static function getPointBackPoint(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number) : Point
        {
            var _loc_6:* = distance(param4, param5, param2, param3);
            if (distance(param4, param5, param2, param3) == 0)
            {
                _loc_6 = 1;
            }
            return Point.interpolate(new Point(param2, param3), new Point(param4, param5), (-param1) / _loc_6);
        }// end function

        public static function toPassword(param1:String) : String
        {
            return "**" + param1.substr(2, param1.length);
        }// end function

        public static function disappear(param1:DisplayObject) : void
        {
            if (param1 && param1.parent)
            {
                param1.parent.removeChild(param1);
            }
            return;
        }// end function

        public static function createText(param1:int = 12, param2:int = 215, param3:int = 0, param4:uint = 16766079, param5:Boolean = true, param6:Boolean = true, param7:Boolean = false, param8:Boolean = false) : TextField
        {
            var _loc_9:* = new TextField();
            var _loc_10:* = _loc_9.defaultTextFormat;
            _loc_10.size = param1;
            _loc_10.leading = 4;
            _loc_10.font = "Simsun";
            _loc_9.filters = [FrameworkGlobal.BLACK_FILTER];
            _loc_9.autoSize = TextFieldAutoSize.NONE;
            _loc_9.multiline = param5;
            _loc_9.wordWrap = param6;
            if (param2 != 0)
            {
                _loc_9.width = param2;
            }
            if (param3 != 0)
            {
                _loc_9.height = param3;
            }
            _loc_9.mouseEnabled = param7;
            _loc_9.defaultTextFormat = _loc_10;
            _loc_9.selectable = param8;
            _loc_9.textColor = param4;
            return _loc_9;
        }// end function

    }
}
