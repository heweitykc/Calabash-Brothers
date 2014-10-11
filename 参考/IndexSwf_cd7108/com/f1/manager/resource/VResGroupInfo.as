package com.f1.manager.resource
{

    public class VResGroupInfo extends Object
    {
        public var needLoad:uint;
        public var loaded:uint;
        public var callBackParam:Array;
        public var totalSize:uint;
        public var loadedSize:uint;
        public var failBackToo:Boolean = false;
        public var overtime:uint = 0;
        public var completeFun:Function;
        public var completeParams:Array;

        public function VResGroupInfo()
        {
            return;
        }// end function

        public function allLoadComplete() : Boolean
        {
            return this.loaded >= this.needLoad;
        }// end function

        public function callBack() : void
        {
            if (this.completeFun != null)
            {
                if (this.completeParams == null)
                {
                    this.completeFun.apply(null);
                }
                else
                {
                    this.completeFun.apply(null, this.completeParams);
                }
            }
            return;
        }// end function

        public function finalize() : void
        {
            this.completeFun = null;
            this.completeParams = null;
            this.callBackParam = null;
            return;
        }// end function

    }
}
