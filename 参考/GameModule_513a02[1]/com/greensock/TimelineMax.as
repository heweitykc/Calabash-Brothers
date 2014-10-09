package com.greensock
{
    import com.greensock.core.*;
    import com.greensock.events.*;
    import flash.events.*;

    public class TimelineMax extends TimelineLite implements IEventDispatcher
    {
        protected var _repeat:int;
        protected var _repeatDelay:Number;
        protected var _cyclesComplete:int;
        protected var _dispatcher:EventDispatcher;
        protected var _hasUpdateListener:Boolean;
        public var yoyo:Boolean;
        public static const version:Number = 1.65;

        public function TimelineMax(param1:Object = null)
        {
            super(param1);
            this._repeat = this.vars.repeat ? (Number(this.vars.repeat)) : (0);
            this._repeatDelay = this.vars.repeatDelay ? (Number(this.vars.repeatDelay)) : (0);
            this._cyclesComplete = 0;
            this.yoyo = Boolean(this.vars.yoyo == true);
            this.cacheIsDirty = true;
            if (this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
            {
                this.initDispatcher();
            }
            return;
        }// end function

        public function addCallback(param1:Function, param2, param3:Array = null) : TweenLite
        {
            var _loc_4:* = new TweenLite(param1, 0, {onComplete:param1, onCompleteParams:param3, overwrite:0, immediateRender:false});
            insert(_loc_4, param2);
            return _loc_4;
        }// end function

        public function removeCallback(param1:Function, param2 = null) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            if (param2 == null)
            {
                return killTweensOf(param1, false);
            }
            if (typeof(param2) == "string")
            {
                if (!(param2 in _labels))
                {
                    return false;
                }
                param2 = _labels[param2];
            }
            _loc_3 = getTweensOf(param1, false);
            _loc_5 = _loc_3.length;
            while (--_loc_5 > -1)
            {
                
                if (_loc_3[_loc_5].cachedStartTime == param2)
                {
                    remove(_loc_3[_loc_5] as TweenCore);
                    _loc_4 = true;
                }
            }
            return _loc_4;
        }// end function

        public function tweenTo(param1, param2:Object = null) : TweenLite
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = {ease:easeNone, overwrite:2, useFrames:this.useFrames, immediateRender:false};
            for (_loc_4 in param2)
            {
                
                _loc_3[_loc_4] = _loc_7[_loc_4];
            }
            _loc_3.onInit = onInitTweenTo;
            _loc_3.onInitParams = [null, this, NaN];
            _loc_3.currentTime = parseTimeOrLabel(param1);
            _loc_5 = new TweenLite(this, Math.abs(Number(_loc_3.currentTime) - this.cachedTime) / this.cachedTimeScale || 0.001, _loc_3);
            _loc_5.vars.onInitParams[0] = _loc_5;
            return _loc_5;
        }// end function

        public function tweenFromTo(param1, param2, param3:Object = null) : TweenLite
        {
            var _loc_4:* = this.tweenTo(param2, param3);
            _loc_4.vars.onInitParams[2] = parseTimeOrLabel(param1);
            _loc_4.duration = Math.abs(Number(_loc_4.vars.currentTime) - _loc_4.vars.onInitParams[2]) / this.cachedTimeScale;
            return _loc_4;
        }// end function

        override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = false;
            var _loc_12:* = null;
            var _loc_13:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = 0;
            var _loc_17:* = false;
            var _loc_18:* = false;
            var _loc_19:* = false;
            if (this.gc)
            {
                this.setEnabled(true, false);
            }
            else if (!this.active && !this.cachedPaused)
            {
                this.active = true;
            }
            var _loc_4:* = this.cacheIsDirty ? (this.totalDuration) : (this.cachedTotalDuration);
            var _loc_5:* = this.cachedTime;
            var _loc_6:* = this.cachedStartTime;
            var _loc_7:* = this.cachedTimeScale;
            var _loc_14:* = this.cachedPaused;
            if (param1 >= _loc_4)
            {
                if (_rawPrevTime <= _loc_4 && _rawPrevTime != param1)
                {
                    this.cachedTotalTime = _loc_4;
                    if (!this.cachedReversed && this.yoyo && this._repeat % 2 != 0)
                    {
                        this.cachedTime = 0;
                        forceChildrenToBeginning(0, param2);
                    }
                    else
                    {
                        this.cachedTime = this.cachedDuration;
                        forceChildrenToEnd(this.cachedDuration, param2);
                    }
                    _loc_9 = !this.hasPausedChild();
                    _loc_10 = true;
                    if (this.cachedDuration == 0 && _loc_9 && (param1 == 0 || _rawPrevTime < 0))
                    {
                        param3 = true;
                    }
                }
            }
            else if (param1 <= 0)
            {
                if (param1 < 0)
                {
                    this.active = false;
                    if (this.cachedDuration == 0 && _rawPrevTime >= 0)
                    {
                        param3 = true;
                        _loc_9 = true;
                    }
                }
                else if (param1 == 0 && !this.initted)
                {
                    param3 = true;
                }
                if (_rawPrevTime >= 0 && _rawPrevTime != param1)
                {
                    this.cachedTotalTime = 0;
                    this.cachedTime = 0;
                    forceChildrenToBeginning(0, param2);
                    _loc_10 = true;
                    if (this.cachedReversed)
                    {
                        _loc_9 = true;
                    }
                }
            }
            else
            {
                var _loc_20:* = param1;
                this.cachedTime = param1;
                this.cachedTotalTime = _loc_20;
            }
            _rawPrevTime = param1;
            if (this._repeat != 0)
            {
                _loc_15 = this.cachedDuration + this._repeatDelay;
                _loc_16 = this._cyclesComplete;
                if (_loc_9)
                {
                    if (this.yoyo && this._repeat % 2)
                    {
                        this.cachedTime = 0;
                    }
                }
                else if (param1 > 0)
                {
                    this._cyclesComplete = this.cachedTotalTime / _loc_15 >> 0;
                    if (this._cyclesComplete == this.cachedTotalTime / _loc_15)
                    {
                        var _loc_20:* = this;
                        var _loc_21:* = this._cyclesComplete - 1;
                        _loc_20._cyclesComplete = _loc_21;
                    }
                    if (_loc_16 != this._cyclesComplete)
                    {
                        _loc_11 = true;
                    }
                    this.cachedTime = (this.cachedTotalTime / _loc_15 - this._cyclesComplete) * _loc_15;
                    if (this.yoyo && this._cyclesComplete % 2)
                    {
                        this.cachedTime = this.cachedDuration - this.cachedTime;
                    }
                    else if (this.cachedTime >= this.cachedDuration)
                    {
                        this.cachedTime = this.cachedDuration;
                    }
                    if (this.cachedTime < 0)
                    {
                        this.cachedTime = 0;
                    }
                }
                else
                {
                    this._cyclesComplete = 0;
                }
                if (_loc_11 && !_loc_9 && (this.cachedTime != _loc_5 || param3))
                {
                    _loc_17 = Boolean(!this.yoyo || this._cyclesComplete % 2 == 0);
                    _loc_18 = Boolean(!this.yoyo || _loc_16 % 2 == 0);
                    _loc_19 = Boolean(_loc_17 == _loc_18);
                    if (_loc_16 > this._cyclesComplete)
                    {
                        _loc_18 = !_loc_18;
                    }
                    if (_loc_18)
                    {
                        _loc_5 = forceChildrenToEnd(this.cachedDuration, param2);
                        if (_loc_19)
                        {
                            _loc_5 = forceChildrenToBeginning(0, true);
                        }
                    }
                    else
                    {
                        _loc_5 = forceChildrenToBeginning(0, param2);
                        if (_loc_19)
                        {
                            _loc_5 = forceChildrenToEnd(this.cachedDuration, true);
                        }
                    }
                    _loc_10 = false;
                }
            }
            if (this.cachedTime == _loc_5 && !param3)
            {
                return;
            }
            if (!this.initted)
            {
                this.initted = true;
            }
            if (_loc_5 == 0 && this.cachedTotalTime != 0 && !param2)
            {
                if (this.vars.onStart)
                {
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                }
                if (this._dispatcher)
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                }
            }
            if (_loc_10)
            {
            }
            else if (this.cachedTime - _loc_5 > 0)
            {
                _loc_8 = _firstChild;
                while (_loc_8)
                {
                    
                    _loc_12 = _loc_8.nextNode;
                    if (this.cachedPaused && !_loc_14)
                    {
                        break;
                    }
                    else if (_loc_8.active || !_loc_8.cachedPaused && _loc_8.cachedStartTime <= this.cachedTime && !_loc_8.gc)
                    {
                        if (!_loc_8.cachedReversed)
                        {
                            _loc_8.renderTime((this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                        else
                        {
                            _loc_13 = _loc_8.cacheIsDirty ? (_loc_8.totalDuration) : (_loc_8.cachedTotalDuration);
                            _loc_8.renderTime(_loc_13 - (this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                    }
                    _loc_8 = _loc_12;
                }
            }
            else
            {
                _loc_8 = _lastChild;
                while (_loc_8)
                {
                    
                    _loc_12 = _loc_8.prevNode;
                    if (this.cachedPaused && !_loc_14)
                    {
                        break;
                    }
                    else if (_loc_8.active || !_loc_8.cachedPaused && _loc_8.cachedStartTime <= _loc_5 && !_loc_8.gc)
                    {
                        if (!_loc_8.cachedReversed)
                        {
                            _loc_8.renderTime((this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                        else
                        {
                            _loc_13 = _loc_8.cacheIsDirty ? (_loc_8.totalDuration) : (_loc_8.cachedTotalDuration);
                            _loc_8.renderTime(_loc_13 - (this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                    }
                    _loc_8 = _loc_12;
                }
            }
            if (_hasUpdate && !param2)
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (this._hasUpdateListener && !param2)
            {
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            }
            if (_loc_9 && (_loc_6 == this.cachedStartTime || _loc_7 != this.cachedTimeScale) && (_loc_4 >= this.totalDuration || this.cachedTime == 0))
            {
                this.complete(true, param2);
            }
            else if (_loc_11 && !param2)
            {
                if (this.vars.onRepeat)
                {
                    this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                }
                if (this._dispatcher)
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                }
            }
            return;
        }// end function

        override public function complete(param1:Boolean = false, param2:Boolean = false) : void
        {
            super.complete(param1, param2);
            if (this._dispatcher && !param2)
            {
                if (this.cachedReversed && this.cachedTotalTime == 0 && this.cachedDuration != 0)
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
                }
                else
                {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                }
            }
            return;
        }// end function

        public function getActive(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : Array
        {
            var _loc_6:* = 0;
            var _loc_4:* = [];
            var _loc_5:* = getChildren(param1, param2, param3);
            var _loc_7:* = _loc_5.length;
            var _loc_8:* = 0;
            _loc_6 = 0;
            while (_loc_6 < _loc_7)
            {
                
                if (TweenCore(_loc_5[_loc_6]).active)
                {
                    _loc_4[++_loc_8] = _loc_5[_loc_6];
                }
                _loc_6 = _loc_6 + 1;
            }
            return _loc_4;
        }// end function

        override public function invalidate() : void
        {
            this._repeat = this.vars.repeat ? (Number(this.vars.repeat)) : (0);
            this._repeatDelay = this.vars.repeatDelay ? (Number(this.vars.repeatDelay)) : (0);
            this.yoyo = Boolean(this.vars.yoyo == true);
            if (this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
            {
                this.initDispatcher();
            }
            setDirtyCache(true);
            super.invalidate();
            return;
        }// end function

        public function getLabelAfter(param1:Number = NaN) : String
        {
            if (!param1 && param1 != 0)
            {
                param1 = this.cachedTime;
            }
            var _loc_2:* = this.getLabelsArray();
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (_loc_2[_loc_4].time > param1)
                {
                    return _loc_2[_loc_4].name;
                }
                _loc_4 = _loc_4 + 1;
            }
            return null;
        }// end function

        public function getLabelBefore(param1:Number = NaN) : String
        {
            if (!param1 && param1 != 0)
            {
                param1 = this.cachedTime;
            }
            var _loc_2:* = this.getLabelsArray();
            var _loc_3:* = _loc_2.length;
            while (--_loc_3 > -1)
            {
                
                if (_loc_2[_loc_3].time < param1)
                {
                    return _loc_2[_loc_3].name;
                }
            }
            return null;
        }// end function

        protected function getLabelsArray() : Array
        {
            var _loc_2:* = null;
            var _loc_1:* = [];
            for (_loc_2 in _labels)
            {
                
                _loc_1[_loc_1.length] = {time:_loc_4[_loc_2], name:_loc_2};
            }
            _loc_1.sortOn("time", Array.NUMERIC);
            return _loc_1;
        }// end function

        protected function initDispatcher() : void
        {
            if (this._dispatcher == null)
            {
                this._dispatcher = new EventDispatcher(this);
            }
            if (this.vars.onStartListener is Function)
            {
                this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
            }
            if (this.vars.onUpdateListener is Function)
            {
                this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                this._hasUpdateListener = true;
            }
            if (this.vars.onCompleteListener is Function)
            {
                this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            }
            if (this.vars.onRepeatListener is Function)
            {
                this._dispatcher.addEventListener(TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            }
            if (this.vars.onReverseCompleteListener is Function)
            {
                this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            }
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (this._dispatcher == null)
            {
                this.initDispatcher();
            }
            if (param1 == TweenEvent.UPDATE)
            {
                this._hasUpdateListener = true;
            }
            this._dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            if (this._dispatcher != null)
            {
                this._dispatcher.removeEventListener(param1, param2, param3);
            }
            return;
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return this._dispatcher == null ? (false) : (this._dispatcher.hasEventListener(param1));
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return this._dispatcher == null ? (false) : (this._dispatcher.willTrigger(param1));
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return this._dispatcher == null ? (false) : (this._dispatcher.dispatchEvent(event));
        }// end function

        public function get totalProgress() : Number
        {
            return this.cachedTotalTime / this.totalDuration;
        }// end function

        public function set totalProgress(param1:Number) : void
        {
            setTotalTime(this.totalDuration * param1, false);
            return;
        }// end function

        override public function get totalDuration() : Number
        {
            var _loc_1:* = NaN;
            if (this.cacheIsDirty)
            {
                _loc_1 = super.totalDuration;
                this.cachedTotalDuration = this._repeat == -1 ? (999999999999) : (this.cachedDuration * (this._repeat + 1) + this._repeatDelay * this._repeat);
            }
            return this.cachedTotalDuration;
        }// end function

        override public function set currentTime(param1:Number) : void
        {
            if (this._cyclesComplete == 0)
            {
                setTotalTime(param1, false);
            }
            else if (this.yoyo && this._cyclesComplete % 2 == 1)
            {
                setTotalTime(this.duration - param1 + this._cyclesComplete * (this.cachedDuration + this._repeatDelay), false);
            }
            else
            {
                setTotalTime(param1 + this._cyclesComplete * (this.duration + this._repeatDelay), false);
            }
            return;
        }// end function

        public function get repeat() : int
        {
            return this._repeat;
        }// end function

        public function set repeat(param1:int) : void
        {
            this._repeat = param1;
            setDirtyCache(true);
            return;
        }// end function

        public function get repeatDelay() : Number
        {
            return this._repeatDelay;
        }// end function

        public function set repeatDelay(param1:Number) : void
        {
            this._repeatDelay = param1;
            setDirtyCache(true);
            return;
        }// end function

        public function get currentLabel() : String
        {
            return this.getLabelBefore(this.cachedTime + 1e-008);
        }// end function

        private static function onInitTweenTo(param1:TweenLite, param2:TimelineMax, param3:Number) : void
        {
            param2.paused = true;
            if (!isNaN(param3))
            {
                param2.currentTime = param3;
            }
            if (param1.vars.currentTime != param2.currentTime)
            {
                param1.duration = Math.abs(Number(param1.vars.currentTime) - param2.currentTime) / param2.cachedTimeScale;
            }
            return;
        }// end function

        private static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param1 / param4;
        }// end function

    }
}
