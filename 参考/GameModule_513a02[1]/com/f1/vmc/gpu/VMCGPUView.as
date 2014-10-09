package com.f1.vmc.gpu
{
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import flash.events.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.textures.*;

    public class VMCGPUView extends BaseGPUSprite
    {
        private var _url:String;
        protected var _repeat:Boolean;
        private var _playOverFinalize:Boolean;
        private var _playOverRemove:Boolean;
        private var _useDefault:Boolean;
        private var _curBmdName:String;
        private var _actName:String;
        private var _poseInfo:PoseInfo;
        private var _image:Image;
        protected var _resLoading:Boolean;
        protected var _resLoaded:Boolean;
        private var _defaultURL:String;
        private var progressFun:Function;
        private var _scale:Number = 1;
        protected var _direct:int = 90;
        public var hasSetAuto:Boolean;
        protected var lastPoseTime:int;
        protected var _interval:uint;
        protected var nowTime:int;
        protected var _poseProgress:uint;
        public var playing:Boolean = true;
        protected var _playInterMultiple:Number = 1;

        public function VMCGPUView()
        {
            return;
        }// end function

        public function get offsets() : Array
        {
            if (this._poseInfo)
            {
                return this._poseInfo.offsets;
            }
            return null;
        }// end function

        public function get inters() : Array
        {
            if (this._poseInfo)
            {
                return this._poseInfo.inters;
            }
            return null;
        }// end function

        public function get poses() : Array
        {
            if (this._poseInfo)
            {
                return this._poseInfo.poses;
            }
            return null;
        }// end function

        public function get horseY() : Number
        {
            if (this._poseInfo)
            {
                return this._poseInfo.horseY * this._poseInfo.scale;
            }
            return 0;
        }// end function

        public function get offsetX() : Number
        {
            if (this._poseInfo)
            {
                return this._poseInfo.offsetX * this._poseInfo.scale;
            }
            return 0;
        }// end function

        public function get rotate360() : Boolean
        {
            if (this._poseInfo)
            {
                return this._poseInfo.rotate360;
            }
            return false;
        }// end function

        public function get lastTime() : Number
        {
            if (this._poseInfo)
            {
                return this._poseInfo.lastTime;
            }
            return 0;
        }// end function

        public function get releaseFrame() : uint
        {
            if (this._poseInfo)
            {
                return this._poseInfo.releaseFrame;
            }
            return 0;
        }// end function

        public function get releaseTime() : Number
        {
            if (this._poseInfo)
            {
                return this._poseInfo.releaseTime;
            }
            return 0;
        }// end function

        public function get effectFrame() : uint
        {
            if (this._poseInfo)
            {
                return this._poseInfo.effectFrame;
            }
            return 0;
        }// end function

        public function get effectTime() : Number
        {
            if (this._poseInfo)
            {
                return this._poseInfo.effectTime;
            }
            return 0;
        }// end function

        public function set poseInfo(param1:PoseInfo) : void
        {
            if (param1)
            {
                this._poseInfo = param1;
                this._curBmdName = null;
            }
            return;
        }// end function

        public function cancelLoad(param1:String) : void
        {
            VMCGPUManager.removeCallBack(param1, this.loadComplete, this.loadFail, this.onProgress);
            return;
        }// end function

        public function loadRes(param1:String, param2:String = null, param3:Boolean = false, param4:Function = null, param5:Array = null, param6:Function = null, param7:Function = null, param8:int = 0) : Boolean
        {
            if (!param1)
            {
                Log.error("Error:url为null");
                return false;
            }
            if (this._url)
            {
                if (VMCGPUManager.isLoading(this._url))
                {
                    this.cancelLoad(this._url);
                }
            }
            this.progressFun = param6;
            this._url = param1;
            this._defaultURL = param2;
            this._resLoading = true;
            this._resLoaded = false;
            return VMCGPUManager.addRes(this._url, this.loadComplete, [param4, param5, param7], this.loadFail, this.onProgress, param3, param8);
        }// end function

        private function onProgress(event:ProgressEvent, param2:VResLoadObj) : void
        {
            if (this.progressFun != null)
            {
                this.progressFun.call(null, uint(event.bytesLoaded * 100 / event.bytesTotal));
            }
            return;
        }// end function

        private function doCallBack(param1:Function, param2:Array) : void
        {
            if (param1 != null)
            {
                if (param1 == null)
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

        private function loadComplete(param1:Function, param2:Array, param3:Function) : void
        {
            if (this._actName)
            {
                this.doUpdatePose();
            }
            this._resLoading = false;
            this._resLoaded = true;
            this.doCallBack(param1, param2);
            return;
        }// end function

        private function loadFail(param1:Function, param2:Array, param3:Function) : void
        {
            if (this._defaultURL)
            {
                this._url = this._defaultURL;
                this._resLoading = false;
                this._resLoaded = true;
                if (this._actName)
                {
                    this.doUpdatePose();
                }
            }
            this.doCallBack(param3, param2);
            return;
        }// end function

        public function updatePose(param1:String = "90", param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : Boolean
        {
            if (!param1)
            {
                Log.error("actName为null");
                return false;
            }
            this._actName = param1;
            this._repeat = param2;
            this._playOverRemove = param4;
            this._playOverFinalize = param5;
            this._useDefault = param3;
            return this.doUpdatePose();
        }// end function

        private function doUpdatePose() : Boolean
        {
            if (VMCGPUManager.isLoaded(this._url))
            {
                this.poseInfo = VMCGPUManager.getPoseInfo(this._url, this._actName);
            }
            else
            {
                if (VMCGPUManager.isLoading(this._url))
                {
                    return false;
                }
                if (this._useDefault && this._defaultURL)
                {
                    this.poseInfo = VMCGPUManager.getPoseInfo(this._defaultURL, this._actName);
                    this._url = this._defaultURL;
                }
                else
                {
                    return false;
                }
            }
            if (this._poseInfo)
            {
                this._poseInfo.repeat = this._repeat;
                this.update();
                return true;
            }
            return false;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            if (this.inters != null && this.poses != null && this.offsets != null)
            {
                this.doScale();
            }
            return;
        }// end function

        public function get scale() : Number
        {
            return this._scale;
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

        public function update() : void
        {
            if (this.inters != null && this.poses != null)
            {
                this.playing = true;
                this.lastPoseTime = getTimer();
                this.updateTexture();
                this.paint();
                this.doScale();
            }
            return;
        }// end function

        private function updateTexture() : void
        {
            var _loc_1:* = VMCGPUManager.getTexture(this._url);
            if (_loc_1)
            {
                if (!this._image)
                {
                    this._image = new Image(_loc_1);
                    this._image.smoothing = TextureSmoothing.NONE;
                    this._image.width = 100;
                    this._image.height = 130;
                }
                else
                {
                    this._image.texture = _loc_1;
                }
            }
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
            var _loc_2:* = null;
            var _loc_1:* = this.poses;
            if (_loc_1 != null)
            {
                if (this._poseProgress < _loc_1.length)
                {
                    if (this._curBmdName != _loc_1[this._poseProgress])
                    {
                        this._curBmdName = _loc_1[this._poseProgress];
                        if (this._image)
                        {
                            _loc_2 = VMCGPUManager.getImgRects(this._url, this._curBmdName);
                            if (_loc_2)
                            {
                                this._image.width = _loc_2[4];
                                this._image.height = _loc_2[5];
                                this._image.setTexCoords(0, _loc_2[0]);
                                this._image.setTexCoords(1, _loc_2[1]);
                                this._image.setTexCoords(2, _loc_2[2]);
                                this._image.setTexCoords(3, _loc_2[3]);
                                if (this._image.parent == null)
                                {
                                    addChild(this._image);
                                }
                            }
                            return true;
                        }
                    }
                }
            }
            else
            {
                Log.log(this._url, "pose == null,无姿势设定");
            }
            return false;
        }// end function

        protected function countInter() : void
        {
            this._interval = this.inters[this._poseProgress] * FrameworkGlobal.GLOBAL_BMP_MULTIPLE;
            if (this._playInterMultiple != 1)
            {
                this._interval = this._interval * this._playInterMultiple;
            }
            return;
        }// end function

        public function paintOffset() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            if (!this._image)
            {
                return;
            }
            var _loc_1:* = this.offsets;
            if (_loc_1 != null)
            {
                if (this._poseProgress < _loc_1.length)
                {
                    _loc_2 = _loc_1[this._poseProgress];
                    if (_loc_2 != null)
                    {
                        if (_loc_2.length == 2)
                        {
                            if (this._direct > 0)
                            {
                                if (this._image.scaleX < 0)
                                {
                                    this._image.scaleX = Math.abs(scaleX);
                                }
                                _loc_3 = _loc_2[0] * this._scale;
                            }
                            else
                            {
                                if (scaleX > 0)
                                {
                                    scaleX = -Math.abs(scaleX);
                                }
                                _loc_3 = (-_loc_2[0]) * this._scale;
                            }
                            _loc_4 = _loc_2[1] * this._scale;
                            if (_loc_3 != this._image.x)
                            {
                                this._image.x = _loc_3;
                            }
                            if (_loc_4 != this._image.y)
                            {
                                this._image.y = _loc_4;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        protected function nextFrame() : void
        {
            if (this._poseProgress < (this.inters.length - 1))
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
            }
            return;
        }// end function

        public function actComplete() : void
        {
            return;
        }// end function

        public function set auto(param1:Boolean) : void
        {
            if (param1)
            {
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

        public function play() : void
        {
            this.playing = true;
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

        public function enterFrame(event:Event = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (this.playing)
            {
                _loc_2 = this.inters;
                if (_loc_2 != null)
                {
                    if (_loc_2.length > 0)
                    {
                        this.nowTime = getTimer();
                        _loc_3 = this._poseProgress;
                        while (this.nowTime - this.lastPoseTime > this._interval)
                        {
                            
                            this.lastPoseTime = this.lastPoseTime + this._interval;
                            this.nextFrame();
                        }
                        if (_loc_3 != this._poseProgress)
                        {
                            this.paint();
                        }
                    }
                }
            }
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function set url(param1:String) : void
        {
            this._url = param1;
            return;
        }// end function

    }
}
