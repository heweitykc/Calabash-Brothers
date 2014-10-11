package com.cfg.info
{
    import com.f1.*;
    import com.f1.utils.*;

    public class ItemCfg extends BaseEventDispatcher
    {
        public var streng:int;
        public var q_id:int;
        public var q_name:String;
        public var q_equip_resource:String;
        public var q_kind:int;
        public var q_secondary_type:int;
        public var q_third_type:int;
        public var q_drop_model:String;
        public var q_cooldown:int;
        public var q_equip_steplv:int;
        public var q_hand:int;
        public var q_suit_convert_ids:Array;
        public var q_suit_convert_consumes:Array;

        public function ItemCfg()
        {
            return;
        }// end function

        public function parse(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            this.q_id = param1.q_id;
            this.q_name = param1.q_name;
            this.q_equip_resource = param1.q_equip_resource;
            this.q_kind = param1.q_kind;
            this.q_secondary_type = param1.q_secondary_type;
            this.q_third_type = param1.q_third_type;
            this.q_drop_model = param1.q_drop_model;
            this.q_cooldown = param1.q_cooldown;
            this.q_equip_steplv = param1.q_equip_steplv;
            this.q_hand = param1.q_hand;
            if (param1.q_suit_convert_id)
            {
                _loc_2 = String(param1.q_suit_convert_id).split(";");
                _loc_3 = _loc_2.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_3)
                {
                    
                    _loc_2[_loc_4] = int(_loc_2[_loc_4]);
                    _loc_4++;
                }
                this.q_suit_convert_ids = _loc_2;
                this.q_suit_convert_consumes = StringUtil.clearJsonQuote(param1.q_suit_convert_consume).split(";");
            }
            else
            {
                this.q_suit_convert_ids = null;
                this.q_suit_convert_consumes = null;
            }
            return;
        }// end function

        public function suitCanStength(param1:int) : Boolean
        {
            var _loc_2:* = this.q_suit_convert_ids ? (this.q_suit_convert_ids.indexOf(param1)) : (-1);
            return _loc_2 >= 0 && (_loc_2 + 1) < this.q_suit_convert_ids.length;
        }// end function

        public function canTransSuit(param1:int) : Boolean
        {
            return param1 == 0 && this.q_suit_convert_ids && this.q_suit_convert_ids.length;
        }// end function

        public function getNextSuitId(param1:int) : int
        {
            var _loc_2:* = this.q_suit_convert_ids.indexOf(param1);
            _loc_2++;
            if (_loc_2 < this.q_suit_convert_ids.length)
            {
                return this.q_suit_convert_ids[_loc_2];
            }
            return param1;
        }// end function

        public function getSuit_convert_consumeBySuitId(param1:int) : String
        {
            var _loc_2:* = this.q_suit_convert_ids.indexOf(param1);
            return this.q_suit_convert_consumes[_loc_2];
        }// end function

    }
}
