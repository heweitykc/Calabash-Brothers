package com.game.bank.cfg
{

    public class BankRateCfg extends Object
    {
        public var q_level:String;
        public var q_reward_rate:int;

        public function BankRateCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_level = param1.q_level;
            this.q_reward_rate = param1.q_reward_rate;
            return;
        }// end function

    }
}
