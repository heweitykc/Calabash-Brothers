package com.model.vo
{
    import com.cfg.info.*;

    public class LivenessInfo extends LivenessEventCfg
    {
        private var _times:int;

        public function LivenessInfo()
        {
            return;
        }// end function

        public function get times() : int
        {
            return this._times;
        }// end function

        public function set times(param1:int) : void
        {
            this._times = param1;
            return;
        }// end function

    }
}
