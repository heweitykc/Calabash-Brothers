package com.hexagonstar.util.debug
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    final public class Debug extends Object
    {
        public static const LEVEL_DEBUG:int = 0;
        public static const LEVEL_INFO:int = 1;
        public static const LEVEL_WARN:int = 2;
        public static const LEVEL_ERROR:int = 3;
        public static const LEVEL_FATAL:int = 4;
        private static var _filterLevel:int = 0;
        private static var _isConnected:Boolean = false;
        private static var _isPollingFPS:Boolean = false;
        private static var _isEnabled:Boolean = true;
        private static var _stage:Stage;
        private static var _connection:LocalConnection;
        private static var _fpsMeter:FPSMeter;
        private static var _stopWatch:StopWatch;

        public function Debug()
        {
            return;
        }// end function

        public static function trace(... args) : void
        {
            args = args[1] is int ? (args[1]) : (1);
            if (args >= _filterLevel && args < 7)
            {
                send("onData", args[0], args, 0);
            }
            return;
        }// end function

        public static function traceObj(param1:Object, param2:int = 64, param3:int = 1) : void
        {
            if (param3 >= _filterLevel && param3 < 7)
            {
                send("onData", param1, param3, param2);
            }
            return;
        }// end function

        public static function inspect(param1:Object) : void
        {
            send("onInspect", param1, 1, -1);
            return;
        }// end function

        public static function hexDump(param1:Object) : void
        {
            send("onHexDump", param1, 0, 0);
            return;
        }// end function

        public static function forceGC() : void
        {
            try
            {
            }
            catch (e1:Error)
            {
                try
                {
                    new LocalConnection().connect("forceGC");
                    new LocalConnection().connect("forceGC");
                }
                catch (e2:Error)
                {
                }
                return;
        }// end function

        public static function clear() : void
        {
            Debug.trace("[%CLR%]", 5);
            return;
        }// end function

        public static function delimiter() : void
        {
            Debug.trace("[%DLT%]", 5);
            return;
        }// end function

        public static function pause() : void
        {
            Debug.trace("[%PSE%]", 5);
            return;
        }// end function

        public static function time() : void
        {
            Debug.trace("[%TME%]", 5);
            return;
        }// end function

        public static function monitor(param1:Stage, param2:int = 500) : void
        {
            if (_isPollingFPS)
            {
                Debug.stop();
            }
            if (_isEnabled && !_fpsMeter)
            {
                _isPollingFPS = true;
                _stage = param1;
                sendCapabilities();
                _fpsMeter = new FPSMeter(_stage, param2);
                _fpsMeter.addEventListener(FPSMeter.FPS_UPDATE, onFPSUpdate);
                _fpsMeter.start();
            }
            return;
        }// end function

        public static function mark(param1:uint = 16711935) : void
        {
            send("onMarker", param1, 1, -1);
            return;
        }// end function

        public static function stop() : void
        {
            if (_fpsMeter)
            {
                _isPollingFPS = false;
                _fpsMeter.stop();
                _fpsMeter.removeEventListener(FPSMeter.FPS_UPDATE, onFPSUpdate);
                _fpsMeter = null;
                _stage = null;
            }
            return;
        }// end function

        public static function timerStart(param1:String = "") : void
        {
            if (_isEnabled)
            {
                if (!_stopWatch)
                {
                    _stopWatch = new StopWatch();
                }
                _stopWatch.start(param1);
            }
            return;
        }// end function

        public static function timerStop() : void
        {
            if (_stopWatch)
            {
                _stopWatch.stop();
            }
            return;
        }// end function

        public static function timerReset() : void
        {
            if (_stopWatch)
            {
                _stopWatch.reset();
            }
            return;
        }// end function

        public static function timerInMilliSeconds() : void
        {
            if (_stopWatch)
            {
                Debug.trace(_stopWatch.timeInMilliSeconds + "ms");
            }
            return;
        }// end function

        public static function timerInSeconds() : void
        {
            if (_stopWatch)
            {
                Debug.trace(_stopWatch.timeInSeconds + "s");
            }
            return;
        }// end function

        public static function timerToString() : void
        {
            if (_stopWatch)
            {
                Debug.trace(_stopWatch.toString());
            }
            return;
        }// end function

        public static function timerStopToString(param1:Boolean = false) : void
        {
            if (_stopWatch)
            {
                _stopWatch.stop();
                Debug.trace(_stopWatch.toString());
                if (param1)
                {
                    _stopWatch.reset();
                }
            }
            return;
        }// end function

        public static function get filterLevel() : int
        {
            return _filterLevel;
        }// end function

        public static function set filterLevel(param1:int) : void
        {
            if (param1 >= 0 && param1 < 5)
            {
                _filterLevel = param1;
            }
            return;
        }// end function

        public static function get enabled() : Boolean
        {
            return _isEnabled;
        }// end function

        public static function set enabled(param1:Boolean) : void
        {
            _isEnabled = param1;
            return;
        }// end function

        private static function onFPSUpdate(event:Event) : void
        {
            send("onFPS", _fpsMeter.fps + "," + _stage.frameRate + "," + _fpsMeter.frt + "," + System.totalMemory);
            return;
        }// end function

        private static function onStatus(event:StatusEvent) : void
        {
            return;
        }// end function

        private static function send(param1:String, param2, param3:int = 1, param4:int = 0) : void
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            if (_isEnabled)
            {
                if (!_isConnected)
                {
                    _isConnected = true;
                    _connection = new LocalConnection();
                    _connection.addEventListener(StatusEvent.STATUS, onStatus);
                }
                _loc_5 = 0;
                if (typeof(param2) == "string")
                {
                    _loc_5 = String(param2).length;
                }
                else if (typeof(param2) == "object")
                {
                    _loc_6 = new ByteArray();
                    _loc_6.writeObject(param2);
                    _loc_5 = _loc_6.length;
                    _loc_6 = null;
                }
                if (_loc_5 > 39000)
                {
                    storeDataLSO(param1, param2);
                    param1 = "onLargeData";
                    param2 = null;
                }
                _connection.send("_alcon_lc", param1, param2, param3, param4, "");
            }
            return;
        }// end function

        private static function sendCapabilities() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = describeType(Capabilities);
            var _loc_2:* = [];
            for each (_loc_3 in _loc_1.*)
            {
                
                _loc_4 = _loc_3.@name.toString();
                if (_loc_4.length > 0 && _loc_4 != "_internal" && _loc_4 != "prototype")
                {
                    _loc_5 = Capabilities[_loc_4];
                    _loc_2.push({p:_loc_4, v:_loc_5});
                }
            }
            _loc_2.sortOn(["p"], Array.CASEINSENSITIVE);
            send("onCap", _loc_2);
            return;
        }// end function

        private static function storeDataLSO(param1:String, param2) : void
        {
            var flushResult:String;
            var m:* = param1;
            var d:* = param2;
            var sharedObject:* = SharedObject.getLocal("alcon", "/");
            sharedObject.data["alconMethod"] = m;
            sharedObject.data["alconData"] = d;
            try
            {
                flushResult = sharedObject.flush();
                if (flushResult == SharedObjectFlushStatus.FLUSHED)
                {
                    return;
                }
            }
            catch (e:Error)
            {
                Security.showSettings(SecurityPanel.LOCAL_STORAGE);
            }
            return;
        }// end function

    }
}
