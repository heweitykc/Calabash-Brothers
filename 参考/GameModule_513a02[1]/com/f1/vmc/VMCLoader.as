package com.f1.vmc
{
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class VMCLoader extends Object
    {
        public var lastUsedTime:uint;
        public var instanceNum:int;
        private var _loaded:Boolean;
        private var _loading:Boolean;
        private var _keep:Boolean;
        private var _bmds:Dictionary;
        private var _poseInfos:Dictionary;
        public var imgCfgs:Array;
        public var cfgs:Object;
        private var _url:String;
        private var _completeFuns:Array;
        private var _callBackParams:Array;
        private var _failFuns:Array;
        private var _progressFuns:Array;
        private var byteLoader:Loader;
        public static const BLEND_MODES:Array = [BlendMode.NORMAL, BlendMode.HARDLIGHT, BlendMode.ADD, BlendMode.LIGHTEN, BlendMode.OVERLAY];

        public function VMCLoader(param1:Function, param2:Array = null, param3:Function = null, param4:Function = null)
        {
            this._bmds = new Dictionary();
            this._completeFuns = [];
            this._callBackParams = [];
            this._failFuns = [];
            this._progressFuns = [];
            if (param1 != null)
            {
                this.addCallBack(param1, param2, param3, param4);
            }
            return;
        }// end function

        public function get keep() : Boolean
        {
            return this._keep;
        }// end function

        public function set keep(param1:Boolean) : void
        {
            this._keep = param1;
            return;
        }// end function

        public function get poseInfos() : Dictionary
        {
            return this._poseInfos;
        }// end function

        public function set poseInfos(param1:Dictionary) : void
        {
            this._poseInfos = param1;
            return;
        }// end function

        public function get bmds() : Dictionary
        {
            return this._bmds;
        }// end function

        public function set bmds(param1:Dictionary) : void
        {
            this._bmds = param1;
            return;
        }// end function

        public function get callBackParams() : Array
        {
            return this._callBackParams;
        }// end function

        public function set callBackParams(param1:Array) : void
        {
            this._callBackParams = param1;
            return;
        }// end function

        public function get failFuns() : Array
        {
            return this._failFuns;
        }// end function

        public function set failFuns(param1:Array) : void
        {
            this._failFuns = param1;
            return;
        }// end function

        public function get progressFuns() : Array
        {
            return this._progressFuns;
        }// end function

        public function set progressFuns(param1:Array) : void
        {
            this._progressFuns = param1;
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

        public function get completeFuns() : Array
        {
            return this._completeFuns;
        }// end function

        public function set completeFuns(param1:Array) : void
        {
            this._completeFuns = param1;
            return;
        }// end function

        public function get loading() : Boolean
        {
            return this._loading;
        }// end function

        public function get loaded() : Boolean
        {
            return this._loaded;
        }// end function

        public function addCallBack(param1:Function, param2:Array = null, param3:Function = null, param4:Function = null) : void
        {
            if (this._completeFuns)
            {
                this._completeFuns.push(param1);
            }
            if (this._callBackParams)
            {
                this._callBackParams.push(param2);
            }
            if (this._failFuns)
            {
                this._failFuns.push(param3);
            }
            if (this._progressFuns)
            {
                this._progressFuns.push(param4);
            }
            return;
        }// end function

        public function removeCallBack(param1:Function, param2:Function = null, param3:Function = null, param4:Boolean = false) : void
        {
            if (!this.hasCallBack())
            {
                return;
            }
            var _loc_5:* = this._completeFuns.indexOf(param1);
            if (this._completeFuns.indexOf(param1) != -1)
            {
                Log.log("ZBFManager removeCallBack 清除回调函数 ", this.url);
                this._completeFuns.splice(_loc_5, 1);
                this._callBackParams.splice(_loc_5, 1);
                this._failFuns.splice(_loc_5, 1);
                this._progressFuns.splice(_loc_5, 1);
            }
            if (!param4 && !this.hasCallBack())
            {
                this.reset();
            }
            return;
        }// end function

        public function hasCallBack() : Boolean
        {
            return this._completeFuns.length > 0;
        }// end function

        public function getPoseInfo(param1:String) : PoseInfo
        {
            if (this._poseInfos)
            {
                return this._poseInfos[param1];
            }
            return null;
        }// end function

        public function getBmd(param1:String) : BitmapData
        {
            return this._bmds[param1];
        }// end function

        public function loadRes(param1:String, param2:int = 0) : void
        {
            this._url = param1;
            Log.log("VMCLoader loadRes ", param1);
            this._loading = true;
            this._loaded = false;
            VResManager.load(param1, this.__loadResSuccess, null, this.__loadResFail, this.__loadProgress, false, true, false, param2);
            return;
        }// end function

        private function __loadResSuccess(param1:ByteArray) : void
        {
            if (param1)
            {
                this.writeRes(param1);
            }
            return;
        }// end function

        private function __loadProgress(event:ProgressEvent, param2:VResLoadObj) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in this._progressFuns)
            {
                
                if (_loc_3 != null)
                {
                    _loc_3.call(null, event, param2);
                }
            }
            return;
        }// end function

        protected function __loadResFail() : void
        {
            Log.log("VMCLoader加载失败", this.url);
            this.doCallBack(this._failFuns);
            this.reset();
            return;
        }// end function

        public function writeRes(param1:ByteArray) : void
        {
            var _loc_5:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            Log.log("VMC解析", this._url);
            if (!param1)
            {
                Log.log(this._url, "二进制资源为空");
                this.reset();
                return;
            }
            param1.position = 0;
            param1.position = param1.length - 4;
            var _loc_2:* = param1.readInt();
            param1.position = 0;
            var _loc_3:* = new ByteArray();
            if (param1.bytesAvailable >= _loc_2)
            {
                param1.readBytes(_loc_3, 0, _loc_2);
            }
            else
            {
                Log.log("VMC文件格式有问题", this.url);
                this._loading = false;
                this._loaded = true;
                this.doCallBack(this._completeFuns);
                this.removeFuns();
                return;
            }
            this.cfgs = param1.readObject();
            if (this.cfgs == null)
            {
                Log.error("VMC文件格式有问题", this.url);
                this._loading = false;
                this._loaded = true;
                this.doCallBack(this._completeFuns);
                this.removeFuns();
                return;
            }
            this.imgCfgs = param1.readObject() as Array;
            this._poseInfos = new Dictionary();
            var _loc_4:* = uint(this.cfgs.allTime) / 1000;
            if (this.cfgs.blendMode)
            {
                _loc_5 = this.cfgs.blendMode;
            }
            var _loc_6:* = this.cfgs.scale;
            var _loc_7:* = this.cfgs.repeatPlay;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            if (!_loc_7)
            {
                if (this.cfgs.effectTime > 0)
                {
                    _loc_8 = uint(this.cfgs.effectTime) / 1000;
                }
                else
                {
                    _loc_8 = _loc_4 / 2;
                }
                if (this.cfgs.effectFrame > 0)
                {
                    _loc_9 = this.cfgs.effectFrame;
                }
                else if (this.cfgs.inter)
                {
                    _loc_9 = this.cfgs.inter.length / 2;
                }
            }
            var _loc_10:* = uint(this.cfgs.releaseTime) / 1000;
            var _loc_11:* = this.cfgs.releaseFrame;
            for (_loc_13 in this.cfgs.offset)
            {
                
                _loc_12 = new PoseInfo();
                _loc_12.inters = this.cfgs.inter;
                _loc_12.offsets = _loc_17[_loc_13];
                if (!isNaN(this.cfgs.offsetY) && this.cfgs.offsetY != undefined)
                {
                    _loc_12.offsetY = Number(this.cfgs.offsetY);
                }
                if (!isNaN(this.cfgs.offsetX) && this.cfgs.offsetX != undefined)
                {
                    _loc_12.offsetX = Number(this.cfgs.offsetX);
                }
                _loc_12.rotate360 = this.cfgs.rotate360;
                _loc_12.lastTime = _loc_4;
                _loc_12.effectTime = _loc_8;
                _loc_12.effectFrame = _loc_9;
                _loc_12.releaseTime = _loc_10;
                _loc_12.releaseFrame = _loc_11;
                _loc_14 = _loc_12.offsets.length;
                _loc_12.poses = [];
                _loc_15 = 0;
                while (_loc_15 < _loc_14)
                {
                    
                    _loc_12.poses.push(_loc_13 + "_" + _loc_15);
                    _loc_15 = _loc_15 + 1;
                }
                _loc_12.blendMode = _loc_5;
                _loc_12.scale = _loc_6;
                _loc_12.horseY = this.cfgs.horseY;
                this._poseInfos[_loc_13] = _loc_12;
            }
            VMCManager.decodeBuffer.addItem(this.decodePic, [_loc_3]);
            return;
        }// end function

        private function decodePic(param1:ByteArray) : void
        {
            this.byteLoader = new Loader();
            this.byteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.__picLoadComplete);
            this.byteLoader.loadBytes(param1);
            return;
        }// end function

        private function __picLoadComplete(event:Event) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            Log.log("VMC解析完毕", this._url);
            var _loc_2:* = event.target as LoaderInfo;
            _loc_2.removeEventListener(Event.COMPLETE, this.__picLoadComplete);
            var _loc_3:* = (_loc_2.content as Bitmap).bitmapData;
            _loc_2.loader.unloadAndStop(false);
            if (_loc_3 && _loc_3.width > 0 && _loc_3.height > 0)
            {
                _loc_5 = this.imgCfgs.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    _loc_6 = this.imgCfgs[_loc_7];
                    if (_loc_6.w > 0 && _loc_6.h > 0)
                    {
                        _loc_4 = new BitmapData(_loc_6.w, _loc_6.h);
                        _loc_4.copyPixels(_loc_3, new Rectangle(_loc_6.x, _loc_6.y, _loc_6.w, _loc_6.h), new Point(0, 0));
                        this._bmds[_loc_6.n] = _loc_4;
                    }
                    else
                    {
                        this._bmds[_loc_6.n] = null;
                    }
                    _loc_7++;
                }
                _loc_3.dispose();
                _loc_3 = null;
                this._loading = false;
                this._loaded = true;
                this.doCallBack(this._completeFuns);
                this.removeFuns();
            }
            else
            {
                this.__loadResFail();
            }
            return;
        }// end function

        protected function doCallBack(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (param1 == null || this._callBackParams == null)
            {
                return;
            }
            var _loc_2:* = param1.length;
            if (_loc_2 != this._callBackParams.length)
            {
                Log.log("doCallBack Funs Length Error");
                return;
            }
            var _loc_5:* = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_3 = param1[_loc_5];
                _loc_4 = this._callBackParams[_loc_5];
                if (_loc_3 != null)
                {
                    if (_loc_4 == null)
                    {
                        _loc_3.apply(null);
                    }
                    else
                    {
                        _loc_3.apply(null, _loc_4);
                    }
                }
                _loc_5++;
            }
            return;
        }// end function

        private function removeFuns() : void
        {
            this._completeFuns = [];
            this._callBackParams = [];
            this._progressFuns = [];
            this._failFuns = [];
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            if (this.byteLoader)
            {
                this.byteLoader.unloadAndStop(false);
                this.byteLoader = null;
            }
            this._loading = false;
            this._loaded = false;
            this.removeFuns();
            for each (_loc_1 in this._bmds)
            {
                
                if (_loc_1 != null)
                {
                    _loc_1.dispose();
                }
            }
            return;
        }// end function

        public function finalize() : void
        {
            Log.log("VMCLoader finalize", this._url);
            this.reset();
            this._completeFuns = [];
            this._callBackParams = null;
            this._progressFuns = null;
            this._failFuns = null;
            return;
        }// end function

    }
}
