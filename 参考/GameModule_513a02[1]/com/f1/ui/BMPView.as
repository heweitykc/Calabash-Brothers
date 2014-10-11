package com.f1.ui
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;

    public class BMPView extends Bitmap
    {
        public var playing:Boolean = true;
        public var hasSetAuto:Boolean;
        protected var _lastPoseTime:int;
        protected var _interval:uint;
        protected var _direct:int = 90;
        protected var _offsets:Array;
        protected var _inters:Array;
        protected var _poses:Array;
        protected var _poseProgress:uint;
        protected var _repeat:Boolean;
        protected var _duration:uint = 0;
        protected var nowTime:int;
        protected var __x:int;
        protected var __y:int;
        private var _scale:Number = 1;
        protected var _playInterMultiple:Number = 1;
        private var _noRepeatCompleteFun:Function;

        public function BMPView()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.__addToStage, false, 0, true);
            addEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage, false, 0, true);
            return;
        }// end function

        public function get noRepeatCompleteFun() : Function
        {
            return this._noRepeatCompleteFun;
        }// end function

        public function set noRepeatCompleteFun(param1:Function) : void
        {
            this._noRepeatCompleteFun = param1;
            return;
        }// end function

        public function get poseProgress() : uint
        {
            return this._poseProgress;
        }// end function

        public function set poseProgress(param1:uint) : void
        {
            this._poseProgress = param1;
            return;
        }// end function

        public function get playInterMultiple() : Number
        {
            return this._playInterMultiple;
        }// end function

        public function set playInterMultiple(param1:Number) : void
        {
            this._playInterMultiple = param1;
            return;
        }// end function

        public function get offsets() : Array
        {
            return this._offsets;
        }// end function

        public function set offsets(param1:Array) : void
        {
            this._offsets = param1;
            return;
        }// end function

        public function get interval() : uint
        {
            return this._interval;
        }// end function

        public function set interval(param1:uint) : void
        {
            this._interval = param1;
            return;
        }// end function

        public function get inters() : Array
        {
            return this._inters;
        }// end function

        public function set inters(param1:Array) : void
        {
            this._inters = param1;
            return;
        }// end function

        public function get repeat() : Boolean
        {
            return this._repeat;
        }// end function

        public function set repeat(param1:Boolean) : void
        {
            this._repeat = param1;
            return;
        }// end function

        public function get _y() : int
        {
            return this.__y;
        }// end function

        public function get _x() : int
        {
            return this.__x;
        }// end function

        public function set _x(param1:int) : void
        {
            if (this.__x != param1)
            {
                this.__x = param1;
                this.paintOffset();
            }
            return;
        }// end function

        public function set _y(param1:int) : void
        {
            if (this.__y != param1)
            {
                this.__y = param1;
                this.paintOffset();
            }
            return;
        }// end function

        public function move(param1:int, param2:int) : void
        {
            if (this.__x != param1 || this.__y != param2)
            {
                this.__x = param1;
                this.__y = param2;
                this.paintOffset();
            }
            return;
        }// end function

        public function get direct() : int
        {
            return this._direct;
        }// end function

        public function set direct(param1:int) : void
        {
            this._direct = param1;
            this.paintOffset();
            return;
        }// end function

        public function get length() : uint
        {
            if (this._inters != null)
            {
                return this._inters.length;
            }
            return 0;
        }// end function

        public function set auto(param1:Boolean) : void
        {
            if (param1)
            {
                this._lastPoseTime = getTimer();
                addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            this.hasSetAuto = param1;
            return;
        }// end function

        public function get auto() : Boolean
        {
            return hasEventListener(Event.ENTER_FRAME);
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            if (this.inters != null && this._poses != null && this._offsets != null)
            {
                this.doScale();
            }
            return;
        }// end function

        public function get scale() : Number
        {
            return this._scale;
        }// end function

        private function __addToStage(event:Event) : void
        {
            this.play();
            return;
        }// end function

        private function __removeFromStage(event:Event) : void
        {
            this.stop();
            return;
        }// end function

        public function setRotation(param1:Number) : void
        {
            return;
        }// end function

        private function doScale() : void
        {
            if (scaleX != this._scale && scaleY != this._scale)
            {
                var _loc_1:* = this._scale;
                scaleY = this._scale;
                scaleX = _loc_1;
                this.paintOffset();
            }
            return;
        }// end function

        public function reset() : void
        {
            this.playing = true;
            this._lastPoseTime = 0;
            this._interval = 0;
            this._direct = FrameworkGlobal.DIRECT_90;
            this._offsets = null;
            this._inters = null;
            this._poses = null;
            this.poseProgress = 0;
            this._repeat = false;
            this.nowTime = 0;
            return;
        }// end function

        public function gotoAndStop(param1:uint) : void
        {
            this.poseProgress = param1;
            this.paint();
            this.stop();
            return;
        }// end function

        public function play() : void
        {
            this.playing = true;
            this._lastPoseTime = getTimer();
            if (this.hasSetAuto && !this.auto)
            {
                addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        public function stop() : void
        {
            this.playing = false;
            if (this.hasSetAuto)
            {
                removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        public function replay() : void
        {
            this.poseProgress = 0;
            this.play();
            return;
        }// end function

        public function update(param1:Array, param2:Array, param3:Array) : void
        {
            if (param2 != null && param1 != null && param3 != null)
            {
                this.playing = true;
                this._poses = param1;
                this._offsets = param3;
                this._inters = param2;
                this._repeat = this.repeat;
                if (this._lastPoseTime == 0)
                {
                    this._lastPoseTime = getTimer();
                }
                this.paint();
                this.doScale();
                if (param2.length == 1)
                {
                    this.stop();
                }
            }
            return;
        }// end function

        public function getCurOffset() : Array
        {
            return this._offsets[this.poseProgress];
        }// end function

        public function paint() : void
        {
            if (this.paintPose())
            {
                this.countInter();
                this.paintOffset();
            }
            return;
        }// end function

        public function paintPose() : Boolean
        {
            var _loc_1:* = null;
            if (this._poses != null)
            {
                if (this._poseProgress < this._poses.length)
                {
                    _loc_1 = this._poses[this._poseProgress];
                    if (_loc_1 && bitmapData != _loc_1)
                    {
                        bitmapData = _loc_1;
                        return true;
                    }
                }
            }
            else
            {
                Log.log("pose == null,无姿势设定");
            }
            return false;
        }// end function

        protected function countInter() : void
        {
            this._interval = this._inters[this._poseProgress] * FrameworkGlobal.GLOBAL_BMP_MULTIPLE;
            if (this._playInterMultiple != 1)
            {
                this._interval = this._interval * this._playInterMultiple;
            }
            return;
        }// end function

        public function paintOffset() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this._offsets != null)
            {
                if (this._poseProgress < this._offsets.length)
                {
                    _loc_1 = this._offsets[this._poseProgress];
                    if (_loc_1 != null)
                    {
                        if (_loc_1.length == 2)
                        {
                            if (this._direct > 0)
                            {
                                if (scaleX < 0)
                                {
                                    scaleX = Math.abs(scaleX);
                                }
                                _loc_2 = _loc_1[0] * this._scale + this.__x;
                            }
                            else
                            {
                                if (scaleX > 0)
                                {
                                    scaleX = -Math.abs(scaleX);
                                }
                                _loc_2 = (-_loc_1[0]) * this._scale + this.__x;
                            }
                            _loc_3 = _loc_1[1] * this._scale + this.__y;
                            if (_loc_2 != x)
                            {
                                x = _loc_2;
                            }
                            if (_loc_3 != y)
                            {
                                y = _loc_3;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function enterFrame(event:Event = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = getTimer();
            var _loc_3:* = [];
            if (this.playing)
            {
                if (this._inters != null)
                {
                    if (this._inters.length > 0)
                    {
                        this.nowTime = getTimer();
                        _loc_5 = this._poseProgress;
                        _loc_6 = this._lastPoseTime;
                        if (this._lastPoseTime == 0 || this.nowTime - this._lastPoseTime > 3000)
                        {
                            this._lastPoseTime = getTimer();
                            this.nextFrame();
                        }
                        else
                        {
                            _loc_7 = 0;
                            while (this.nowTime - this._lastPoseTime > this._interval)
                            {
                                
                                _loc_3.push(this.nowTime + "_" + this._lastPoseTime + "_" + this._interval);
                                this._lastPoseTime = this._lastPoseTime + this._interval;
                                this.nextFrame();
                                _loc_7++;
                            }
                        }
                        if (_loc_5 != this._poseProgress)
                        {
                            this.paint();
                        }
                    }
                }
            }
            var _loc_4:* = getTimer();
            return;
        }// end function

        protected function nextFrame() : void
        {
            if (this._poseProgress < (this._inters.length - 1))
            {
                var _loc_1:* = this;
                var _loc_2:* = this._poseProgress + 1;
                _loc_1._poseProgress = _loc_2;
                this.countInter();
            }
            else if (this._repeat)
            {
                this._poseProgress = 0;
                this.countInter();
            }
            else
            {
                this.actComplete();
                if (this._noRepeatCompleteFun != null)
                {
                    this._noRepeatCompleteFun();
                }
            }
            return;
        }// end function

        public function actComplete() : void
        {
            dispatchEvent(new Event(Event.COMPLETE));
            return;
        }// end function

        public function shine(param1:uint = 16773120) : void
        {
            var _loc_2:* = this.getNotGlowFilter();
            _loc_2.push(new GlowFilter(param1, 1, 2, 2, 4));
            filters = _loc_2;
            return;
        }// end function

        public function unShine() : void
        {
            filters = this.getNotGlowFilter();
            return;
        }// end function

        private function getNotGlowFilter() : Array
        {
            if (!filters)
            {
                return [];
            }
            var _loc_1:* = [];
            var _loc_2:* = filters.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (!(filters[_loc_3] is GlowFilter))
                {
                    _loc_1.push(filters[_loc_3]);
                }
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public function removeFromParent(param1:Boolean = false) : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            if (param1)
            {
                this.finalize();
            }
            return;
        }// end function

        public function finalize() : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.__addToStage);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage);
            this.auto = false;
            this._poses = null;
            filters = [];
            bitmapData = null;
            return;
        }// end function

    }
}
