package com.cfg.vo
{

    public class QMagicbookLevel extends Object
    {
        public var level:int;
        public var max_exp:int;
        public var up_itemids:String;
        public var breakthrough:int;
        public var breakthrough_items_str:String;
        public var skills_str:String;
        public var max_use_item_quantity_str:String;
        public var attributes_str:String;
        public var q_resmodel:String;
        public var q_respanel:String;

        public function QMagicbookLevel()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.level = param1.level;
            this.max_exp = param1.max_exp;
            this.up_itemids = param1.up_itemids;
            this.breakthrough = param1.breakthrough;
            this.breakthrough_items_str = param1.breakthrough_items_str;
            this.skills_str = param1.skills_str;
            this.max_use_item_quantity_str = param1.max_use_item_quantity_str;
            this.attributes_str = param1.attributes_str;
            this.q_resmodel = param1.q_resmodel;
            this.q_respanel = param1.q_respanel;
            return;
        }// end function

    }
}
