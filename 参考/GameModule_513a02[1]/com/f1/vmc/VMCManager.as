package com.f1.vmc
{
    import com.f1.manager.timer.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.sampler.*;
    import flash.system.*;
    import flash.utils.*;

    public class VMCManager extends Object
    {
        public static var decodeBuffer:FunctionBuffer = new FunctionBuffer(1, true);
        private static var loaders:Dictionary = new Dictionary();
        private static var _down:Timer;
        private static var hasTimer:Boolean = false;
        private static var _needGC:Boolean;

        public function VMCManager()
        {
            return;
        }// end function

        public static function printSize() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_1:* = "";
            var _loc_4:* = [];
            var _loc_5:* = 0;
            for (_loc_2 in loaders)
            {
                
                _loc_5 = 0;
                _loc_6 = _loc_14[_loc_2].bmds;
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_5 = _loc_5 + getSize(_loc_7);
                }
                _loc_4.push({url:_loc_2, size:int(_loc_5 / 1024)});
                _loc_8 = _loc_8 + int(_loc_5 / 1024);
                if (_loc_2.indexOf("/skill/") != -1)
                {
                    _loc_9 = _loc_9 + int(_loc_5 / 1024);
                }
                if (_loc_2.indexOf("/mapres/") != -1)
                {
                    _loc_10 = _loc_10 + int(_loc_5 / 1024);
                }
                if (_loc_2.indexOf("/ms004/") != -1)
                {
                    _loc_11 = _loc_11 + int(_loc_5 / 1024);
                }
            }
            _loc_4.sort(numSort);
            trace("bitmapData总大小：" + _loc_8 + "kb");
            trace("技能总大小：" + _loc_9 + "kb");
            trace("ms004大小：" + _loc_11 + "kb");
            for each (_loc_12 in _loc_4)
            {
                
                trace(_loc_12.url + "  size:" + _loc_12.size + "kb");
            }
            return;
        }// end function

        private static function numSort(param1:Object, param2:Object) : int
        {
            return int(param2.size - param1.size);
        }// end function

        public static function checkAndGC(param1:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (System.totalMemory < 480000000)
            {
                _needGC = false;
                return;
            }
            var _loc_2:* = [];
            var _loc_3:* = getTimer();
            for each (_loc_4 in loaders)
            {
                
                if (!_loc_4.keep)
                {
                    if (_loc_4.instanceNum < 0)
                    {
                    }
                    if (_loc_4.instanceNum <= 0)
                    {
                        Log.log(_loc_4.url, "instanceNum <= 0，需要被finalize");
                        _loc_4.finalize();
                        _loc_2.push(_loc_4.url);
                    }
                }
            }
            if (_loc_2.length > 0)
            {
                _needGC = true;
                for each (_loc_5 in _loc_2)
                {
                    
                    loaders[_loc_5] = null;
                    delete loaders[_loc_5];
                }
                if (param1)
                {
                    ObjectPool.clearAll();
                    _needGC = false;
                }
            }
            return;
        }// end function

        private static function timer1() : void
        {
            checkAndGC();
            if (_needGC)
            {
                ObjectPool.clearAll();
                _needGC = false;
            }
            return;
        }// end function

        public static function initTime() : void
        {
            if (!hasTimer)
            {
                Ticker.registerTimer(30, timer1);
                hasTimer = true;
            }
            return;
        }// end function

        public static function addRes(param1:String, param2:Function = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:int = 0) : Boolean
        {
            initTime();
            if (!param1)
            {
                return false;
            }
            var _loc_8:* = loaders[param1];
            if (loaders[param1])
            {
                if (!_loc_8.keep)
                {
                    _loc_8.keep = param6;
                }
                if (_loc_8.loaded)
                {
                    doCompleteCallBack(param2, param3);
                    return false;
                }
                _loc_8.addCallBack(param2, param3, param4, param5);
            }
            else
            {
                _loc_8 = new VMCLoader(param2, param3, param4, param5);
                _loc_8.keep = param6;
                loaders[param1] = _loc_8;
            }
            _loc_8.loadRes(param1, param7);
            return true;
        }// end function

        public static function addKeep(param1:String) : void
        {
            var _loc_2:* = loaders[param1];
            if (_loc_2)
            {
                _loc_2.keep = true;
            }
            return;
        }// end function

        public static function clearRes() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            Log.log("VMCManager clearRes");
            var _loc_1:* = [];
            for each (_loc_2 in loaders)
            {
                
                if (!_loc_2.keep)
                {
                    _loc_2.finalize();
                    _loc_1.push(_loc_2.url);
                }
            }
            for each (_loc_3 in _loc_1)
            {
                
                loaders[_loc_3] = null;
                delete loaders[_loc_3];
            }
            return;
        }// end function

        public static function removeCallBack(param1:String, param2:Function, param3:Function = null, param4:Function = null, param5:Boolean = false) : void
        {
            var _loc_6:* = loaders[param1];
            if (loaders[param1])
            {
                if (_loc_6.loading)
                {
                    _loc_6.removeCallBack(param2, param3, param4, param5);
                }
            }
            return;
        }// end function

        public static function addInstance(param1:String) : void
        {
            var _loc_2:* = loaders[param1];
            if (!_loc_2)
            {
                _loc_2 = new VMCLoader(null);
                loaders[param1] = _loc_2;
            }
            _loc_2.lastUsedTime = getTimer();
            var _loc_3:* = _loc_2;
            var _loc_4:* = _loc_2.instanceNum + 1;
            _loc_3.instanceNum = _loc_4;
            return;
        }// end function

        public static function removeInstance(param1:String) : void
        {
            var _loc_2:* = loaders[param1];
            if (_loc_2)
            {
                var _loc_3:* = _loc_2;
                var _loc_4:* = _loc_2.instanceNum - 1;
                _loc_3.instanceNum = _loc_4;
                if (_loc_2.instanceNum < 0)
                {
                }
            }
            return;
        }// end function

        public static function getLoader(param1:String) : VMCLoader
        {
            return loaders[param1];
        }// end function

        public static function removeLoader(param1:String) : void
        {
            var _loc_2:* = loaders[param1];
            if (_loc_2)
            {
                _loc_2.finalize();
            }
            loaders[param1] = null;
            delete loaders[param1];
            return;
        }// end function

        public static function getBmd(param1:String, param2:String) : BitmapData
        {
            var _loc_3:* = loaders[param1];
            if (_loc_3)
            {
                return _loc_3.getBmd(param2);
            }
            return null;
        }// end function

        public static function isLoaded(param1:String) : Boolean
        {
            return loaders[param1] && VMCLoader(loaders[param1]).loaded;
        }// end function

        public static function isLoading(param1:String) : Boolean
        {
            return loaders[param1] && VMCLoader(loaders[param1]).loading;
        }// end function

        public static function getPoseInfo(param1:String, param2:String = "90") : PoseInfo
        {
            if (!param1)
            {
                return null;
            }
            var _loc_3:* = loaders[param1];
            if (_loc_3)
            {
                if (_loc_3.loaded)
                {
                    return _loc_3.getPoseInfo(param2);
                }
            }
            return null;
        }// end function

        private static function doCompleteCallBack(param1:Function, param2:Array) : void
        {
            if (param1 != null)
            {
                if (param2 == null)
                {
                    param1.apply(null);
                }
                else
                {
                    param1.apply(null, param2);
                }
            }
            return;
        }// end function

    }
}
