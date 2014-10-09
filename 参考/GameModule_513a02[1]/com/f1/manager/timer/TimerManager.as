package com.f1.manager.timer
{
    import com.f1.events.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.utils.*;

    public class TimerManager extends Object
    {
        private var timerDic:Dictionary;
        private var timer:Timer;
        private var startTime:uint;
        private var totalCount:uint;
        private static const INNER_TIMER:uint = 1000;
        private static var _instance:TimerManager;

        public function TimerManager()
        {
            if (_instance)
            {
                throw new Error("Instance already exists.");
            }
            this.timerDic = new Dictionary();
            return;
        }// end function

        private function startTimer(param1:TimerObject) : void
        {
            if (param1 != null && param1.key != null)
            {
                this.timerDic[param1.key] = param1;
            }
            this.initTimer();
            param1.startTime = this.startTime + this.totalCount * INNER_TIMER;
            return;
        }// end function

        private function initTimer() : void
        {
            if (this.timer == null)
            {
                this.timer = new Timer(INNER_TIMER, 0);
                this.timer.addEventListener(TimerEvent.TIMER, this.timerHandler);
                this.startTime = new Date().getTime();
                this.totalCount = 0;
                this.timer.start();
            }
            return;
        }// end function

        private function resetTimer() : void
        {
            if (this.timer != null)
            {
                this.timer.reset();
                this.timer.removeEventListener(TimerEvent.TIMER, this.timerHandler);
                this.timer = null;
            }
            return;
        }// end function

        private function timerHandler(event:TimerEvent) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = this;
            var _loc_13:* = this.totalCount + 1;
            _loc_12.totalCount = _loc_13;
            var _loc_2:* = 0;
            var _loc_3:* = new Array();
            for (_loc_4 in this.timerDic)
            {
                
                _loc_2 = _loc_2 + 1;
                _loc_7 = _loc_13[_loc_4] as TimerObject;
                if (_loc_7 != null && _loc_7.timerHandler != null)
                {
                    if (_loc_7.startTime < this.startTime)
                    {
                        _loc_7.startTime = this.startTime;
                    }
                    _loc_8 = this.totalCount - (_loc_7.startTime - this.startTime) / INNER_TIMER;
                    _loc_9 = _loc_8 / _loc_7.delayPer;
                    if (_loc_8 % _loc_7.delayPer == 0)
                    {
                        _loc_10 = new TimerManagerEvent(TimerEvent.TIMER);
                        _loc_10.delay = _loc_7.delayPer * INNER_TIMER / 1000;
                        _loc_10.pastCount = _loc_9;
                        _loc_10.repeatCount = _loc_7.repeatCount;
                        _loc_7.timerHandler(_loc_10);
                    }
                    if (_loc_9 >= _loc_7.repeatCount && _loc_7.repeatCount > 0)
                    {
                        if (_loc_7.completeHandler != null)
                        {
                            _loc_7.completeHandler(new TimerManagerEvent(TimerEvent.TIMER_COMPLETE));
                        }
                        _loc_3.push(_loc_7.key);
                    }
                }
            }
            _loc_5 = _loc_3.length;
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_11 = _loc_13[_loc_3[_loc_6]];
                if (_loc_11 != null)
                {
                    _loc_13[_loc_11.key] = null;
                    delete _loc_13[_loc_11.key];
                    _loc_11.finilize();
                    _loc_11 = null;
                }
                _loc_6 = _loc_6 + 1;
            }
            if (_loc_2 == 0)
            {
                this.resetTimer();
            }
            return;
        }// end function

        private function killTimerById(param1:String) : void
        {
            if (param1 == null)
            {
                return;
            }
            var _loc_2:* = this.timerDic[param1];
            if (_loc_2 != null)
            {
                this.timerDic[param1] = null;
                delete this.timerDic[param1];
                _loc_2.finilize();
                _loc_2 = null;
            }
            return;
        }// end function

        private static function getInstance() : TimerManager
        {
            if (!_instance)
            {
                _instance = new TimerManager;
            }
            return _instance;
        }// end function

        public static function registerTimer(param1:uint, param2:uint, param3:Function, param4:Function = null) : String
        {
            var _loc_5:* = UIDUtil.createUID();
            getInstance().startTimer(new TimerObject(_loc_5, param1 * 1000 / INNER_TIMER, param2, param3, param4));
            return _loc_5;
        }// end function

        public static function killTimer(param1:String) : void
        {
            getInstance().killTimerById(param1);
            return;
        }// end function

    }
}
