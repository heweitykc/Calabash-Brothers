package com.f1.manager.resource
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.events.*;
    import flash.utils.*;

    public class VResManager extends Object
    {
        private var _resDic:Dictionary;
        public var domains:Dictionary;
        private var _loadObjArr:Array;
        private var _loaderDic:Dictionary;
        private var doLoadBuffer:FunctionBuffer;
        private var _loadBudget:int = 3;
        public static var decodeBuffer:FunctionBuffer = new FunctionBuffer(1, true);
        private static var instance:VResManager;

        public function VResManager()
        {
            this._resDic = new Dictionary();
            this.domains = new Dictionary();
            this._loadObjArr = [];
            this._loaderDic = new Dictionary();
            return;
        }// end function

        public function get resDic() : Dictionary
        {
            return this._resDic;
        }// end function

        private function loadRes(param1:String, param2:Function, param3:Array, param4:Function, param5:Function, param6:Boolean, param7:Boolean, param8:Boolean, param9:int = 0) : void
        {
            var _loc_10:* = this._resDic[param1];
            if (this._resDic[param1])
            {
                if (param2 != null)
                {
                    if (param3 == null)
                    {
                        param2.apply(null, [_loc_10]);
                    }
                    else
                    {
                        param3.unshift(_loc_10);
                        param2.apply(null, param3);
                    }
                }
                return;
            }
            this.loadOneRes(param1, param2, param3, param4, param5, param6, null, param7, param9, param8);
            this.startLoad();
            return;
        }// end function

        public function cancelLoads(param1:Array, param2:Function) : void
        {
            var _loc_3:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this.cancelLoad(param1[_loc_4], param2);
                _loc_4 = _loc_4 + 1;
            }
            return;
        }// end function

        public function cancelLoad(param1:String, param2:Function = null) : void
        {
            var _loc_3:* = this.getLoadObjByURL(param1);
            if (_loc_3)
            {
                this._loadObjArr.splice(this._loadObjArr.indexOf(_loc_3), 1);
            }
            var _loc_4:* = this._loaderDic[param1];
            if (this._loaderDic[param1])
            {
                _loc_4.removeCallBack(param2);
            }
            return;
        }// end function

        private function loadResGroup(param1:Array, param2:Function, param3:Array, param4:Function, param5:Function, param6:Function, param7:Array, param8:Boolean, param9:Boolean, param10:Boolean = false, param11:Number = 0, param12:int = 0) : void
        {
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = null;
            var _loc_13:* = new VResGroupInfo();
            _loc_13.completeFun = param6;
            _loc_13.completeParams = param7;
            _loc_13.failBackToo = param10;
            _loc_13.overtime = param11;
            var _loc_14:* = param1.length;
            var _loc_17:* = 0;
            while (_loc_17 < _loc_14)
            {
                
                _loc_15 = param1[_loc_17];
                if (param3)
                {
                    _loc_16 = param3;
                    if (_loc_14 == _loc_16.length && _loc_16[_loc_17] is Array)
                    {
                        _loc_16 = _loc_16[_loc_17];
                    }
                    else
                    {
                        _loc_16 = param3;
                    }
                }
                _loc_18 = this._resDic[_loc_15];
                if (_loc_18)
                {
                    if (param2 != null)
                    {
                        if (_loc_16 == null)
                        {
                            param2.apply(null, [_loc_18]);
                        }
                        else
                        {
                            param2.apply(null, [_loc_18].concat(_loc_16));
                        }
                    }
                    if (param5 != null)
                    {
                        _loc_19 = new VResLoadObj();
                        _loc_19.groupInfo = _loc_13;
                        _loc_13.totalSize = 1;
                        _loc_13.loadedSize = 1;
                        _loc_19.url = _loc_15;
                        param5.apply(null, [new ProgressEvent(ProgressEvent.PROGRESS, false, false, 1, 1), _loc_19]);
                    }
                }
                else
                {
                    this.loadOneRes(_loc_15, param2, _loc_16, param4, param5, param8, _loc_13, param9, param12);
                }
                _loc_17++;
            }
            if (_loc_13.needLoad == 0)
            {
                _loc_13.callBack();
            }
            this.startLoad();
            return;
        }// end function

        private function loadOneRes(param1:String, param2:Function, param3:Array, param4:Function, param5:Function, param6:Boolean, param7:VResGroupInfo, param8:Boolean, param9:int = 0, param10:Boolean = false) : void
        {
            var _loc_11:* = null;
            _loc_11 = this.getLoadObjByURL(param1);
            if (_loc_11)
            {
                if (_loc_11.completeFuns.indexOf(param2) == -1)
                {
                    _loc_11.addCallBack(param2, param3, param4, param5);
                }
                return;
            }
            var _loc_12:* = this._loaderDic[param1];
            if (this._loaderDic[param1])
            {
                if (_loc_12.loading)
                {
                    if (_loc_12.completeFuns.indexOf(param2) == -1)
                    {
                        _loc_12.addCallBack(param2, param3, param4, param5);
                    }
                    return;
                }
            }
            _loc_11 = new VResLoadObj();
            _loc_11.url = param1;
            _loc_11.asByteArray = param8;
            _loc_11.keep = param6;
            _loc_11.size = LoadHelper.getFileSize(param1);
            _loc_11.completeFuns.push(param2);
            _loc_11.callBackParams.push(param3);
            _loc_11.errFuns.push(param4);
            _loc_11.progressFuns.push(param5);
            _loc_11.ignoreMD5 = param10;
            _loc_11.preLoad = param9;
            if (param7)
            {
                _loc_11.groupInfo = param7;
                param7.totalSize = param7.totalSize + _loc_11.size;
                var _loc_13:* = param7;
                var _loc_14:* = _loc_13.needLoad + 1;
                _loc_13.needLoad = _loc_14;
            }
            this._loadObjArr.push(_loc_11);
            return;
        }// end function

        private function getLoadObjByURL(param1:String) : VResLoadObj
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._loadObjArr)
            {
                
                if (_loc_2.url == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function loadOneComplete(param1, param2:VResLoadObj, param3:Boolean = true) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param3 && param2 && param2.preLoad <= 999)
            {
                var _loc_9:* = this;
                var _loc_10:* = this.loadBudget + 1;
                _loc_9.loadBudget = _loc_10;
            }
            this.startLoad();
            if (!param2)
            {
                return;
            }
            Log.log("加载", param2.url, "成功");
            if (param2.completeFuns == null || param2.callBackParams == null)
            {
                return;
            }
            var _loc_4:* = param2.completeFuns.length;
            if (param2.completeFuns.length != param2.callBackParams.length)
            {
                return;
            }
            var _loc_7:* = 0;
            while (_loc_7 < _loc_4)
            {
                
                _loc_5 = param2.completeFuns[_loc_7];
                _loc_6 = param2.callBackParams[_loc_7];
                if (_loc_5 != null)
                {
                    if (param1 is ByteArray)
                    {
                        ByteArray(param1).position = 0;
                    }
                    if (_loc_6 == null)
                    {
                        _loc_5.apply(null, [param1]);
                    }
                    else
                    {
                        _loc_5.apply(null, [param1].concat(_loc_6));
                    }
                }
                _loc_7++;
            }
            if (param2.keep)
            {
                this._resDic[param2.url] = param1;
            }
            var _loc_8:* = param2.groupInfo;
            if (param2.groupInfo)
            {
                var _loc_9:* = _loc_8;
                var _loc_10:* = _loc_8.loaded + 1;
                _loc_9.loaded = _loc_10;
                if (_loc_8.allLoadComplete())
                {
                    Log.log("组加载完毕");
                    _loc_8.callBack();
                }
            }
            this.removeLoader(param2);
            return;
        }// end function

        public function loadFail(param1:VResLoadObj) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (!param1)
            {
                return;
            }
            if (param1.preLoad <= 999)
            {
                var _loc_7:* = this;
                var _loc_8:* = this.loadBudget + 1;
                _loc_7.loadBudget = _loc_8;
            }
            this.startLoad();
            if (param1.errFuns != null)
            {
                _loc_3 = param1.errFuns.length;
                if (_loc_3 == param1.callBackParams.length)
                {
                    _loc_6 = 0;
                    while (_loc_6 < _loc_3)
                    {
                        
                        _loc_4 = param1.errFuns[_loc_6];
                        _loc_5 = param1.callBackParams[_loc_6];
                        if (_loc_4 != null)
                        {
                            if (_loc_5 == null)
                            {
                                _loc_4.call(null);
                            }
                            else
                            {
                                _loc_4.apply(null, _loc_5);
                            }
                        }
                        _loc_6++;
                    }
                }
            }
            var _loc_2:* = param1.groupInfo;
            if (_loc_2)
            {
                if (_loc_2.failBackToo)
                {
                    var _loc_7:* = _loc_2;
                    var _loc_8:* = _loc_2.loaded + 1;
                    _loc_7.loaded = _loc_8;
                    if (_loc_2.allLoadComplete())
                    {
                        Log.log("组加载完毕，有文件失败了!!!!!!!!!!");
                        _loc_2.callBack();
                    }
                }
            }
            this.removeLoader(param1);
            return;
        }// end function

        public function startLoad() : void
        {
            var _loc_1:* = null;
            this._loadObjArr.sortOn("preLoad", Array.DESCENDING | Array.NUMERIC);
            Log.log("startLoad 目前可加载", this.loadBudget, this._loadObjArr.length);
            if (this._loadObjArr.length > 0)
            {
                _loc_1 = this._loadObjArr[0];
                if (_loc_1.preLoad > 999)
                {
                    _loc_1 = this._loadObjArr.shift();
                    this.startLoadObj(_loc_1);
                }
            }
            while (this.loadBudget > 0 && this._loadObjArr.length > 0)
            {
                
                _loc_1 = this._loadObjArr.shift();
                this.startLoadObj(_loc_1);
            }
            return;
        }// end function

        private function startLoadObj(param1:VResLoadObj) : void
        {
            var _loc_2:* = this._resDic[param1.url];
            if (_loc_2)
            {
                this.loadOneComplete(_loc_2, param1, false);
            }
            else
            {
                this.doStartLoad(param1);
                if (param1.preLoad <= 999)
                {
                    var _loc_3:* = this;
                    var _loc_4:* = this.loadBudget - 1;
                    _loc_3.loadBudget = _loc_4;
                }
            }
            return;
        }// end function

        private function doStartLoad(param1:VResLoadObj) : void
        {
            var _loc_2:* = new VResLoader(param1);
            this._loaderDic[param1.url] = _loc_2;
            this.listenerLoader(_loc_2);
            _loc_2.startLoad();
            return;
        }// end function

        private function listenerLoader(param1:VResLoader) : void
        {
            if (param1)
            {
                param1.addEventListener(VResEvent.NOTIFY_LOAD_FAIL, this.__loadFail);
                param1.addEventListener(VResEvent.NOTIFY_LOAD_NEXT, this.__loadNext);
                param1.addEventListener(VResEvent.NOTIFY_LOAD_ONE_COMPLETE, this.__loadOneComplete);
            }
            return;
        }// end function

        private function removeListenerLoader(param1:VResLoader) : void
        {
            if (param1)
            {
                param1.removeEventListener(VResEvent.NOTIFY_LOAD_FAIL, this.__loadFail);
                param1.removeEventListener(VResEvent.NOTIFY_LOAD_NEXT, this.__loadNext);
                param1.removeEventListener(VResEvent.NOTIFY_LOAD_ONE_COMPLETE, this.__loadOneComplete);
            }
            return;
        }// end function

        private function __loadFail(event:VResEvent) : void
        {
            var _loc_2:* = (event.currentTarget as VResLoader).loadObj;
            this.loadFail(_loc_2);
            return;
        }// end function

        private function __loadOneComplete(event:VResEvent) : void
        {
            var _loc_2:* = event.currentTarget as VResLoader;
            this.loadOneComplete(_loc_2.data, _loc_2.loadObj);
            return;
        }// end function

        private function __loadNext(event:VResEvent) : void
        {
            this.loadNext();
            return;
        }// end function

        public function loadNext() : void
        {
            if (this.loadBudget < 3)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.loadBudget + 1;
                _loc_1.loadBudget = _loc_2;
            }
            this.startLoad();
            return;
        }// end function

        private function removeLoader(param1:VResLoadObj) : void
        {
            this.removeListenerLoader(this._loaderDic[param1.url]);
            this._loaderDic[param1.url] = null;
            delete this._loaderDic[param1.url];
            param1.finalize();
            return;
        }// end function

        public function get loadBudget() : int
        {
            return this._loadBudget;
        }// end function

        public function set loadBudget(param1:int) : void
        {
            if (param1 > 3)
            {
                trace("isOut");
            }
            this._loadBudget = param1;
            return;
        }// end function

        public static function getInstance() : VResManager
        {
            if (instance == null)
            {
                instance = new VResManager;
            }
            return instance;
        }// end function

        public static function getRes(param1:String)
        {
            return getInstance()._resDic[param1];
        }// end function

        public static function load(param1:String, param2:Function = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:int = 0) : void
        {
            getInstance().loadRes(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            return;
        }// end function

        public static function loadGroup(param1:Array, param2:Function = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:Function = null, param7:Array = null, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Number = 0, param12:int = 0) : void
        {
            getInstance().loadResGroup(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12);
            return;
        }// end function

        public static function removeGroupLoad() : void
        {
            return;
        }// end function

    }
}
