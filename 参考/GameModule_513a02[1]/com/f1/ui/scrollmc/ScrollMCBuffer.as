package com.f1.ui.scrollmc
{
    import com.greensock.*;
    import flash.display.*;

    public class ScrollMCBuffer extends Object
    {
        private var scorllMCs:Array;

        public function ScrollMCBuffer()
        {
            this.scorllMCs = [];
            return;
        }// end function

        public function add(param1:DisplayObject, param2:Number = 1.5, param3:uint = 1, param4:uint = 100, param5:Number = 0, param6:int = 1, param7:int = 22, param8:int = 1) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this.scorllMCs.length > 30)
            {
                _loc_9 = this.scorllMCs.splice(0, this.scorllMCs.length - 30);
                if (_loc_9 && _loc_9.length)
                {
                    for each (_loc_10 in _loc_9)
                    {
                        
                        if (_loc_10 && _loc_10.parent)
                        {
                            _loc_10.parent.removeChild(_loc_10);
                        }
                    }
                }
            }
            this.scorllMCs.push(param1);
            if (this.scorllMCs.length == 1)
            {
                this.startScorllMC(param2, param3, param4, param5, param6, param7, param8);
            }
            return;
        }// end function

        private function startScorllMC(param1:Number, param2:uint, param3:uint = 100, param4:Number = 0.1, param5:int = 1, param6:int = 22, param7:int = 1) : void
        {
            var _loc_8:* = null;
            if (this.scorllMCs.length > 0)
            {
                _loc_8 = this.scorllMCs.shift();
                ScrollMC.start(_loc_8, param1, param2, param3, param5, param6, param7);
                if (this.scorllMCs.length > 0)
                {
                    TweenLite.delayedCall(param4, this.startNextScorllMC, [param1, param2]);
                }
            }
            return;
        }// end function

        private function startNextScorllMC(param1:Number, param2:uint) : void
        {
            if (this.scorllMCs.length > 0)
            {
                this.startScorllMC(param1, param2);
            }
            return;
        }// end function

        public function stop() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.scorllMCs.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = this.scorllMCs[_loc_2];
                if (_loc_3 && _loc_3.parent)
                {
                    _loc_3.parent.removeChild(_loc_3);
                }
                _loc_2++;
            }
            this.scorllMCs.length = 0;
            return;
        }// end function

    }
}
