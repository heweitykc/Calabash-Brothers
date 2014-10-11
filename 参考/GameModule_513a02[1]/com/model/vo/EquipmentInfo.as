package com.model.vo
{
    import __AS3__.vec.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.game.backpack.bean.*;
    import com.game.equip.bean.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class EquipmentInfo extends PropInfo
    {
        public var euipSource:int = 0;
        private var _q_max_strengthen:int;
        private var _q_max_inlay:int;
        private var _q_attack:int;
        private var _q_max_physicattack:int;
        private var _q_min_physicattack:int;
        private var _q_defence:int;
        private var _q_up_magicattack:int;
        private var _q_up_attack:int;
        private var _q_element_defence:String;
        private var _q_element_attack:String;
        private var _q_crit:int;
        private var _q_dodge:int;
        private var _q_max_hp:int;
        private var _q_max_sp:int;
        private var _q_max_mp:int;
        private var _q_attackspeed:int;
        private var _q_speed:int;
        private var _q_luck:int;
        private var _q_suite:Boolean;
        private var _q_remarkable:int;
        private var _q_attach_skill:int;
        private var _q_extra_attributes:int;
        private var _q_min_magicattack:int;
        private var _q_max_magicattack:int;
        private var _q_hit:int;
        protected var _pos:int;
        private var _q_addhp_whenkill:int;
        private var _q_addmp_whenkill:int;
        private var _q_hp_cover:int;
        private var _q_defence_remark:int;
        private var _q_add_mplimit:int;
        private var _q_add_hplimit:int;
        private var _q_reduce_damage:int;
        private var _q_rebound_damage:int;
        private var _q_physicattack_bylevel:int;
        private var _q_magicattack_bylevel:int;
        private var _q_remark_physicattack_percent:int;
        private var _q_remark_magicattack_percent:int;
        private var _q_remarkable_attack:int;
        private var _q_physicattack_Percent:int;
        private var _q_magicattack_Percent:int;
        private var _q_add_money:int;
        private var _q_remarkable_attackSpeed:int;
        private var _q_shine_color:String;
        private var _ignore_attack_percent:int;
        public var q_set_uniquelevel:int;
        public var q_element_defence1:int;
        public var q_element_defence2:int;
        public var q_element_defence3:int;
        public var q_element_attack1:int;
        public var q_element_attack2:int;
        public var q_element_attack3:int;
        public var knowing_attackpercent:int;
        private var _fightNumber:int;
        private var _attributeCount:int;
        private var _allattack_bylevel:int;
        private var _allattack_percent:int;
        private var _q_add_injure:int;
        private var _q_reduce_injure:int;
        public static const EUIP_SOURCE_MY:int = 0;
        public static const EQUIP_SOURCE_OTHER:int = 1;
        public static const EQUIP_SOURCE_TOPLIST:int = 2;

        public function EquipmentInfo()
        {
            return;
        }// end function

        public function get allattack_percent() : int
        {
            return this._allattack_percent;
        }// end function

        public function set allattack_percent(param1:int) : void
        {
            this._allattack_percent = param1;
            return;
        }// end function

        public function get allattack_bylevel() : int
        {
            return this._allattack_bylevel;
        }// end function

        public function set allattack_bylevel(param1:int) : void
        {
            this._allattack_bylevel = param1;
            return;
        }// end function

        public function get q_reduce_injure() : int
        {
            return this._q_reduce_injure;
        }// end function

        public function set q_reduce_injure(param1:int) : void
        {
            this._q_reduce_injure = param1;
            return;
        }// end function

        public function get q_add_injure() : int
        {
            return this._q_add_injure;
        }// end function

        public function set q_add_injure(param1:int) : void
        {
            this._q_add_injure = param1;
            return;
        }// end function

        public function get ignore_attack_percent() : int
        {
            return this._ignore_attack_percent;
        }// end function

        public function set ignore_attack_percent(param1:int) : void
        {
            this._ignore_attack_percent = param1;
            return;
        }// end function

        public function get attributeCount() : int
        {
            return this._attributeCount;
        }// end function

        public function set attributeCount(param1:int) : void
        {
            this._attributeCount = param1;
            return;
        }// end function

        public function get fightNumber() : int
        {
            return this._fightNumber;
        }// end function

        public function set fightNumber(param1:int) : void
        {
            this._fightNumber = param1;
            dispatchEvent(new PropEvent(PropEvent.UPDATE_FIGHTNUMBER, this));
            return;
        }// end function

        public function get q_shine_color() : String
        {
            return this._q_shine_color;
        }// end function

        public function set q_shine_color(param1:String) : void
        {
            this._q_shine_color = param1;
            return;
        }// end function

        public function get q_remark_magicattack_percent() : int
        {
            return this._q_remark_magicattack_percent;
        }// end function

        public function set q_remark_magicattack_percent(param1:int) : void
        {
            this._q_remark_magicattack_percent = param1;
            return;
        }// end function

        public function get q_remark_physicattack_percent() : int
        {
            return this._q_remark_physicattack_percent;
        }// end function

        public function set q_remark_physicattack_percent(param1:int) : void
        {
            this._q_remark_physicattack_percent = param1;
            return;
        }// end function

        public function get q_remarkable_attackSpeed() : int
        {
            return this._q_remarkable_attackSpeed;
        }// end function

        public function set q_remarkable_attackSpeed(param1:int) : void
        {
            this._q_remarkable_attackSpeed = param1;
            return;
        }// end function

        public function get q_defence_remark() : int
        {
            return this._q_defence_remark;
        }// end function

        public function set q_defence_remark(param1:int) : void
        {
            this._q_defence_remark = param1;
            return;
        }// end function

        public function get q_addhp_whenkill() : int
        {
            return this._q_addhp_whenkill;
        }// end function

        public function set q_addhp_whenkill(param1:int) : void
        {
            this._q_addhp_whenkill = param1;
            return;
        }// end function

        public function get q_attackspeed() : int
        {
            return this._q_attackspeed;
        }// end function

        public function set q_attackspeed(param1:int) : void
        {
            this._q_attackspeed = param1;
            return;
        }// end function

        public function get q_magicattack_bylevel() : int
        {
            return this._q_magicattack_bylevel;
        }// end function

        public function set q_magicattack_bylevel(param1:int) : void
        {
            this._q_magicattack_bylevel = param1;
            return;
        }// end function

        public function get q_physicattack_bylevel() : int
        {
            return this._q_physicattack_bylevel;
        }// end function

        public function set q_physicattack_bylevel(param1:int) : void
        {
            this._q_physicattack_bylevel = param1;
            return;
        }// end function

        public function get q_remarkable_attack() : int
        {
            return this._q_remarkable_attack;
        }// end function

        public function set q_remarkable_attack(param1:int) : void
        {
            this._q_remarkable_attack = param1;
            return;
        }// end function

        public function get q_add_money() : int
        {
            return this._q_add_money;
        }// end function

        public function set q_add_money(param1:int) : void
        {
            this._q_add_money = param1;
            return;
        }// end function

        public function get q_dodge() : int
        {
            return this._q_dodge;
        }// end function

        public function set q_dodge(param1:int) : void
        {
            this._q_dodge = param1;
            return;
        }// end function

        public function get q_rebound_damage() : int
        {
            return this._q_rebound_damage;
        }// end function

        public function set q_rebound_damage(param1:int) : void
        {
            this._q_rebound_damage = param1;
            return;
        }// end function

        public function get q_reduce_damage() : int
        {
            return this._q_reduce_damage;
        }// end function

        public function set q_reduce_damage(param1:int) : void
        {
            this._q_reduce_damage = param1;
            return;
        }// end function

        public function get q_add_hplimit() : int
        {
            return this._q_add_hplimit;
        }// end function

        public function set q_add_hplimit(param1:int) : void
        {
            this._q_add_hplimit = param1;
            return;
        }// end function

        public function get q_add_mplimit() : int
        {
            return this._q_add_mplimit;
        }// end function

        public function set q_add_mplimit(param1:int) : void
        {
            this._q_add_mplimit = param1;
            return;
        }// end function

        public function get q_hp_cover() : int
        {
            return this._q_hp_cover;
        }// end function

        public function set q_hp_cover(param1:int) : void
        {
            this._q_hp_cover = param1;
            return;
        }// end function

        public function get q_addmp_whenkill() : int
        {
            return this._q_addmp_whenkill;
        }// end function

        public function set q_addmp_whenkill(param1:int) : void
        {
            if (this._q_addmp_whenkill != param1)
            {
                this._q_addmp_whenkill = param1;
            }
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get q_max_magicattack() : int
        {
            return this._q_max_magicattack;
        }// end function

        public function set q_max_magicattack(param1:int) : void
        {
            this._q_max_magicattack = param1;
            return;
        }// end function

        public function get q_hit() : int
        {
            return this._q_hit;
        }// end function

        public function set q_hit(param1:int) : void
        {
            this._q_hit = param1;
            return;
        }// end function

        public function get q_magicattack_Percent() : int
        {
            return this._q_magicattack_Percent;
        }// end function

        public function set q_magicattack_Percent(param1:int) : void
        {
            this._q_magicattack_Percent = param1;
            return;
        }// end function

        public function get q_physicattack_Percent() : int
        {
            return this._q_physicattack_Percent;
        }// end function

        public function set q_physicattack_Percent(param1:int) : void
        {
            this._q_physicattack_Percent = param1;
            return;
        }// end function

        public function get q_min_magicattack() : int
        {
            return this._q_min_magicattack;
        }// end function

        public function set q_min_magicattack(param1:int) : void
        {
            this._q_min_magicattack = param1;
            return;
        }// end function

        override public function set intensify(param1:int) : void
        {
            streng = param1;
            this.setAttributeEquipStrengCfg(param1, addAttributLevel);
            return;
        }// end function

        override public function set addAttributLevel(param1:int) : void
        {
            this._addAttributLevel = param1;
            this.setAttributeEquipStrengCfg(intensify, param1);
            return;
        }// end function

        public function get q_extra_attributes() : int
        {
            return this._q_extra_attributes;
        }// end function

        public function set q_extra_attributes(param1:int) : void
        {
            this._q_extra_attributes = param1;
            return;
        }// end function

        public function get q_attach_skill() : int
        {
            return this._q_attach_skill;
        }// end function

        public function set q_attach_skill(param1:int) : void
        {
            this._q_attach_skill = param1;
            return;
        }// end function

        override public function get q_remarkable() : int
        {
            return this._q_remarkable;
        }// end function

        override public function set q_remarkable(param1:int) : void
        {
            this._q_remarkable = param1;
            return;
        }// end function

        public function get q_suite() : Boolean
        {
            return this._q_suite;
        }// end function

        public function set q_suite(param1:Boolean) : void
        {
            this._q_suite = param1;
            return;
        }// end function

        public function get q_luck() : int
        {
            return this._q_luck;
        }// end function

        public function set q_luck(param1:int) : void
        {
            this._q_luck = param1;
            return;
        }// end function

        public function get q_speed() : int
        {
            return this._q_speed;
        }// end function

        public function set q_speed(param1:int) : void
        {
            this._q_speed = param1;
            return;
        }// end function

        public function get q_max_mp() : int
        {
            return this._q_max_mp;
        }// end function

        public function set q_max_mp(param1:int) : void
        {
            this._q_max_mp = param1;
            return;
        }// end function

        public function get q_max_sp() : int
        {
            return this._q_max_sp;
        }// end function

        public function set q_max_sp(param1:int) : void
        {
            this._q_max_sp = param1;
            return;
        }// end function

        public function get q_max_hp() : int
        {
            return this._q_max_hp;
        }// end function

        public function set q_max_hp(param1:int) : void
        {
            this._q_max_hp = param1;
            return;
        }// end function

        public function get q_crit() : int
        {
            return this._q_crit;
        }// end function

        public function set q_crit(param1:int) : void
        {
            this._q_crit = param1;
            return;
        }// end function

        public function get q_element_attack() : String
        {
            return this._q_element_attack;
        }// end function

        public function set q_element_attack(param1:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            this._q_element_attack = param1.substring(1, (param1.length - 1));
            var _loc_2:* = String(this.q_element_attack).split(";");
            _loc_4 = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_3 = _loc_2[_loc_4].split(",");
                switch(_loc_3[0])
                {
                    case "1":
                    {
                        this.q_element_attack1 = _loc_3[1];
                        break;
                    }
                    case "2":
                    {
                        this.q_element_attack2 = _loc_3[1];
                        break;
                    }
                    case "3":
                    {
                        this.q_element_attack3 = _loc_3[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_4++;
            }
            return;
        }// end function

        public function get q_element_defence() : String
        {
            return this._q_element_defence;
        }// end function

        public function set q_element_defence(param1:String) : void
        {
            var _loc_4:* = null;
            this._q_element_defence = param1.substring(1, (param1.length - 1));
            var _loc_2:* = String(this.q_element_defence).split(";");
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3].split(",");
                switch(_loc_4[0])
                {
                    case "1":
                    {
                        this.q_element_defence1 = _loc_4[1];
                        break;
                    }
                    case "2":
                    {
                        this.q_element_defence2 = _loc_4[1];
                        break;
                    }
                    case "3":
                    {
                        this.q_element_defence3 = _loc_4[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3++;
            }
            return;
        }// end function

        public function get q_up_attack() : int
        {
            return this._q_up_attack;
        }// end function

        public function set q_up_attack(param1:int) : void
        {
            this._q_up_attack = param1;
            return;
        }// end function

        public function get q_up_magicattack() : int
        {
            return this._q_up_magicattack;
        }// end function

        public function set q_up_magicattack(param1:int) : void
        {
            this._q_up_magicattack = param1;
            return;
        }// end function

        public function get q_defence() : int
        {
            return this._q_defence;
        }// end function

        public function set q_defence(param1:int) : void
        {
            this._q_defence = param1;
            return;
        }// end function

        public function get q_min_physicattack() : int
        {
            return this._q_min_physicattack;
        }// end function

        public function set q_min_physicattack(param1:int) : void
        {
            this._q_min_physicattack = param1;
            return;
        }// end function

        public function get q_max_physicattack() : int
        {
            return this._q_max_physicattack;
        }// end function

        public function set q_max_physicattack(param1:int) : void
        {
            this._q_max_physicattack = param1;
            return;
        }// end function

        public function get q_attack() : int
        {
            return this._q_attack;
        }// end function

        public function set q_attack(param1:int) : void
        {
            this._q_attack = param1;
            return;
        }// end function

        public function get q_max_strengthen() : int
        {
            return this._q_max_strengthen;
        }// end function

        public function set q_max_strengthen(param1:int) : void
        {
            this._q_max_strengthen = param1;
            return;
        }// end function

        override public function conv(param1:ItemInfo) : void
        {
            super.conv(param1);
            this.fightNumber = param1.fightNumber;
            this.attributeCount = param1.attributeCount;
            this.setRmarkAttribute(param1.goodAttributes);
            this.setAttributeEquipStrengCfg(intensify, addAttributLevel);
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function con(param1:EquipInfo, param2:int) : void
        {
            _itemId = param1.itemId;
            _itemModelId = param1.itemModelId;
            if (_itemModelId != 0)
            {
                _isbind = param1.itemBind;
                this.intensify = param1.itemLevel;
                _addAttributLevel = param1.addAttributLevel;
                this.setAttributeCfg(ItemCfgObj.getInstance().getCfgBy(_itemModelId));
                _lostTime = param1.lostTime;
            }
            this.fightNumber = param1.fightNumber;
            this.attributeCount = param1.attributeCount;
            this.setRmarkAttribute(param1.itemAttributes);
            this.setAttributeEquipStrengCfg(intensify, addAttributLevel);
            this.pos = param2 + 1;
            suitId = param1.suitId;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function conByPropInfo(param1:PropInfo) : void
        {
            _itemId = param1.itemId;
            _itemModelId = param1.itemModelId;
            if (_itemModelId != 0)
            {
                this.setAttributeCfg(ItemCfgObj.getInstance().getCfgBy(_itemModelId));
                this.addAttributLevel = param1.addAttributLevel;
            }
            this.setRmarkAttribute(param1.goodAttributes);
            this.setAttributeEquipStrengCfg(intensify, addAttributLevel);
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        override public function conByWorldMapDropInfo(param1:WorldMapDropInfo) : void
        {
            this.convEquipByCfg(param1.itemModelId, param1.intensify);
            return;
        }// end function

        public function convEquipByCfg(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:Array = null) : void
        {
            itemModelId = param1;
            super.convByCfg(param1);
            this.intensify = param2;
            this.addAttributLevel = param3;
            this.setAttributeEquipStrengCfg(intensify, param3);
            this.knowing_attackpercent = param4;
            if (param5 != null)
            {
                this.setRmarkAttribute(param5);
            }
            this.calFightNumber();
            return;
        }// end function

        private function setRmarkAttribute(param1:Object) : void
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                this.setEquipRemark(param1[_loc_3]);
                _loc_3++;
            }
            return;
        }// end function

        private function setEquipRemark(param1:Object) : void
        {
            Attributes.setEquipAttr(this, param1);
            return;
        }// end function

        protected function setEquipAttribute(param1:Vector.<EquipAttribute>) : void
        {
            return;
        }// end function

        override protected function setAttributeCfg(param1:Object) : void
        {
            super.setAttributeCfg(param1);
            _url = Params.Equipment_PATH + param1.q_item_icon + ".png";
            return;
        }// end function

        public function setAttributeEquipStrengCfg(param1:int, param2:int) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_3:* = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this.itemModelId + "_" + param1);
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!ItemCfgObj.getInstance().getCfgBy(_itemModelId))
            {
                return;
            }
            this.q_min_physicattack = int(_loc_4.q_min_physicattack) + (_loc_3 ? (_loc_3.q_min_physicattack) : (0));
            this.q_max_physicattack = int(_loc_4.q_max_physicattack) + (_loc_3 ? (_loc_3.q_max_physicattack) : (0));
            this.q_min_magicattack = int(_loc_4.q_min_magicattack) + (_loc_3 ? (_loc_3.q_min_magicattack) : (0));
            this.q_max_magicattack = int(_loc_4.q_max_magicattack) + (_loc_3 ? (_loc_3.q_max_magicattack) : (0));
            this.q_physicattack_Percent = int(_loc_4.q_physicattack_Percent) + (_loc_3 ? (_loc_3.q_physicattack_Percent) : (0));
            this.q_magicattack_Percent = int(_loc_4.q_magicattack_Percent) + (_loc_3 ? (_loc_3.q_magicattack_Percent) : (0));
            this.q_defence = int(_loc_4.q_defence) + (_loc_3 ? (_loc_3.q_defence) : (0));
            this.q_hit = int(_loc_4.q_hit) + (_loc_3 ? (_loc_3.q_hit) : (0));
            this.q_dodge = int(_loc_4.q_dodge) + (_loc_3 ? (_loc_3.q_dodge) : (0));
            this.q_max_hp = int(_loc_4.q_max_hp) + (_loc_3 ? (_loc_3.q_max_hp) : (0));
            this.q_max_mp = int(_loc_4.q_max_mp) + (_loc_3 ? (_loc_3.q_max_mp) : (0));
            this.q_attackspeed = int(_loc_4.q_attackspeed) + (_loc_3 ? (_loc_3.q_attackspeed) : (0));
            this.q_speed = int(_loc_4.q_speed) + (_loc_3 ? (_loc_3.q_speed) : (0));
            this.q_element_attack = _loc_4.q_element_attack;
            this.q_element_defence = _loc_4.q_element_defence;
            this.q_reduce_injure = int(_loc_4.q_reduce_injure) + (_loc_3 ? (_loc_3.q_reduce_injure) : (0));
            this.q_add_injure = int(_loc_4.q_add_injure) + (_loc_3 ? (_loc_3.q_add_injure) : (0));
            var _loc_8:* = String(_loc_4.q_element_defence.substring(1, (_loc_4.q_element_defence.length - 1))).split(";");
            var _loc_9:* = 0;
            while (_loc_9 < _loc_8.length)
            {
                
                _loc_13 = _loc_8[_loc_9].split(",");
                switch(_loc_13[0])
                {
                    case "1":
                    {
                        _loc_5 = _loc_13[1];
                        break;
                    }
                    case "2":
                    {
                        _loc_6 = _loc_13[1];
                        break;
                    }
                    case "3":
                    {
                        _loc_7 = _loc_13[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_9++;
            }
            this.q_element_defence1 = _loc_5 + (_loc_3 ? (_loc_3.q_element_defence1) : (0));
            this.q_element_defence2 = _loc_6 + (_loc_3 ? (_loc_3.q_element_defence2) : (0));
            this.q_element_defence3 = _loc_7 + (_loc_3 ? (_loc_3.q_element_defence3) : (0));
            _loc_8 = String(_loc_4.q_element_attack.substring(1, (_loc_4.q_element_attack.length - 1))).split(";");
            _loc_9 = 0;
            while (_loc_9 < _loc_8.length)
            {
                
                _loc_13 = _loc_8[_loc_9].split(",");
                switch(_loc_13[0])
                {
                    case "1":
                    {
                        _loc_10 = _loc_13[1];
                        break;
                    }
                    case "2":
                    {
                        _loc_11 = _loc_13[1];
                        break;
                    }
                    case "3":
                    {
                        _loc_12 = _loc_13[1];
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_9++;
            }
            this.q_element_attack1 = _loc_10 + (_loc_3 ? (_loc_3.q_element_attack1) : (0));
            this.q_element_attack2 = _loc_11 + (_loc_3 ? (_loc_3.q_element_attack2) : (0));
            this.q_element_attack3 = _loc_12 + (_loc_3 ? (_loc_3.q_element_attack3) : (0));
            this.calFightNumber();
            return;
        }// end function

        public function calFightNumber() : int
        {
            var _loc_14:* = null;
            var _loc_1:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!_loc_1)
            {
                return 0;
            }
            var _loc_2:* = (this.getPhysicAttackUpper(_loc_1.q_equip_level, intensify, addAttributLevel) + this.getPhysicAttackLower(_loc_1.q_equip_level, intensify, addAttributLevel)) / 2;
            var _loc_3:* = (this.getMagicAttackUpper(_loc_1.q_equip_level, intensify, addAttributLevel) + this.getMagicAttackLower(_loc_1.q_equip_level, intensify, addAttributLevel)) / 2;
            var _loc_4:* = _loc_2 > 0 ? (_loc_2) : (_loc_3);
            var _loc_5:* = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this.itemModelId + "_" + addAttributLevel);
            var _loc_6:* = this.q_max_hp + (_loc_5 ? (_loc_5.q_max_hp) : (0));
            var _loc_7:* = this.q_max_mp + (_loc_5 ? (_loc_5.q_max_mp) : (0));
            var _loc_8:* = this.q_defence + (_loc_5 ? (_loc_5.q_defence) : (0));
            var _loc_9:* = this.q_dodge + (_loc_5 ? (_loc_5.q_dodge) : (0));
            var _loc_10:* = this.q_attackspeed + (_loc_5 ? (_loc_5.q_attackspeed) : (0));
            var _loc_11:* = this.q_element_defence1 + (_loc_5 ? (_loc_5.q_element_defence1) : (0));
            var _loc_12:* = this.q_element_defence2 + (_loc_5 ? (_loc_5.q_element_defence2) : (0));
            var _loc_13:* = this.q_element_defence3 + (_loc_5 ? (_loc_5.q_element_defence3) : (0));
            if (this.attributeCount == 0)
            {
                this.attributeCount = this.getRemarkScore();
            }
            this.fightNumber = Math.ceil(_loc_6 + _loc_4 * 12 + _loc_8 * 12 + _loc_7 * 0.1 + Number(_loc_9) / (_loc_9 + 2400) * 9120 + _loc_10 * 96 + (_loc_11 + _loc_12 + _loc_13) * 10 + (this.q_add_injure / 10000 + this.q_reduce_injure / 10000) * 800 * 12 + this.ignore_attack_percent / 10000 * 48000 + this.attributeCount);
            if (suitId)
            {
                _loc_14 = SuitCfgObj.instance.getSuitById(suitId);
                this.fightNumber = this.fightNumber + _loc_14.q_score;
            }
            return this.fightNumber;
        }// end function

        private function getRemarkScore() : int
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_1:* = 0;
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(itemModelId);
            var _loc_3:* = _loc_2.q_attribute_fightpower;
            if (!_loc_3)
            {
                return 0;
            }
            _loc_3 = _loc_3.slice(1, (_loc_3.length - 1));
            var _loc_4:* = _loc_3.split(",");
            var _loc_5:* = GlobalCfgObj.getInstance().getRemark();
            _loc_5 = _loc_5.slice(1, (_loc_5.length - 1));
            var _loc_6:* = _loc_5.split(",");
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6.length)
            {
                
                _loc_8 = Attributes.getAttrNameByType(_loc_6[_loc_7]);
                if (_loc_8 && this[_loc_8])
                {
                    _loc_9 = 0;
                    while (_loc_9 < _loc_4.length)
                    {
                        
                        _loc_10 = _loc_4[_loc_9].split("_");
                        if (_loc_6[_loc_7] == _loc_10[0])
                        {
                            _loc_1 = _loc_1 + int(_loc_10[1]);
                        }
                        _loc_9++;
                    }
                }
                _loc_7++;
            }
            return _loc_1;
        }// end function

        public function getPhysicAttackUpper(param1:int, param2:int, param3:int) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!ItemCfgObj.getInstance().getCfgBy(_itemModelId))
            {
                return 0;
            }
            var _loc_5:* = _loc_4.q_max_physicattack;
            var _loc_6:* = EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId);
            if (EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId) != null)
            {
                if (this.q_physicattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.q_physicattack_bylevel;
                }
                if (this.allattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.allattack_bylevel;
                }
            }
            if (param2 > 0)
            {
                _loc_7 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this.itemModelId + "_" + param2);
                if (_loc_7 != null)
                {
                    _loc_5 = _loc_5 + _loc_7.q_max_physicattack;
                }
            }
            if (param3 > 0)
            {
                _loc_8 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this.itemModelId + "_" + param3);
                if (_loc_8 != null)
                {
                    _loc_5 = _loc_5 + _loc_8.q_max_physicattack;
                }
            }
            return Math.ceil(_loc_5);
        }// end function

        public function getPhysicAttackLower(param1:int, param2:int, param3:int) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!ItemCfgObj.getInstance().getCfgBy(_itemModelId))
            {
                return 0;
            }
            var _loc_5:* = _loc_4.q_min_physicattack;
            var _loc_6:* = EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId);
            if (EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId) != null)
            {
                if (this.q_physicattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.q_physicattack_bylevel;
                }
                if (this.allattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.allattack_bylevel;
                }
            }
            if (param2 > 0)
            {
                _loc_7 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this.itemModelId + "_" + param2);
                if (_loc_7 != null)
                {
                    _loc_5 = _loc_5 + _loc_7.q_min_physicattack;
                }
            }
            if (param3 > 0)
            {
                _loc_8 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this.itemModelId + "_" + param3);
                if (_loc_8 != null)
                {
                    _loc_5 = _loc_5 + _loc_8.q_min_physicattack;
                }
            }
            return Math.ceil(_loc_5);
        }// end function

        public function getMagicAttackUpper(param1:int, param2:int, param3:int) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!ItemCfgObj.getInstance().getCfgBy(_itemModelId))
            {
                return 0;
            }
            var _loc_5:* = _loc_4.q_max_magicattack;
            var _loc_6:* = EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId);
            if (EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId) != null)
            {
                if (this.q_magicattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.q_magicattack_bylevel;
                }
                if (this.allattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.allattack_bylevel;
                }
            }
            if (param2 > 0)
            {
                _loc_7 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this.itemModelId + "_" + param2);
                if (_loc_7 != null)
                {
                    _loc_5 = _loc_5 + _loc_7.q_max_magicattack;
                }
            }
            if (param3 > 0)
            {
                _loc_8 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this.itemModelId + "_" + param3);
                if (_loc_8 != null)
                {
                    _loc_5 = _loc_5 + _loc_8.q_max_magicattack;
                }
            }
            return Math.ceil(_loc_5);
        }// end function

        public function getMagicAttackLower(param1:int, param2:int, param3:int) : int
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = ItemCfgObj.getInstance().getCfgBy(_itemModelId);
            if (!ItemCfgObj.getInstance().getCfgBy(_itemModelId))
            {
                return 0;
            }
            var _loc_5:* = _loc_4.q_min_magicattack;
            var _loc_6:* = EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId);
            if (EquipAppendCfgObj.getInstance().getEquipAppendById(itemModelId) != null)
            {
                if (this.q_magicattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.q_magicattack_bylevel;
                }
                if (this.allattack_bylevel)
                {
                    _loc_5 = _loc_5 + param1 / this.allattack_bylevel;
                }
            }
            if (param2 > 0)
            {
                _loc_7 = EquipStrengCfgObj.getInstance().getEquipStrenginfoByLev(this.itemModelId + "_" + param2);
                if (_loc_7 != null)
                {
                    _loc_5 = _loc_5 + _loc_7.q_min_magicattack;
                }
            }
            if (param3 > 0)
            {
                _loc_8 = EquipProcessCfgObj.getInstance().getEquipProcessinfoByLev(this.itemModelId + "_" + param3);
                if (_loc_8 != null)
                {
                    _loc_5 = _loc_5 + _loc_8.q_min_magicattack;
                }
            }
            return Math.ceil(_loc_5);
        }// end function

        public function cloneEquip()
        {
            var _loc_1:* = this;
            var _loc_2:* = getQualifiedClassName(_loc_1);
            var _loc_3:* = _loc_2.split("::")[0];
            var _loc_4:* = getDefinitionByName(_loc_2) as Class;
            var _loc_5:* = getDefinitionByName("com.game.utils::long") as Class;
            var _loc_6:* = getDefinitionByName("com.game.backpack.bean::GoodsAttribute") as Class;
            registerClassAlias(_loc_3, _loc_4);
            registerClassAlias("com.game.utils", _loc_5);
            registerClassAlias("com.game.backpack.bean", _loc_6);
            var _loc_7:* = new ByteArray();
            _loc_7.writeObject(_loc_1);
            _loc_7.position = 0;
            return _loc_7.readObject();
        }// end function

    }
}
