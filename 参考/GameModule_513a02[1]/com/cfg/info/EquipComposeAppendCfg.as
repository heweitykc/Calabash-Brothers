package com.cfg.info
{

    public class EquipComposeAppendCfg extends Object
    {
        public var item_name:String;
        public var compose_id:int;
        public var q_equip_steplv_append:String;
        public var q_equip_strenglv:String;
        public var q_equip_attributelv:String;
        public var q_equip_remarkablenum:String;
        public var q_equip_isluck:String;
        public var q_equip_IGNORE_ATTACKPERCENT:String;

        public function EquipComposeAppendCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            this.item_name = param1.item_name;
            this.compose_id = param1.compose_id;
            this.q_equip_steplv_append = param1.q_equip_steplv_append;
            this.q_equip_strenglv = param1.q_equip_strenglv;
            this.q_equip_attributelv = param1.q_equip_attributelv;
            this.q_equip_remarkablenum = param1.q_equip_remarkablenum;
            this.q_equip_isluck = param1.q_equip_isluck;
            this.q_equip_IGNORE_ATTACKPERCENT = param1.q_equip_IGNORE_ATTACKPERCENT;
            return;
        }// end function

    }
}
