package com.game.facebook.cfg
{

    public class FacebookShareCfg extends Object
    {
        public var q_condition:String;
        public var q_condition_desc:String;
        public var q_feed_name:String;
        public var q_feed_caption:String;
        public var q_feed_description:String;

        public function FacebookShareCfg(param1:Object)
        {
            this.q_condition = param1.q_condition;
            this.q_condition_desc = param1.q_condition_desc;
            this.q_feed_name = param1.q_feed_name;
            this.q_feed_caption = param1.q_feed_caption;
            this.q_feed_description = param1.q_feed_description;
            return;
        }// end function

    }
}
