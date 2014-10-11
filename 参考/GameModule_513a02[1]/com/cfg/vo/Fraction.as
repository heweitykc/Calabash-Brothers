package com.cfg.vo
{

    public class Fraction extends Object
    {
        public var fraction_id:int;
        public var fraction_type:int;
        public var fraction_positon:int;
        public var fraction_item_id:int;
        public var fraction_amount:int;

        public function Fraction()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.fraction_id = param1.fraction_id;
            this.fraction_type = param1.fraction_type;
            this.fraction_positon = param1.fraction_positon;
            this.fraction_item_id = param1.fraction_item_id;
            this.fraction_amount = param1.fraction_amount;
            return;
        }// end function

    }
}
