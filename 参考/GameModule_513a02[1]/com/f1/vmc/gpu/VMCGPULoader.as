package com.f1.vmc.gpu
{
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.textures.*;

    public class VMCGPULoader extends Object
    {
        private var _loaded:Boolean;
        private var _loading:Boolean;
        private var _keep:Boolean;
        private var _bmds:Dictionary;
        public var texture:Texture;
        private var _poseInfos:Dictionary;
        private var imgCfgs:Array;
        private var _url:String;
        private var _completeFuns:Array;
        private var _callBackParams:Array;
        private var _failFuns:Array;
        private var _progressFuns:Array;
        private var byteLoader:Loader;
        public static const BLEND_MODES:Array = [BlendMode.NORMAL, BlendMode.HARDLIGHT, BlendMode.ADD, BlendMode.LIGHTEN, BlendMode.OVERLAY];
        private static var decodeBuffer:FunctionBuffer = new FunctionBuffer(2, true);

        public function VMCGPULoader(param1:Function, param2:Array = null, param3:Function = null, param4:Function = null)
        {
            this._completeFuns = [];
            this._callBackParams = [];
            this._failFuns = [];
            this._progressFuns = [];
            this.addCallBack(param1, param2, param3, param4);
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
            this._completeFuns.push(param1);
            this._callBackParams.push(param2);
            this._failFuns.push(param3);
            this._progressFuns.push(param4);
            return;
        }// end function

        public function removeCallBack(param1:Function, param2:Function = null, param3:Function = null) : void
        {
            var _loc_4:* = this._completeFuns.indexOf(param1);
            if (this._completeFuns.indexOf(param1) != -1)
            {
                Log.log("ZBFManager removeCallBack 清除回调函数 ", this.url);
                this._completeFuns.splice(_loc_4, 1);
                this._callBackParams.splice(_loc_4, 1);
                this._failFuns.splice(_loc_4, 1);
                this._progressFuns.splice(_loc_4, 1);
            }
            if (!this.hasCallBack())
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
            Log.log("VMCGPULoader loadRes ", param1);
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
            var _loc_6:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
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
            param1.readBytes(_loc_3, 0, _loc_2);
            var _loc_4:* = param1.readObject();
            this.imgCfgs = param1.readObject() as Array;
            this._poseInfos = new Dictionary();
            var _loc_5:* = uint(_loc_4.allTime) / 1000;
            if (_loc_4.blendMode)
            {
                _loc_6 = _loc_4.blendMode;
            }
            var _loc_7:* = _loc_4.scale;
            var _loc_8:* = _loc_4.repeatPlay;
            var _loc_9:* = 0;
            var _loc_10:* = 0;
            if (!_loc_8)
            {
                if (_loc_4.effectTime > 0)
                {
                    _loc_9 = uint(_loc_4.effectTime) / 1000;
                }
                else
                {
                    _loc_9 = _loc_5 / 2;
                }
                if (_loc_4.effectFrame > 0)
                {
                    _loc_10 = _loc_4.effectFrame;
                }
                else
                {
                    _loc_10 = _loc_4.inter.length / 2;
                }
            }
            var _loc_11:* = uint(_loc_4.releaseTime) / 1000;
            var _loc_12:* = _loc_4.releaseFrame;
            for (_loc_14 in _loc_4.offset)
            {
                
                _loc_13 = new PoseInfo();
                _loc_13.inters = _loc_4.inter;
                _loc_13.offsets = _loc_18[_loc_14];
                if (!isNaN(_loc_4.offsetY) && _loc_4.offsetY != undefined)
                {
                    _loc_13.offsetY = Number(_loc_4.offsetY);
                }
                if (!isNaN(_loc_4.offsetX) && _loc_4.offsetX != undefined)
                {
                    _loc_13.offsetX = Number(_loc_4.offsetX);
                }
                _loc_13.rotate360 = _loc_4.rotate360;
                _loc_13.lastTime = _loc_5;
                _loc_13.effectTime = _loc_9;
                _loc_13.effectFrame = _loc_10;
                _loc_13.releaseTime = _loc_11;
                _loc_13.releaseFrame = _loc_12;
                _loc_15 = _loc_13.offsets.length;
                _loc_13.poses = [];
                _loc_16 = 0;
                while (_loc_16 < _loc_15)
                {
                    
                    _loc_13.poses.push(_loc_14 + "_" + _loc_16);
                    _loc_16 = _loc_16 + 1;
                }
                _loc_13.blendMode = _loc_6;
                _loc_13.scale = _loc_7;
                _loc_13.horseY = _loc_4.horseY;
                this._poseInfos[_loc_14] = _loc_13;
            }
            decodeBuffer.addItem(this.decodePic, [_loc_3]);
            return;
        }// end function

        private function decodePic(param1:ByteArray) : void
        {
            this.texture = Texture.fromAtfData(param1, 1, false, this.uploadATFComplete);
            return;
        }// end function

        private function uploadATFComplete() : void
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_1:* = this.texture.width;
            var _loc_2:* = this.texture.height;
            this._bmds = new Dictionary();
            var _loc_3:* = this.imgCfgs.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_4 = this.imgCfgs[_loc_5];
                if (_loc_4.w > 0 && _loc_4.h > 0)
                {
                    _loc_6 = [new Point(_loc_4.x / _loc_1, _loc_4.y / _loc_2), new Point((_loc_4.x + _loc_4.w) / _loc_1, _loc_4.y / _loc_2), new Point(_loc_4.x / _loc_1, (_loc_4.y + _loc_4.h) / _loc_2), new Point((_loc_4.x + _loc_4.w) / _loc_1, (_loc_4.y + _loc_4.h) / _loc_2), _loc_4.w, _loc_4.h];
                    this._bmds[_loc_4.n] = _loc_6;
                }
                else
                {
                    this._bmds[_loc_4.n] = null;
                }
                _loc_5 = _loc_5 + 1;
            }
            this._loading = false;
            this._loaded = true;
            this.doCallBack(this._completeFuns);
            this.removeFuns();
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
            if (this.byteLoader)
            {
                this.byteLoader.unloadAndStop(false);
                this.byteLoader = null;
            }
            this._loading = false;
            this._loaded = false;
            this.removeFuns();
            if (this.texture)
            {
                this.texture.dispose();
                this.texture = null;
            }
            return;
        }// end function

        public function finalize() : void
        {
            Log.log("VMCLoader finalize", this._url);
            this.reset();
            this._completeFuns = null;
            this._callBackParams = null;
            this._progressFuns = null;
            this._failFuns = null;
            return;
        }// end function

    }
}
