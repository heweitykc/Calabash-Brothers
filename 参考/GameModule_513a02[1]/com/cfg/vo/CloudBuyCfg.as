package com.cfg.vo
{

    public class CloudBuyCfg extends Object
    {
        public var q_id:int;
        public var q_topic:String;
        public var q_reward_id:String;
        public var q_item_id:String;
        public var q_people_num:int;
        public var q_control:String;
        public var q_price:int;
        public var q_price_show:String;
        public var q_reward_id_show1:String;
        public var q_reward_id_show2:String;
        public var q_reward_id_show3:String;

        public function CloudBuyCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_id = param1.q_id;
            this.q_topic = param1.q_topic;
            this.q_reward_id = param1.q_reward_id;
            this.q_item_id = param1.q_item_id;
            this.q_people_num = param1.q_people_num;
            this.q_control = param1.q_control;
            this.q_price = param1.q_price;
            this.q_price_show = param1.q_price_show;
            this.q_reward_id_show1 = param1.q_reward_id_show1;
            this.q_reward_id_show2 = param1.q_reward_id_show2;
            this.q_reward_id_show3 = param1.q_reward_id_show3;
            return;
        }// end function

    }
}
