package com.cfg.info
{

    public class SuitEffectCfg extends Object
    {
        public var q_id:int;
        public var q_condition:String;
        public var q_effect:String;
        public var q_level:int;

        public function SuitEffectCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_condition = param1.q_condition;
            this.q_effect = param1.q_effect;
            this.q_level = param1.q_level;
            return;
        }// end function

        public function get url() : String
        {
            return "art/res/suit/" + this.q_effect + ".png";
        }// end function

    }
}
