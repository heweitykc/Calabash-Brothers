package com.cfg.vo
{

    public class QTransfer extends Object
    {
        public var q_tran_id:uint;
        public var q_tran_from_map:uint;
        public var q_tran_from_range:String;
        public var q_tran_to_map:uint;
        public var q_tran_to_range:String;
        public var q_tran_icon:String;

        public function QTransfer()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.q_tran_id = param1.q_tran_id;
            this.q_tran_from_map = param1.q_tran_from_map;
            this.q_tran_from_range = param1.q_tran_from_range;
            this.q_tran_to_map = param1.q_tran_to_map;
            this.q_tran_to_range = param1.q_tran_to_range;
            this.q_tran_icon = param1.q_tran_icon;
            return;
        }// end function

    }
}
