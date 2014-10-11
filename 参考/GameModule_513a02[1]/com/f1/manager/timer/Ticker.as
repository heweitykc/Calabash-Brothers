package com.f1.manager.timer
{
    import com.f1.*;
    import flash.events.*;
    import flash.utils.*;

    public class Ticker extends Object
    {
        private var t1:Timer;
        private var tickFun:Function;
        private var tickObjList:Array;
        private var _enabled:Boolean;
        private static var instance:Ticker;

        public function Ticker()
        {
            this.tickObjList = [];
            return;
        }// end function

        private function enableEnterFrame() : void
        {
            if (this._enabled == false)
            {
                this._enabled = true;
                FrameworkGlobal.stageAddEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            }
            return;
        }// end function

        private function disableEnterFrame() : void
        {
            if (this._enabled)
            {
                this._enabled = false;
                FrameworkGlobal.stageRemoveEvtListener(Event.ENTER_FRAME, this.__enterFrame);
            }
            return;
        }// end function

        private function __enterFrame(event:Event) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = [];
            for each (_loc_4 in this.tickObjList)
            {
                
                if (_loc_4 != null)
                {
                    if (_loc_4.lastTick + _loc_4.delay <= _loc_2)
                    {
                        if (_loc_4.timerHandler != null)
                        {
                            _loc_4.timerHandler.call();
                        }
                        var _loc_8:* = _loc_4;
                        var _loc_9:* = _loc_4.repeated + 1;
                        _loc_8.repeated = _loc_9;
                        if (_loc_4.repeated == _loc_4.repeatCount)
                        {
                            if (_loc_4.completeHandler != null)
                            {
                                _loc_4.completeHandler.call();
                            }
                            _loc_3.push(_loc_4);
                            break;
                        }
                        _loc_4.lastTick = _loc_2;
                    }
                    continue;
                }
                _loc_3.push(_loc_4);
            }
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = this.tickObjList.indexOf(_loc_4);
                if (_loc_5 != -1)
                {
                    this.tickObjList.splice(_loc_5, 1);
                }
            }
            if (this.tickObjList.length == 0)
            {
                this.disableEnterFrame();
            }
            return;
        }// end function

        public function start() : void
        {
            return;
        }// end function

        public function stop() : void
        {
            return;
        }// end function

        public static function getInstance() : Ticker
        {
            if (instance == null)
            {
                instance = new Ticker;
            }
            return instance;
        }// end function

        public static function registerTimer(param1:Number, param2:Function, param3:Function = null, param4:uint = 0) : void
        {
            var _loc_5:* = getInstance();
            _loc_5.tickObjList.push({delay:param1 * 1000, repeated:0, repeatCount:param4, timerHandler:param2, completeHandler:param3, lastTick:getTimer()});
            if (_loc_5.tickObjList.length > 0)
            {
                _loc_5.enableEnterFrame();
            }
            return;
        }// end function

        public static function killTimer(param1:Function) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = getInstance();
            var _loc_3:* = _loc_2.tickObjList.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = _loc_2.tickObjList[_loc_5];
                if (_loc_4 != null && _loc_4.timerHandler == param1)
                {
                    _loc_2.tickObjList[_loc_5] = null;
                    break;
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
