package com.cfg.info
{

    public class EquipComposeCfg extends Object
    {
        public var item_type:String;
        public var item_name:String;
        public var compose_id:int;
        public var use_item:String;
        public var use_not_sign_item:String;
        public var use_not_sign_item_id:String;
        public var success_percent:int;
        public var money_need:int;
        public var diamond_need:int;
        public var other_result_items:String;
        public var other_result_items_client:String;
        public var Q_Nonfinite_item:String;
        public var Q_Nonfinite_num:int;
        public var success_percent_max:int;

        public function EquipComposeCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.item_type = param1.item_type;
            this.item_name = param1.item_name;
            this.compose_id = param1.compose_id;
            this.use_item = param1.use_item.substring(1, (param1.use_item.length - 1));
            this.use_not_sign_item = param1.use_not_sign_item.substring(1, (param1.use_not_sign_item.length - 1));
            this.use_not_sign_item_id = param1.use_not_sign_item_id;
            this.success_percent = param1.success_percent;
            this.money_need = param1.money_need;
            this.diamond_need = param1.diamond_need;
            this.other_result_items = param1.other_result_items;
            this.other_result_items_client = param1.other_result_items_client;
            this.Q_Nonfinite_item = param1.Q_Nonfinite_item.substring(1, (param1.Q_Nonfinite_item.length - 1));
            this.Q_Nonfinite_num = param1.Q_Nonfinite_num;
            this.success_percent_max = param1.success_percent_max;
            return;
        }// end function

    }
}
