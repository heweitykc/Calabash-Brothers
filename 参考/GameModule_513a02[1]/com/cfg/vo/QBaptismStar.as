package com.cfg.vo
{

    public class QBaptismStar extends Object
    {
        public var q_id:String;
        public var q_name:String;
        public var q_add_attribute:String;
        public var q_consume:String;
        public var q_rate:String;

        public function QBaptismStar()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_name = param1.q_name;
            this.q_add_attribute = param1.q_add_attribute;
            this.q_consume = param1.q_consume;
            this.q_rate = param1.q_rate;
            return;
        }// end function

    }
}
