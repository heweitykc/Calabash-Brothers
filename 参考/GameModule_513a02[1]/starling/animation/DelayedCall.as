package starling.animation
{
    import starling.animation.*;
    import starling.events.*;

    public class DelayedCall extends EventDispatcher implements IAnimatable
    {
        private var mCurrentTime:Number;
        private var mTotalTime:Number;
        private var mCall:Function;
        private var mArgs:Array;
        private var mRepeatCount:int;

        public function DelayedCall(param1:Function, param2:Number, param3:Array = null)
        {
            this.reset(param1, param2, param3);
            return;
        }// end function

        public function reset(param1:Function, param2:Number, param3:Array = null) : DelayedCall
        {
            this.mCurrentTime = 0;
            this.mTotalTime = Math.max(param2, 0.0001);
            this.mCall = param1;
            this.mArgs = param3;
            this.mRepeatCount = 1;
            return this;
        }// end function

        public function advanceTime(param1:Number) : void
        {
            var _loc_2:* = this.mCurrentTime;
            this.mCurrentTime = Math.min(this.mTotalTime, this.mCurrentTime + param1);
            if (_loc_2 < this.mTotalTime && this.mCurrentTime >= this.mTotalTime)
            {
                this.mCall.apply(null, this.mArgs);
                if (this.mRepeatCount == 0 || this.mRepeatCount > 1)
                {
                    if (this.mRepeatCount > 0)
                    {
                        (this.mRepeatCount - 1);
                    }
                    this.mCurrentTime = 0;
                    this.advanceTime(_loc_2 + param1 - this.mTotalTime);
                }
                else
                {
                    dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
                }
            }
            return;
        }// end function

        public function get isComplete() : Boolean
        {
            return this.mRepeatCount == 1 && this.mCurrentTime >= this.mTotalTime;
        }// end function

        public function get totalTime() : Number
        {
            return this.mTotalTime;
        }// end function

        public function get currentTime() : Number
        {
            return this.mCurrentTime;
        }// end function

        public function get repeatCount() : int
        {
            return this.mRepeatCount;
        }// end function

        public function set repeatCount(param1:int) : void
        {
            this.mRepeatCount = param1;
            return;
        }// end function

    }
}
