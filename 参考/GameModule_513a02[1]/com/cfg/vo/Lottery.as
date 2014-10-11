package com.cfg.vo
{

    public class Lottery extends Object
    {
        public var lottery_id:int;
        public var lottery_item_id:int;

        public function Lottery()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.lottery_id = param1.lottery_id;
            this.lottery_item_id = param1.lottery_item_id;
            return;
        }// end function

    }
}
