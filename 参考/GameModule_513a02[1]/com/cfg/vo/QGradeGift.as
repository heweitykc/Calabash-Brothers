package com.cfg.vo
{

    public class QGradeGift extends Object
    {
        public var q_id:int;
        public var q_need_grade:int;
        public var q_max_gain:int;
        public var q_reward:String;

        public function QGradeGift()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_need_grade = param1.q_need_grade;
            this.q_max_gain = param1.q_max_gain;
            this.q_reward = param1.q_reward;
            return;
        }// end function

    }
}
