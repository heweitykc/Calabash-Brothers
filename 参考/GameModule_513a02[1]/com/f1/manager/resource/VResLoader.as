package com.f1.manager.resource
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;

    public class VResLoader extends EventDispatcher
    {
        private var _loaded:Boolean;
        private var _loading:Boolean;
        private var _loader:Object;
        private var fileType:String;
        public var data:Object;
        private var _loadObj:VResLoadObj;

        public function VResLoader(param1:VResLoadObj)
        {
            this._loadObj = param1;
            return;
        }// end function

        public function get loadObj() : VResLoadObj
        {
            return this._loadObj;
        }// end function

        public function set loadObj(param1:VResLoadObj) : void
        {
            this._loadObj = param1;
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

        public function get url() : String
        {
            if (this._loadObj)
            {
                return this._loadObj.url;
            }
            return null;
        }// end function

        public function get completeFuns() : Array
        {
            if (this._loadObj)
            {
                return this._loadObj.completeFuns;
            }
            return null;
        }// end function

        public function get callBackParams() : Array
        {
            if (this._loadObj)
            {
                return this._loadObj.callBackParams;
            }
            return null;
        }// end function

        public function get errFuns() : Array
        {
            if (this._loadObj)
            {
                return this._loadObj.errFuns;
            }
            return null;
        }// end function

        public function get progressFuns() : Array
        {
            if (this._loadObj)
            {
                return this._loadObj.progressFuns;
            }
            return null;
        }// end function

        private function getFileType(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            return _loc_2[(_loc_2.length - 1)].split("?")[0];
        }// end function

        public function startLoad() : void
        {
            var _loc_1:* = null;
            this._loading = true;
            this._loaded = false;
            this.fileType = this.getFileType(this.url);
            var _loc_2:* = LoadHelper.getTrueURL(this.url, this.loadObj.ignoreMD5);
            Log.log("开始加载", _loc_2);
            if (_loc_2)
            {
                TweenLite.delayedCall(15, this.overTime);
                if ((this.fileType == "jpg" || this.fileType == "png") && !this._loadObj.asByteArray)
                {
                    this._loader = new Loader();
                    this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.__loadResComplete);
                    this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.__loadProgress);
                    this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.__loadResFail);
                    this._loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.__loadResFail);
                    _loc_1 = new URLRequest(_loc_2);
                    this._loader.load(_loc_1);
                }
                else
                {
                    this._loader = new URLLoader();
                    if ((this.fileType == "txt" || this.fileType == "xml" || this.fileType == "json") && !this._loadObj.asByteArray)
                    {
                    }
                    else
                    {
                        this._loader.dataFormat = "binary";
                    }
                    this._loader.load(new URLRequest(_loc_2));
                    this._loader.addEventListener(Event.COMPLETE, this.__loadResComplete);
                    this._loader.addEventListener(ProgressEvent.PROGRESS, this.__loadProgress);
                    this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.__loadResFail);
                    this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.__loadResFail);
                }
            }
            else
            {
                Log.log(this.url, "在md5列表里面不存在");
                this.failCallBack();
                this.reset();
            }
            return;
        }// end function

        private function removeListeners(param1) : void
        {
            if (param1)
            {
                param1.removeEventListener(Event.COMPLETE, this.__loadResComplete);
                param1.removeEventListener(ProgressEvent.PROGRESS, this.__loadProgress);
                param1.removeEventListener(IOErrorEvent.IO_ERROR, this.__loadResFail);
                param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.__loadResFail);
            }
            return;
        }// end function

        private function decodePic(param1:ByteArray) : void
        {
            this._loader = new Loader();
            var _loc_2:* = new LoaderContext(false, ApplicationDomain.currentDomain);
            _loc_2.allowCodeImport = true;
            this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.__loadResComplete, false, 0, true);
            this._loader.loadBytes(param1, _loc_2);
            return;
        }// end function

        private function __loadResComplete(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._loading = false;
            this._loaded = true;
            this.removeListeners(event.currentTarget);
            if (event.currentTarget is URLLoader)
            {
                if (this.fileType == "swf" && !this._loadObj.asByteArray)
                {
                    _loc_2 = this._loader.data;
                    VResManager.decodeBuffer.addItem(this.decodePic, [_loc_2]);
                    return;
                }
                this.data = URLLoader(this._loader).data;
            }
            else
            {
                _loc_3 = LoaderInfo(event.currentTarget).loader;
                this.data = _loc_3.content;
                if (this.data is Bitmap)
                {
                    this.data = Bitmap(this.data).bitmapData;
                }
                _loc_3.unloadAndStop(false);
            }
            this.completeCallBack();
            this.reset();
            return;
        }// end function

        private function __loadProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = null;
            if (this.loadObj)
            {
                if (this.loadObj.groupInfo)
                {
                    this.loadObj.groupInfo.loadedSize = this.loadObj.groupInfo.loadedSize + (event.bytesLoaded - this.loadObj.loadedSize);
                }
                this.loadObj.loadedSize = event.bytesLoaded;
                for each (_loc_2 in this.progressFuns)
                {
                    
                    if (_loc_2 != null)
                    {
                        _loc_2.call(null, event, this.loadObj);
                    }
                }
            }
            return;
        }// end function

        protected function __loadResFail(event:ErrorEvent) : void
        {
            Log.log("加载失败", this.url);
            this.removeListeners(event.currentTarget);
            this.failCallBack();
            this.reset();
            return;
        }// end function

        public function addCallBack(param1:Function, param2:Array = null, param3:Function = null, param4:Function = null) : void
        {
            this._loadObj.addCallBack(param1, param2, param3, param4);
            return;
        }// end function

        public function removeCallBack(param1:Function, param2:Function = null, param3:Function = null) : void
        {
            if (this.completeFuns == null)
            {
                this.reset();
                this.notifyLoadNext();
                return;
            }
            var _loc_4:* = this.completeFuns.indexOf(param1);
            if (this.completeFuns.indexOf(param1) != -1)
            {
                this.completeFuns.splice(_loc_4, 1);
                this.callBackParams.splice(_loc_4, 1);
                this.errFuns.splice(_loc_4, 1);
                this.progressFuns.splice(_loc_4, 1);
            }
            if (!this.hasCallBack())
            {
                this.reset();
                this.notifyLoadNext();
            }
            return;
        }// end function

        public function hasCallBack() : Boolean
        {
            return this.completeFuns.length > 0;
        }// end function

        public function completeCallBack() : void
        {
            TweenLite.killDelayedCallsTo(this.overTime);
            this.notifyLoadOneComplete();
            return;
        }// end function

        protected function failCallBack() : void
        {
            TweenLite.killDelayedCallsTo(this.overTime);
            this.notifyLoadFail();
            return;
        }// end function

        protected function overTime() : void
        {
            Log.log("加载超时", this.url);
            this.notifyLoadNext();
            return;
        }// end function

        private function notifyLoadNext() : void
        {
            dispatchEvent(new VResEvent(VResEvent.NOTIFY_LOAD_NEXT));
            return;
        }// end function

        private function notifyLoadFail() : void
        {
            dispatchEvent(new VResEvent(VResEvent.NOTIFY_LOAD_FAIL));
            return;
        }// end function

        private function notifyLoadOneComplete() : void
        {
            dispatchEvent(new VResEvent(VResEvent.NOTIFY_LOAD_ONE_COMPLETE));
            return;
        }// end function

        public function reset() : void
        {
            TweenLite.killDelayedCallsTo(this.overTime);
            if (this._loader)
            {
                if (this._loader is Loader)
                {
                    this._loader.unloadAndStop(false);
                }
                this.removeListeners(this._loader);
            }
            this._loading = false;
            this._loaded = false;
            this._loadObj = null;
            this._loader = null;
            return;
        }// end function

        public function finalize() : void
        {
            this.reset();
            return;
        }// end function

    }
}
