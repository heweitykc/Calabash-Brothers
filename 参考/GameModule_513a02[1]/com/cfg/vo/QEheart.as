package com.cfg.vo
{

    public class QEheart extends Object
    {
        public var q_id:int;
        public var q_name:String;
        public var q_quality:int;
        public var q_exp_max:int;
        public var q_level:int;
        public var q_attr_type:int;
        public var q_attr_value:int;
        public var q_swallow:int;
        public var q_element_value:int;
        public var q_type_level:int;
        public var q_resourse:String;

        public function QEheart()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_name = param1.q_name;
            this.q_quality = param1.q_quality;
            this.q_exp_max = param1.q_exp_max;
            this.q_level = param1.q_level;
            this.q_attr_type = param1.q_attr_type;
            this.q_attr_value = param1.q_attr_value;
            this.q_swallow = param1.q_swallow;
            this.q_element_value = param1.q_element_value;
            this.q_type_level = param1.q_type_level;
            this.q_resourse = param1.q_resourse;
            return;
        }// end function

    }
}
