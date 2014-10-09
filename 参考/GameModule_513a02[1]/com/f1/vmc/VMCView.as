package com.f1.vmc
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;

    public class VMCView extends BMPView implements IBaseEventDispatcher
    {
        private var _playOverFinalize:Boolean;
        private var _playOverRemove:Boolean;
        private var _useDefault:Boolean;
        private var _url:String;
        protected var _resLoading:Boolean;
        protected var _resLoaded:Boolean;
        private var _defaultURL:String;
        private var _actName:String;
        private var _poseInfo:PoseInfo;
        private var _frameNum:uint;
        private var _releaseTime:Number;
        private var _releaseFrame:int = -1;
        private var _effectTime:Number;
        private var _effectFrame:int = -1;
        private var _curBmdName:String;
        private var _lastTime:Number;
        private var _offsetX:Number;
        private var _rotate360:Boolean;
        private var _horseY:Number;
        private var _obj:Object;
        private var progressFun:Function;
        private var _appendList:Array;

        public function VMCView()
        {
            return;
        }// end function

        public function get effectTime() : Number
        {
            return this._effectTime;
        }// end function

        public function get releaseTime() : Number
        {
            return this._releaseTime;
        }// end function

        public function get frameNum() : uint
        {
            return this._frameNum;
        }// end function

        public function set frameNum(param1:uint) : void
        {
            this._frameNum = param1;
            return;
        }// end function

        public function get offsetX() : Number
        {
            return this._offsetX;
        }// end function

        public function set offsetX(param1:Number) : void
        {
            this._offsetX = param1;
            return;
        }// end function

        public function get rotate360() : Boolean
        {
            return this._rotate360;
        }// end function

        public function set rotate360(param1:Boolean) : void
        {
            this._rotate360 = param1;
            return;
        }// end function

        public function get releaseFrame() : uint
        {
            return this._releaseFrame;
        }// end function

        public function set releaseFrame(param1:uint) : void
        {
            this._releaseFrame = param1;
            return;
        }// end function

        public function get actName() : String
        {
            return this._actName;
        }// end function

        public function set actName(param1:String) : void
        {
            this._actName = param1;
            return;
        }// end function

        public function get resLoaded() : Boolean
        {
            return this._resLoaded;
        }// end function

        public function set resLoaded(param1:Boolean) : void
        {
            this._resLoaded = param1;
            return;
        }// end function

        public function get resLoading() : Boolean
        {
            return this._resLoading;
        }// end function

        public function set resLoading(param1:Boolean) : void
        {
            this._resLoading = param1;
            return;
        }// end function

        public function get offsetY() : Number
        {
            return this._poseInfo.offsetY;
        }// end function

        public function isEffect() : Boolean
        {
            if (_poseProgress > 0)
            {
                return poseProgress >= this._effectFrame;
            }
            return false;
        }// end function

        public function get poseInfo() : PoseInfo
        {
            return this._poseInfo;
        }// end function

        public function set poseInfo(param1:PoseInfo) : void
        {
            if (param1)
            {
                this._poseInfo = param1;
                this._frameNum = this._poseInfo.poses.length;
                _offsets = this._poseInfo.offsets;
                _inters = this._poseInfo.inters;
                _poses = this._poseInfo.poses;
                this._effectTime = this._poseInfo.effectTime;
                this._effectFrame = this._poseInfo.effectFrame;
                this._releaseTime = this._poseInfo.releaseTime;
                this._releaseFrame = this._poseInfo.releaseFrame;
                this._lastTime = this._poseInfo.lastTime;
                this._rotate360 = this._poseInfo.rotate360;
                this._offsetX = this._poseInfo.offsetX * this._poseInfo.scale;
                this._horseY = this._poseInfo.horseY * this._poseInfo.scale;
                this._curBmdName = null;
            }
            return;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set obj(param1) : void
        {
            this._obj = param1;
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function get curBmdName() : String
        {
            return this._curBmdName;
        }// end function

        public function set url(param1:String) : void
        {
            if (this._url != param1)
            {
                if (this._url)
                {
                    VMCManager.removeInstance(this._url);
                }
                this._url = param1;
                if (this._url)
                {
                    VMCManager.addInstance(this._url);
                }
            }
            return;
        }// end function

        public function get defaultURL() : String
        {
            return this._defaultURL;
        }// end function

        public function set defaultURL(param1:String) : void
        {
            this._defaultURL = param1;
            return;
        }// end function

        public function set poses(param1:Array) : void
        {
            this.poseInfo.poses = param1;
            return;
        }// end function

        public function get poses() : Array
        {
            return this.poseInfo.poses;
        }// end function

        public function set offsetY(param1:Number) : void
        {
            this.poseInfo.offsetY = param1;
            return;
        }// end function

        public function set effectTime(param1:Number) : void
        {
            this.poseInfo.effectTime = param1;
            return;
        }// end function

        public function set lastTime(param1:Number) : void
        {
            this.poseInfo.lastTime = param1;
            return;
        }// end function

        public function set delay(param1:Number) : void
        {
            this.poseInfo.delay = param1;
            return;
        }// end function

        public function cancelLoad(param1:String) : void
        {
            VMCManager.removeCallBack(param1, this.loadComplete, this.loadFail, this.onProgress, true);
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
                if (VMCManager.isLoading(this._url))
                {
                    this.cancelLoad(this._url);
                }
            }
            this.progressFun = param6;
            this.url = param1;
            this._defaultURL = param2;
            this._resLoading = true;
            this._resLoaded = false;
            this.visible = false;
            return VMCManager.addRes(this._url, this.loadComplete, [param4, param5, param7], this.loadFail, this.onProgress, param3, param8);
        }// end function

        private function loadComplete(param1:Function, param2:Array, param3:Function) : void
        {
            this.visible = true;
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
            this.visible = true;
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

        override public function set direct(param1:int) : void
        {
            var _loc_2:* = null;
            if (_direct != param1)
            {
                if (Math.abs(_direct) != Math.abs(param1))
                {
                    this._actName = Math.abs(param1).toString();
                    this.doUpdatePose();
                }
                super.direct = param1;
                if (this._appendList && this._appendList.length > 0)
                {
                    for each (_loc_2 in this._appendList)
                    {
                        
                        if (_loc_2)
                        {
                            _loc_2.direct = param1;
                        }
                    }
                }
            }
            return;
        }// end function

        override public function set playInterMultiple(param1:Number) : void
        {
            _playInterMultiple = param1;
            return;
        }// end function

        public function updatePose(param1:String = "90", param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : Boolean
        {
            if (!param1)
            {
                Log.error("actName为null");
                return false;
            }
            this._poseInfo = null;
            this._actName = param1;
            _repeat = param2;
            this._playOverRemove = param4;
            this._playOverFinalize = param5;
            this._useDefault = param3;
            _poseProgress = 0;
            return this.doUpdatePose();
        }// end function

        private function doUpdatePose() : Boolean
        {
            if (VMCManager.isLoaded(this._url))
            {
                this.poseInfo = VMCManager.getPoseInfo(this._url, this._actName);
            }
            else
            {
                if (VMCManager.isLoading(this._url))
                {
                    return false;
                }
                if (this._useDefault && this._defaultURL)
                {
                    this.poseInfo = VMCManager.getPoseInfo(this._defaultURL, this.actName);
                    this._url = this._defaultURL;
                }
                else
                {
                    return false;
                }
            }
            if (this._poseInfo)
            {
                this._poseInfo.poseIndex = _poseProgress;
                this._poseInfo.repeat = _repeat;
                super.update(this._poseInfo.poses, this._poseInfo.inters, this._poseInfo.offsets);
                return true;
            }
            return false;
        }// end function

        public function clearAppendList() : void
        {
            this._appendList = [];
            return;
        }// end function

        public function appendView(param1:VMCView) : void
        {
            if (!this._appendList)
            {
                this._appendList = [];
            }
            if (this._appendList.indexOf(param1) == -1)
            {
                this._appendList.push(param1);
            }
            this.paintAppendView(param1);
            return;
        }// end function

        public function removeAppend(param1:VMCView) : void
        {
            var _loc_2:* = 0;
            if (this._appendList && this._appendList.length > 0)
            {
                _loc_2 = this._appendList.indexOf(param1);
                if (_loc_2 != -1)
                {
                    this._appendList.splice(_loc_2, 1);
                }
            }
            return;
        }// end function

        override protected function countInter() : void
        {
            if (FrameworkGlobal.GLOBAL_BMP_MULTIPLE != 1)
            {
                _interval = _inters[poseProgress] * FrameworkGlobal.GLOBAL_BMP_MULTIPLE;
            }
            else
            {
                _interval = _inters[poseProgress];
            }
            if (_playInterMultiple != 1)
            {
                _interval = Math.ceil(_interval * _playInterMultiple);
            }
            return;
        }// end function

        override public function paint() : void
        {
            var _loc_1:* = null;
            super.paint();
            if (this._appendList && this._appendList.length > 0)
            {
                for each (_loc_1 in this._appendList)
                {
                    
                    if (_loc_1 && _loc_1.poseInfo)
                    {
                        this.paintAppendView(_loc_1);
                    }
                }
            }
            return;
        }// end function

        private function paintAppendView(param1:VMCView) : void
        {
            param1.poseProgress = poseProgress;
            if (param1.paintPose())
            {
                param1.paintOffset();
            }
            return;
        }// end function

        override public function paintPose() : Boolean
        {
            var _loc_1:* = null;
            if (this._url)
            {
                if (_poses != null)
                {
                    if (_poseProgress < _poses.length)
                    {
                        if (this._curBmdName != _poses[_poseProgress])
                        {
                            this._curBmdName = _poses[_poseProgress];
                            _loc_1 = VMCManager.getBmd(this._url, this._curBmdName);
                            if (_loc_1 && bitmapData != _loc_1)
                            {
                                bitmapData = _loc_1;
                                return true;
                            }
                        }
                    }
                }
                else
                {
                    Log.log(this.url, "pose == null,无姿势设定");
                }
            }
            return false;
        }// end function

        override public function actComplete() : void
        {
            if (!_repeat)
            {
                stop();
                if (this._playOverRemove)
                {
                    this.removeFromParent(this._playOverFinalize);
                }
            }
            super.actComplete();
            return;
        }// end function

        override public function removeFromParent(param1:Boolean = false) : void
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

        override protected function nextFrame() : void
        {
            if (!_repeat)
            {
                if (_poseProgress == this._effectFrame)
                {
                    dispatchEvent(new VMCEvent(VMCEvent.ACT_EFECT));
                }
                if (_poseProgress == this._releaseFrame)
                {
                    dispatchEvent(new VMCEvent(VMCEvent.ACT_RELEASE));
                }
            }
            super.nextFrame();
            return;
        }// end function

        public function addEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            addEventListener(param1, param2, param3, 0, param4);
            return;
        }// end function

        public function addEvtListeners(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in param1)
            {
                
                this.addEvtListener(_loc_5, param2, param3, param4);
            }
            return;
        }// end function

        public function removeEvtListener(param1:String, param2:Function) : void
        {
            removeEventListener(param1, param2);
            return;
        }// end function

        public function getBaseEventDispatcher() : IBaseEventDispatcher
        {
            return this;
        }// end function

        public function dispatchEvt(event:Event) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

        override public function finalize() : void
        {
            stop();
            this._appendList = null;
            this._poseInfo = null;
            this._obj = null;
            if (this._resLoading)
            {
                VMCManager.removeCallBack(this._url, this.loadComplete, this.loadFail, this.onProgress);
            }
            this.progressFun = null;
            this.url = null;
            super.finalize();
            return;
        }// end function

        public function get horseY() : Number
        {
            return this._horseY;
        }// end function

        public function set horseY(param1:Number) : void
        {
            this._horseY = param1;
            return;
        }// end function

    }
}
