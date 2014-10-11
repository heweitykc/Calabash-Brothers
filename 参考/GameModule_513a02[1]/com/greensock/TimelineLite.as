package com.greensock
{
    import com.greensock.core.*;

    public class TimelineLite extends SimpleTimeline
    {
        protected var _labels:Object;
        protected var _endCaps:Array;
        public static const version:Number = 1.65;
        private static var _overwriteMode:int = OverwriteManager.enabled ? (OverwriteManager.mode) : (OverwriteManager.init(2));

        public function TimelineLite(param1:Object = null)
        {
            super(param1);
            this._endCaps = [null, null];
            this._labels = {};
            this.autoRemoveChildren = Boolean(this.vars.autoRemoveChildren == true);
            _hasUpdate = Boolean(typeof(this.vars.onUpdate) == "function");
            if (this.vars.tweens is Array)
            {
                this.insertMultiple(this.vars.tweens, 0, this.vars.align != null ? (this.vars.align) : ("normal"), this.vars.stagger ? (Number(this.vars.stagger)) : (0));
            }
            return;
        }// end function

        override public function remove(param1:TweenCore, param2:Boolean = false) : void
        {
            if (param1.cachedOrphan)
            {
                return;
            }
            if (!param2)
            {
                param1.setEnabled(false, true);
            }
            var _loc_3:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            var _loc_4:* = this.gc ? (this._endCaps[1]) : (_lastChild);
            if (param1.nextNode)
            {
                param1.nextNode.prevNode = param1.prevNode;
            }
            else if (_loc_4 == param1)
            {
                _loc_4 = param1.prevNode;
            }
            if (param1.prevNode)
            {
                _loc_4.nextNode = param1.nextNode;
            }
            else if (_loc_3 == param1)
            {
                _loc_3 = param1.nextNode;
            }
            if (this.gc)
            {
                this._endCaps[0] = _loc_3;
                this._endCaps[1] = _loc_4;
            }
            else
            {
                _firstChild = _loc_3;
                _lastChild = _loc_4;
            }
            param1.cachedOrphan = true;
            setDirtyCache(true);
            return;
        }// end function

        override public function insert(param1:TweenCore, param2 = 0) : TweenCore
        {
            var _loc_5:* = null;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            if (typeof(param2) == "string")
            {
                if (!(param2 in this._labels))
                {
                    this.addLabel(param2, this.duration);
                }
                param2 = Number(this._labels[param2]);
            }
            if (!param1.cachedOrphan && param1.timeline)
            {
                param1.timeline.remove(param1, true);
            }
            param1.timeline = this;
            param1.cachedStartTime = Number(param2) + param1.delay;
            if (param1.cachedPaused)
            {
                param1.cachedPauseTime = param1.cachedStartTime + (this.rawTime - param1.cachedStartTime) / param1.cachedTimeScale;
            }
            if (param1.gc)
            {
                param1.setEnabled(true, true);
            }
            setDirtyCache(true);
            var _loc_3:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            var _loc_4:* = this.gc ? (this._endCaps[1]) : (_lastChild);
            if ((this.gc ? (this._endCaps[1]) : (_lastChild)) == null)
            {
                var _loc_8:* = param1;
                _loc_4 = param1;
                _loc_3 = _loc_8;
                var _loc_8:* = null;
                _loc_4.prevNode = null;
                _loc_4.nextNode = _loc_8;
            }
            else
            {
                _loc_5 = _loc_4;
                _loc_6 = _loc_4.cachedStartTime;
                while (_loc_5 != null && _loc_6 < _loc_5.cachedStartTime)
                {
                    
                    _loc_5 = _loc_5.prevNode;
                }
                if (_loc_5 == null)
                {
                    _loc_3.prevNode = param1;
                    _loc_4.nextNode = _loc_3;
                    _loc_4.prevNode = null;
                    _loc_3 = param1;
                }
                else
                {
                    if (_loc_5.nextNode)
                    {
                        _loc_5.nextNode.prevNode = param1;
                    }
                    else if (_loc_5 == _loc_4)
                    {
                        _loc_4 = param1;
                    }
                    _loc_3.prevNode = _loc_5;
                    _loc_3.nextNode = _loc_5.nextNode;
                    _loc_5.nextNode = param1;
                }
            }
            _loc_3.cachedOrphan = false;
            if (this.gc)
            {
                this._endCaps[0] = _loc_3;
                this._endCaps[1] = _loc_4;
            }
            else
            {
                _firstChild = _loc_3;
                _lastChild = _loc_4;
            }
            if (this.gc && !this.cachedPaused && this.cachedStartTime + (_loc_3.cachedStartTime + _loc_3.cachedTotalDuration / _loc_3.cachedTimeScale) / this.cachedTimeScale > this.timeline.cachedTime)
            {
                if (this.timeline == TweenLite.rootTimeline || this.timeline == TweenLite.rootFramesTimeline)
                {
                    this.setTotalTime(this.cachedTotalTime, true);
                }
                this.setEnabled(true, false);
                _loc_7 = this.timeline;
                while (_loc_7.gc && _loc_7.timeline)
                {
                    
                    if (_loc_7.cachedStartTime + _loc_7.totalDuration / _loc_7.cachedTimeScale > _loc_7.timeline.cachedTime)
                    {
                        _loc_7.setEnabled(true, false);
                    }
                    _loc_7 = _loc_7.timeline;
                }
            }
            return param1;
        }// end function

        public function append(param1:TweenCore, param2:Number = 0) : TweenCore
        {
            return this.insert(param1, this.duration + param2);
        }// end function

        public function prepend(param1:TweenCore, param2:Boolean = false) : TweenCore
        {
            this.shiftChildren(param1.totalDuration / param1.cachedTimeScale + param1.delay, param2, 0);
            return this.insert(param1, 0);
        }// end function

        public function insertMultiple(param1:Array, param2 = 0, param3:String = "normal", param4:Number = 0) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = Number(param2) || 0;
            var _loc_8:* = param1.length;
            if (typeof(param2) == "string")
            {
                if (!(param2 in this._labels))
                {
                    this.addLabel(param2, this.duration);
                }
                _loc_7 = this._labels[param2];
            }
            _loc_5 = 0;
            while (_loc_5 < _loc_8)
            {
                
                _loc_6 = param1[_loc_5] as TweenCore;
                this.insert(_loc_6, _loc_7);
                if (param3 == "sequence")
                {
                    _loc_7 = _loc_6.cachedStartTime + _loc_6.totalDuration / _loc_6.cachedTimeScale;
                }
                else if (param3 == "start")
                {
                    _loc_6.cachedStartTime = _loc_6.cachedStartTime - _loc_6.delay;
                }
                _loc_7 = _loc_7 + param4;
                _loc_5 = _loc_5 + 1;
            }
            return param1;
        }// end function

        public function appendMultiple(param1:Array, param2:Number = 0, param3:String = "normal", param4:Number = 0) : Array
        {
            return this.insertMultiple(param1, this.duration + param2, param3, param4);
        }// end function

        public function prependMultiple(param1:Array, param2:String = "normal", param3:Number = 0, param4:Boolean = false) : Array
        {
            var _loc_5:* = new TimelineLite({tweens:param1, align:param2, stagger:param3});
            this.shiftChildren(_loc_5.duration, param4, 0);
            this.insertMultiple(param1, 0, param2, param3);
            _loc_5.kill();
            return param1;
        }// end function

        public function addLabel(param1:String, param2:Number) : void
        {
            this._labels[param1] = param2;
            return;
        }// end function

        public function removeLabel(param1:String) : Number
        {
            var _loc_2:* = this._labels[param1];
            delete this._labels[param1];
            return _loc_2;
        }// end function

        public function getLabelTime(param1:String) : Number
        {
            return param1 in this._labels ? (Number(this._labels[param1])) : (-1);
        }// end function

        protected function parseTimeOrLabel(param1) : Number
        {
            if (typeof(param1) == "string")
            {
                if (!(param1 in this._labels))
                {
                    throw new Error("TimelineLite error: the " + param1 + " label was not found.");
                }
                return this.getLabelTime(String(param1));
            }
            return Number(param1);
        }// end function

        public function stop() : void
        {
            this.paused = true;
            return;
        }// end function

        public function gotoAndPlay(param1, param2:Boolean = true) : void
        {
            setTotalTime(this.parseTimeOrLabel(param1), param2);
            play();
            return;
        }// end function

        public function gotoAndStop(param1, param2:Boolean = true) : void
        {
            setTotalTime(this.parseTimeOrLabel(param1), param2);
            this.paused = true;
            return;
        }// end function

        public function goto(param1, param2:Boolean = true) : void
        {
            setTotalTime(this.parseTimeOrLabel(param1), param2);
            return;
        }// end function

        override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
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
            var _loc_13:* = this.cachedPaused;
            if (param1 >= _loc_4)
            {
                if (_rawPrevTime <= _loc_4 && _rawPrevTime != param1)
                {
                    var _loc_14:* = _loc_4;
                    this.cachedTime = _loc_4;
                    this.cachedTotalTime = _loc_14;
                    this.forceChildrenToEnd(_loc_4, param2);
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
                    this.forceChildrenToBeginning(0, param2);
                    _loc_10 = true;
                    if (this.cachedReversed)
                    {
                        _loc_9 = true;
                    }
                }
            }
            else
            {
                var _loc_14:* = param1;
                this.cachedTime = param1;
                this.cachedTotalTime = _loc_14;
            }
            _rawPrevTime = param1;
            if (this.cachedTime == _loc_5 && !param3)
            {
                return;
            }
            if (!this.initted)
            {
                this.initted = true;
            }
            if (_loc_5 == 0 && this.vars.onStart && this.cachedTime != 0 && !param2)
            {
                this.vars.onStart.apply(null, this.vars.onStartParams);
            }
            if (_loc_10)
            {
            }
            else if (this.cachedTime - _loc_5 > 0)
            {
                _loc_8 = _firstChild;
                while (_loc_8)
                {
                    
                    _loc_11 = _loc_8.nextNode;
                    if (this.cachedPaused && !_loc_13)
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
                            _loc_12 = _loc_8.cacheIsDirty ? (_loc_8.totalDuration) : (_loc_8.cachedTotalDuration);
                            _loc_8.renderTime(_loc_12 - (this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                    }
                    _loc_8 = _loc_11;
                }
            }
            else
            {
                _loc_8 = _lastChild;
                while (_loc_8)
                {
                    
                    _loc_11 = _loc_8.prevNode;
                    if (this.cachedPaused && !_loc_13)
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
                            _loc_12 = _loc_8.cacheIsDirty ? (_loc_8.totalDuration) : (_loc_8.cachedTotalDuration);
                            _loc_8.renderTime(_loc_12 - (this.cachedTime - _loc_8.cachedStartTime) * _loc_8.cachedTimeScale, param2, false);
                        }
                    }
                    _loc_8 = _loc_11;
                }
            }
            if (_hasUpdate && !param2)
            {
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            }
            if (_loc_9 && (_loc_6 == this.cachedStartTime || _loc_7 != this.cachedTimeScale) && (_loc_4 >= this.totalDuration || this.cachedTime == 0))
            {
                complete(true, param2);
            }
            return;
        }// end function

        protected function forceChildrenToBeginning(param1:Number, param2:Boolean = false) : Number
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_3:* = _lastChild;
            var _loc_6:* = this.cachedPaused;
            while (_loc_3)
            {
                
                _loc_4 = _loc_3.prevNode;
                if (this.cachedPaused && !_loc_6)
                {
                    break;
                }
                else if (_loc_3.active || !_loc_3.cachedPaused && !_loc_3.gc && (_loc_3.cachedTotalTime != 0 || _loc_3.cachedDuration == 0))
                {
                    if (param1 == 0 && (_loc_3.cachedDuration != 0 || _loc_3.cachedStartTime == 0))
                    {
                        _loc_3.renderTime(_loc_3.cachedReversed ? (_loc_3.cachedTotalDuration) : (0), param2, false);
                    }
                    else if (!_loc_3.cachedReversed)
                    {
                        _loc_3.renderTime((param1 - _loc_3.cachedStartTime) * _loc_3.cachedTimeScale, param2, false);
                    }
                    else
                    {
                        _loc_5 = _loc_3.cacheIsDirty ? (_loc_3.totalDuration) : (_loc_3.cachedTotalDuration);
                        _loc_3.renderTime(_loc_5 - (param1 - _loc_3.cachedStartTime) * _loc_3.cachedTimeScale, param2, false);
                    }
                }
                _loc_3 = _loc_4;
            }
            return param1;
        }// end function

        protected function forceChildrenToEnd(param1:Number, param2:Boolean = false) : Number
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_3:* = _firstChild;
            var _loc_6:* = this.cachedPaused;
            while (_loc_3)
            {
                
                _loc_4 = _loc_3.nextNode;
                if (this.cachedPaused && !_loc_6)
                {
                    break;
                }
                else if (_loc_3.active || !_loc_3.cachedPaused && !_loc_3.gc && (_loc_3.cachedTotalTime != _loc_3.cachedTotalDuration || _loc_3.cachedDuration == 0))
                {
                    if (param1 == this.cachedDuration && (_loc_3.cachedDuration != 0 || _loc_3.cachedStartTime == this.cachedDuration))
                    {
                        _loc_3.renderTime(_loc_3.cachedReversed ? (0) : (_loc_3.cachedTotalDuration), param2, false);
                    }
                    else if (!_loc_3.cachedReversed)
                    {
                        _loc_3.renderTime((param1 - _loc_3.cachedStartTime) * _loc_3.cachedTimeScale, param2, false);
                    }
                    else
                    {
                        _loc_5 = _loc_3.cacheIsDirty ? (_loc_3.totalDuration) : (_loc_3.cachedTotalDuration);
                        _loc_3.renderTime(_loc_5 - (param1 - _loc_3.cachedStartTime) * _loc_3.cachedTimeScale, param2, false);
                    }
                }
                _loc_3 = _loc_4;
            }
            return param1;
        }// end function

        public function hasPausedChild() : Boolean
        {
            var _loc_1:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            while (_loc_1)
            {
                
                if (_loc_1.cachedPaused || _loc_1 is TimelineLite && (_loc_1 as TimelineLite).hasPausedChild())
                {
                    return true;
                }
                _loc_1 = _loc_1.nextNode;
            }
            return false;
        }// end function

        public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -1e+010) : Array
        {
            var _loc_5:* = [];
            var _loc_6:* = 0;
            var _loc_7:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            while (_loc_7)
            {
                
                if (_loc_7.cachedStartTime < param4)
                {
                }
                else if (_loc_7 is TweenLite)
                {
                    if (param2)
                    {
                        _loc_5[++_loc_6] = _loc_7;
                    }
                }
                else
                {
                    if (param3)
                    {
                        _loc_5[++_loc_6] = _loc_7;
                    }
                    if (param1)
                    {
                        _loc_5 = _loc_5.concat(TimelineLite(_loc_7).getChildren(true, param2, param3));
                    }
                }
                _loc_7 = _loc_7.nextNode;
            }
            return _loc_5;
        }// end function

        public function getTweensOf(param1:Object, param2:Boolean = true) : Array
        {
            var _loc_5:* = 0;
            var _loc_3:* = this.getChildren(param2, true, false);
            var _loc_4:* = [];
            var _loc_6:* = _loc_3.length;
            var _loc_7:* = 0;
            _loc_5 = 0;
            while (_loc_5 < _loc_6)
            {
                
                if (TweenLite(_loc_3[_loc_5]).target == param1)
                {
                    _loc_4[++_loc_7] = _loc_3[_loc_5];
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_4;
        }// end function

        public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            while (_loc_4)
            {
                
                if (_loc_4.cachedStartTime >= param3)
                {
                    _loc_4.cachedStartTime = _loc_4.cachedStartTime + param1;
                }
                _loc_4 = _loc_4.nextNode;
            }
            if (param2)
            {
                for (_loc_5 in this._labels)
                {
                    
                    if (_loc_7[_loc_5] >= param3)
                    {
                        _loc_7[_loc_5] = _loc_7[_loc_5] + param1;
                    }
                }
            }
            this.setDirtyCache(true);
            return;
        }// end function

        public function killTweensOf(param1:Object, param2:Boolean = true, param3:Object = null) : Boolean
        {
            var _loc_6:* = null;
            var _loc_4:* = this.getTweensOf(param1, param2);
            var _loc_5:* = _loc_4.length;
            while (--_loc_5 > -1)
            {
                
                _loc_6 = _loc_4[_loc_5];
                if (param3 != null)
                {
                    _loc_6.killVars(param3);
                }
                if (param3 == null || _loc_6.cachedPT1 == null && _loc_6.initted)
                {
                    _loc_6.setEnabled(false, false);
                }
            }
            return Boolean(_loc_4.length > 0);
        }// end function

        override public function invalidate() : void
        {
            var _loc_1:* = this.gc ? (this._endCaps[0]) : (_firstChild);
            while (_loc_1)
            {
                
                _loc_1.invalidate();
                _loc_1 = _loc_1.nextNode;
            }
            return;
        }// end function

        public function clear(param1:Array = null) : void
        {
            if (param1 == null)
            {
                param1 = this.getChildren(false, true, true);
            }
            var _loc_2:* = param1.length;
            while (--_loc_2 > -1)
            {
                
                TweenCore(param1[_loc_2]).setEnabled(false, false);
            }
            return;
        }// end function

        override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = null;
            if (param1 == this.gc)
            {
                if (param1)
                {
                    var _loc_4:* = this._endCaps[0];
                    _loc_3 = this._endCaps[0];
                    _firstChild = _loc_4;
                    _lastChild = this._endCaps[1];
                    this._endCaps = [null, null];
                }
                else
                {
                    _loc_3 = _firstChild;
                    this._endCaps = [_firstChild, _lastChild];
                    var _loc_4:* = null;
                    _lastChild = null;
                    _firstChild = _loc_4;
                }
                while (_loc_3)
                {
                    
                    _loc_3.setEnabled(param1, true);
                    _loc_3 = _loc_3.nextNode;
                }
            }
            return super.setEnabled(param1, param2);
        }// end function

        public function get currentProgress() : Number
        {
            return this.cachedTime / this.duration;
        }// end function

        public function set currentProgress(param1:Number) : void
        {
            setTotalTime(this.duration * param1, false);
            return;
        }// end function

        override public function get duration() : Number
        {
            var _loc_1:* = NaN;
            if (this.cacheIsDirty)
            {
                _loc_1 = this.totalDuration;
            }
            return this.cachedDuration;
        }// end function

        override public function set duration(param1:Number) : void
        {
            if (this.duration != 0 && param1 != 0)
            {
                this.timeScale = this.duration / param1;
            }
            return;
        }// end function

        override public function get totalDuration() : Number
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = null;
            if (this.cacheIsDirty)
            {
                _loc_1 = 0;
                _loc_3 = this.gc ? (this._endCaps[0]) : (_firstChild);
                _loc_4 = -Infinity;
                while (_loc_3)
                {
                    
                    _loc_5 = _loc_3.nextNode;
                    if (_loc_3.cachedStartTime < _loc_4)
                    {
                        this.insert(_loc_3, _loc_3.cachedStartTime - _loc_3.delay);
                        _loc_4 = _loc_3.prevNode.cachedStartTime;
                    }
                    else
                    {
                        _loc_4 = _loc_3.cachedStartTime;
                    }
                    if (_loc_3.cachedStartTime < 0)
                    {
                        _loc_1 = _loc_1 - _loc_3.cachedStartTime;
                        this.shiftChildren(-_loc_3.cachedStartTime, false, -9999999999);
                    }
                    _loc_2 = _loc_3.cachedStartTime + _loc_3.totalDuration / _loc_3.cachedTimeScale;
                    if (_loc_2 > _loc_1)
                    {
                        _loc_1 = _loc_2;
                    }
                    _loc_3 = _loc_5;
                }
                var _loc_6:* = _loc_1;
                this.cachedTotalDuration = _loc_1;
                this.cachedDuration = _loc_6;
                this.cacheIsDirty = false;
            }
            return this.cachedTotalDuration;
        }// end function

        override public function set totalDuration(param1:Number) : void
        {
            if (this.totalDuration != 0 && param1 != 0)
            {
                this.timeScale = this.totalDuration / param1;
            }
            return;
        }// end function

        public function get timeScale() : Number
        {
            return this.cachedTimeScale;
        }// end function

        public function set timeScale(param1:Number) : void
        {
            if (param1 == 0)
            {
                param1 = 0.0001;
            }
            var _loc_2:* = this.cachedPauseTime || this.cachedPauseTime == 0 ? (this.cachedPauseTime) : (this.timeline.cachedTotalTime);
            this.cachedStartTime = _loc_2 - (_loc_2 - this.cachedStartTime) * this.cachedTimeScale / param1;
            this.cachedTimeScale = param1;
            setDirtyCache(false);
            return;
        }// end function

        public function get useFrames() : Boolean
        {
            var _loc_1:* = this.timeline;
            while (_loc_1.timeline)
            {
                
                _loc_1 = _loc_1.timeline;
            }
            return Boolean(_loc_1 == TweenLite.rootFramesTimeline);
        }// end function

        override public function get rawTime() : Number
        {
            if (this.cachedTotalTime != 0 && this.cachedTotalTime != this.cachedTotalDuration)
            {
                return this.cachedTotalTime;
            }
            return (this.timeline.rawTime - this.cachedStartTime) * this.cachedTimeScale;
        }// end function

    }
}
