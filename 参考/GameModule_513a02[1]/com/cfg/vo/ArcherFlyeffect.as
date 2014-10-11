package com.cfg.vo
{

    public class ArcherFlyeffect extends Object
    {
        public var equid_id:uint;
        public var q_name:String;
        public var q_trajectory_effect:String;
        public var q_use_effect:String;
        public var q_hit_effect:String;

        public function ArcherFlyeffect()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.equid_id = param1.equid_id;
            this.q_name = param1.q_name;
            this.q_trajectory_effect = param1.q_trajectory_effect;
            this.q_use_effect = param1.q_use_effect;
            this.q_hit_effect = param1.q_hit_effect;
            return;
        }// end function

    }
}
