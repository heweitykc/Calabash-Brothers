package com.f1.utils
{
    import com.greensock.*;

    public class FunctionBuffer extends Object
    {
        private var interTime:Number;
        private var funList:Array;
        private var useFrame:Boolean;

        public function FunctionBuffer(param1:Number, param2:Boolean = false)
        {
            this.funList = [];
            this.interTime = param1;
            this.useFrame = param2;
            return;
        }// end function

        public function removeItemAll() : void
        {
            this.funList.splice(0);
            return;
        }// end function

        public function addItem(param1:Function, param2:Array = null) : void
        {
            this.funList.push({fun:param1, params:param2});
            if (this.funList.length == 1)
            {
                this.callFun();
            }
            return;
        }// end function

        private function callFun() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this.funList.length > 0)
            {
                _loc_1 = this.funList[0];
                _loc_2 = _loc_1.fun;
                _loc_3 = _loc_1.params;
                if (_loc_2 != null)
                {
                    if (_loc_3 == null)
                    {
                        _loc_2.call(null);
                    }
                    else
                    {
                        _loc_2.apply(null, _loc_3);
                    }
                }
                this.funList[0] = null;
                TweenLite.delayedCall(this.interTime, this.callNextFun, null, this.useFrame);
            }
            return;
        }// end function

        private function callNextFun() : void
        {
            if (this.funList.length > 0)
            {
                this.funList.shift();
                this.callFun();
            }
            return;
        }// end function

        public function start() : void
        {
            return;
        }// end function

        public function stop() : void
        {
            return;
        }// end function

    }
}
