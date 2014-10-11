package com.cfg.info
{

    public class EquipProcessCfg extends Object
    {
        public var q_level:String;
        public var q_item_id:int;
        public var q_id:String;
        public var q_item_name:int;
        public var q_streng_item:String;
        public var q_material_01:String;
        public var q_material_id_01:int;
        public var q_material_num_01:int;
        public var q_material_02:String;
        public var q_material_id_02:int;
        public var q_material_num_02:int;
        public var q_material_03:String;
        public var q_material_id_03:int;
        public var q_material_num_03:int;
        public var q_streng_money:int;
        public var q_streng_show_pby:int;
        public var q_streng_notice:int;
        public var q_punish:int;
        public var q_must_success_price:int;
        public var q_can_see_vip:int;
        public var q_max_physicattack:int;
        public var q_min_physicattack:int;
        public var q_max_magicattack:int;
        public var q_min_magicattack:int;
        public var q_magicattack_Percent:int;
        public var q_physicattack_Percent:int;
        public var q_defence:int;
        public var q_max_hp:int;
        public var q_max_mp:int;
        public var q_attackspeed:int;
        public var q_speed:int;
        public var q_hit:int;
        public var q_dodge:int;
        public var q_element_defence:String;
        public var q_element_defence1:int;
        public var q_element_defence2:int;
        public var q_element_defence3:int;
        public var q_element_attack:String;
        public var q_element_attack1:int;
        public var q_element_attack2:int;
        public var q_element_attack3:int;
        public var q_reduce_injure:int;
        public var q_add_injure:int;
        public var q_strength_show:String;

        public function EquipProcessCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_5:* = null;
            this.q_id = param1.q_id;
            this.q_item_id = param1.q_item_id;
            this.q_item_name = param1.q_item_name;
            this.q_level = param1.q_level;
            this.q_streng_item = param1.q_streng_item;
            var _loc_2:* = this.q_streng_item.split(";");
            this.q_material_id_01 = _loc_2[0].split("_")[0];
            this.q_material_num_01 = _loc_2[0].split("_")[1];
            if (_loc_2.length > 1)
            {
                this.q_material_id_02 = _loc_2[1].split("_")[0];
                this.q_material_num_02 = _loc_2[1].split("_")[1];
            }
            if (_loc_2.length > 2)
            {
                this.q_material_id_03 = _loc_2[2].split("_")[0];
                this.q_material_num_03 = _loc_2[2].split("_")[1];
            }
            this.q_streng_money = param1.q_streng_money;
            this.q_streng_show_pby = param1.q_streng_show_pby;
            this.q_streng_notice = param1.q_streng_notice;
            this.q_punish = param1.q_punish;
            this.q_must_success_price = param1.q_must_success_price;
            this.q_can_see_vip = param1.q_can_see_vip;
            this.q_max_physicattack = param1.q_max_physicattack;
            this.q_min_physicattack = param1.q_min_physicattack;
            this.q_max_magicattack = param1.q_max_magicattack;
            this.q_min_magicattack = param1.q_min_magicattack;
            this.q_magicattack_Percent = param1.q_magicattack_Percent;
            this.q_physicattack_Percent = param1.q_physicattack_Percent;
            this.q_defence = param1.q_defence;
            this.q_max_hp = param1.q_max_hp;
            this.q_max_mp = param1.q_max_mp;
            this.q_attackspeed = param1.q_attackspeed;
            this.q_speed = param1.q_speed;
            this.q_hit = param1.q_hit;
            this.q_dodge = param1.q_dodge;
            this.q_reduce_injure = param1.q_reduce_injure;
            this.q_add_injure = param1.q_add_injure;
            this.q_element_defence = param1.q_element_defence ? (param1.q_element_defence.substring(1, (param1.q_element_defence.length - 1))) : ("");
            var _loc_3:* = this.q_element_defence.split(";");
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4].split(",");
                switch(_loc_5[0])
                {
                    case "1":
                    {
                        this.q_element_defence1 = _loc_5[1];
                        break;
                    }
                    case "2":
                    {
                        this.q_element_defence2 = _loc_5[1];
                        break;
                    }
                    case "3":
                    {
                        this.q_element_defence3 = _loc_5[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            this.q_element_attack = param1.q_element_attack ? (param1.q_element_attack.substring(1, (param1.q_element_attack.length - 1))) : ("");
            _loc_3 = this.q_element_attack.split(";");
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4].split(",");
                switch(_loc_5[0])
                {
                    case "1":
                    {
                        this.q_element_attack1 = _loc_5[1];
                        break;
                    }
                    case "2":
                    {
                        this.q_element_attack2 = _loc_5[1];
                        break;
                    }
                    case "3":
                    {
                        this.q_element_attack3 = _loc_5[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            this.q_strength_show = param1.q_strength_show;
            return;
        }// end function

    }
}
