package com.cfg.info
{
    import com.f1.*;

    public class NewActivityCfg extends BaseEventDispatcher
    {
        public var q_condDesc:String;
        public var q_group:String;
        public var q_logic:String;
        public var condictionArr:Array;

        public function NewActivityCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            if (!param1)
            {
                return;
            }
            this.q_condDesc = param1.q_condDesc;
            if (this.q_condDesc)
            {
                this.condictionArr = this.q_condDesc.split("|");
            }
            this.q_group = param1.q_group;
            this.q_logic = param1.q_logic;
            return;
        }// end function

    }
}
