package com.f1.manager.resource
{
    import flash.events.*;

    public class VResLoadObj extends EventDispatcher
    {
        public var url:String;
        public var size:uint;
        public var loadedSize:uint;
        public var groupInfo:VResGroupInfo;
        public var ignoreMD5:Boolean;
        public var callBackParams:Array;
        public var completeFuns:Array;
        public var errFuns:Array;
        public var progressFuns:Array;
        public var asByteArray:Boolean;
        public var keep:Boolean;
        public var preLoad:int = 0;

        public function VResLoadObj()
        {
            this.callBackParams = [];
            this.completeFuns = [];
            this.errFuns = [];
            this.progressFuns = [];
            return;
        }// end function

        public function addCallBack(param1:Function, param2:Array = null, param3:Function = null, param4:Function = null) : void
        {
            this.completeFuns.push(param1);
            this.callBackParams.push(param2);
            this.errFuns.push(param3);
            this.progressFuns.push(param4);
            return;
        }// end function

        public function finalize() : void
        {
            this.completeFuns = null;
            this.errFuns = null;
            this.progressFuns = null;
            this.callBackParams = null;
            this.groupInfo = null;
            return;
        }// end function

    }
}
