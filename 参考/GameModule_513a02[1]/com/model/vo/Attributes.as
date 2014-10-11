package com.model.vo
{

    public class Attributes extends Object
    {
        private var value:int;
        public static const LEVEL:uint = 1;
        public static const EXP:uint = 2;
        public static const ZHENQI:uint = 3;
        public static const BATTLEEXP:uint = 4;
        public static const HP:uint = 5;
        public static const MP:uint = 6;
        public static const SP:uint = 7;
        public static const MAXHP:uint = 8;
        public static const MAXMP:uint = 9;
        public static const MAXSP:uint = 10;
        public static const ATTACK:uint = 11;
        public static const LUCK:uint = 15;
        public static const ATTACKSPEED:uint = 16;
        public static const HIT:uint = 22;
        public static const Q_HP_RECOVER:int = 23;
        public static const Q_ADD_MPLIMIT:int = 24;
        public static const Q_ADD_HP_LIMIT:int = 25;
        public static const Q_REDUCE_DAMAGE:int = 26;
        public static const Q_REBOUND_DAMAGE:int = 27;
        public static const Q_ADD_MONEY:int = 29;
        public static const Q_REMARKBLE_ATTACK:int = 30;
        public static const Q_PHYSICATTACK_BYLEVEL:int = 31;
        public static const Q_REMARK_PHYSICATTACK_PERCENT:int = 32;
        public static const Q_MAGICATTACK_BYLEVEL:int = 33;
        public static const Q_REMARK_MAGICATTACK_PERCENT:int = 34;
        public static const Q_REMARK_ATTACKSPEED:int = 35;
        public static const Q_ADDHP_WHENKILL:int = 36;
        public static const Q_ADDMP_WHENKILL:int = 37;
        public static const ICE_ATTACK:int = 38;
        public static const RAY_ATTACK:int = 39;
        public static const POISON_ATTACK:int = 40;
        public static const ICE_DEF:int = 41;
        public static const RAY_DEF:int = 42;
        public static const POISON_DEF:int = 43;
        public static const IGNORE_ATTACKPERCENT:int = 44;
        public static const Q_DEFENCE_REMARK:int = 45;
        public static const DODGEPERCENT:int = 46;
        public static const CRIT:int = 47;
        public static const KNOWING_ATTACKPERCENT:int = 49;
        public static const PHYSIC_ATTACKUPPER:int = 50;
        public static const PHYSIC_ATTACKLOWER:int = 51;
        public static const MAGIC_ATTACKUPPER:int = 52;
        public static const MAGIC_ATTACKLOWER:int = 53;
        public static const ATTACKPERCENT:int = 54;
        public static const PHYSIC_ATTACKPERCENT:int = 55;
        public static const MAGIC_ATTACKPERCENT:int = 56;
        public static const DEFENSE:int = 57;
        public static const DEFENSEPERCENT:int = 58;
        public static const SPEED:int = 59;
        public static const UNALLOCATEDTALENT:int = 62;
        public static const ALLATTACK_BYLEVEL:int = 64;
        public static const ALLATTACK_PERCENT:int = 65;
        public static const FATAL_BLOW:int = 66;
        private static var equipAttrName:Array = [];

        public function Attributes(param1:int)
        {
            this.value = param1;
            return;
        }// end function

        public function getValue() : int
        {
            return this.value;
        }// end function

        public function compare(param1:int) : Boolean
        {
            return this.value == param1;
        }// end function

        public static function setAttr(param1:RoleInfo, param2) : void
        {
            var _loc_5:* = null;
            var _loc_3:* = param2.type;
            var _loc_4:* = param2.value;
            switch(_loc_3)
            {
                case ZHENQI:
                {
                    _loc_5 = "zhenqi";
                    break;
                }
                case BATTLEEXP:
                {
                    _loc_5 = "battleExp";
                    break;
                }
                case HP:
                {
                    _loc_5 = "HP";
                    break;
                }
                case MP:
                {
                    _loc_5 = "MP";
                    break;
                }
                case SP:
                {
                    _loc_5 = "SP";
                    break;
                }
                case MAXHP:
                {
                    _loc_5 = "HPMax";
                    break;
                }
                case MAXMP:
                {
                    _loc_5 = "MPMax";
                    break;
                }
                case RAY_ATTACK:
                {
                    _loc_5 = "ray_attack";
                    break;
                }
                case ICE_ATTACK:
                {
                    _loc_5 = "ice_attack";
                    break;
                }
                case POISON_ATTACK:
                {
                    _loc_5 = "poison_attack";
                    break;
                }
                case RAY_DEF:
                {
                    _loc_5 = "ray_def";
                    break;
                }
                case ICE_DEF:
                {
                    _loc_5 = "ice_def";
                    break;
                }
                case POISON_DEF:
                {
                    _loc_5 = "poison_def";
                    break;
                }
                case MAXSP:
                {
                    _loc_5 = "SPMax";
                    break;
                }
                case ATTACK:
                {
                    _loc_5 = "attack";
                    break;
                }
                case LUCK:
                {
                    _loc_5 = "luck";
                    break;
                }
                case DEFENSE:
                {
                    _loc_5 = "defense";
                    break;
                }
                case DEFENSEPERCENT:
                {
                    _loc_5 = "dodge";
                    break;
                }
                case CRIT:
                {
                    _loc_5 = "crit";
                    break;
                }
                case LUCK:
                {
                    _loc_5 = "luck";
                    break;
                }
                case ATTACKSPEED:
                {
                    _loc_5 = "attackspeed";
                    break;
                }
                case SPEED:
                {
                    _loc_5 = "speed";
                    break;
                }
                case PHYSIC_ATTACKUPPER:
                {
                    _loc_5 = "physic_attackupper";
                    break;
                }
                case PHYSIC_ATTACKLOWER:
                {
                    _loc_5 = "physic_attacklower";
                    break;
                }
                case MAGIC_ATTACKUPPER:
                {
                    _loc_5 = "magic_attackupper";
                    break;
                }
                case MAGIC_ATTACKLOWER:
                {
                    _loc_5 = "magic_attacklower";
                    break;
                }
                case ATTACKPERCENT:
                {
                    _loc_5 = "attackPercent";
                    break;
                }
                case HIT:
                {
                    _loc_5 = "hit";
                    break;
                }
                case Q_HP_RECOVER:
                {
                    _loc_5 = "q_hp_cover";
                    break;
                }
                case Q_ADD_HP_LIMIT:
                {
                    _loc_5 = "q_add_hplimit";
                    break;
                }
                case Q_ADD_MPLIMIT:
                {
                    _loc_5 = "q_add_mplimit";
                    break;
                }
                case Q_REDUCE_DAMAGE:
                {
                    _loc_5 = "q_reduce_damage";
                    break;
                }
                case Q_REBOUND_DAMAGE:
                {
                    _loc_5 = "q_rebound_damage";
                    break;
                }
                case Q_DEFENCE_REMARK:
                {
                    _loc_5 = "q_defence_remark";
                    break;
                }
                case Q_ADD_MONEY:
                {
                    _loc_5 = "q_add_money";
                    break;
                }
                case Q_REMARKBLE_ATTACK:
                {
                    _loc_5 = "q_remarkable_attack";
                    break;
                }
                case Q_PHYSICATTACK_BYLEVEL:
                {
                    _loc_5 = "q_physicattack_bylevel";
                    break;
                }
                case Q_REMARK_PHYSICATTACK_PERCENT:
                {
                    _loc_5 = "q_physicattack_percent";
                    break;
                }
                case Q_MAGICATTACK_BYLEVEL:
                {
                    _loc_5 = "q_magicattack_bylevel";
                    break;
                }
                case Q_REMARK_MAGICATTACK_PERCENT:
                {
                    _loc_5 = "q_magicattack_percent";
                    break;
                }
                case Q_REMARK_ATTACKSPEED:
                {
                    _loc_5 = "q_remark_attackspeed";
                    break;
                }
                case Q_ADDHP_WHENKILL:
                {
                    _loc_5 = "q_addhp_whenkill";
                    break;
                }
                case Q_ADDMP_WHENKILL:
                {
                    _loc_5 = "q_addmp_whenkill";
                    break;
                }
                case IGNORE_ATTACKPERCENT:
                {
                    _loc_5 = "ignore_attackPercent";
                    break;
                }
                case DODGEPERCENT:
                {
                    _loc_5 = "dodgePercent";
                    break;
                }
                case KNOWING_ATTACKPERCENT:
                {
                    _loc_5 = "Knowing_attackPercent";
                    break;
                }
                case ATTACKPERCENT:
                {
                    _loc_5 = "attackPercent";
                    break;
                }
                case PHYSIC_ATTACKPERCENT:
                {
                    _loc_5 = "physic_attackpercent";
                    break;
                }
                case MAGIC_ATTACKPERCENT:
                {
                    _loc_5 = "magic_attackpercent";
                    break;
                }
                case DEFENSEPERCENT:
                {
                    _loc_5 = "dodge";
                    break;
                }
                case UNALLOCATEDTALENT:
                {
                    _loc_5 = "unallocatedTalent";
                    break;
                }
                case ALLATTACK_BYLEVEL:
                {
                    _loc_5 = "allattack_bylevel";
                    break;
                }
                case ALLATTACK_PERCENT:
                {
                    _loc_5 = "allattack_percent";
                    break;
                }
                case FATAL_BLOW:
                {
                    _loc_5 = "fatal_blow";
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_5 && param1.hasOwnProperty(_loc_5))
            {
                param1[_loc_5] = _loc_4;
            }
            return;
        }// end function

        public static function setEquipAttr(param1:EquipmentInfo, param2:Object) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param2.hasOwnProperty("attributeType"))
            {
                _loc_3 = param2.attributeType;
            }
            else
            {
                _loc_3 = param2.type;
            }
            if (param2.hasOwnProperty("attributeValue"))
            {
                _loc_4 = param2.attributeValue;
            }
            else
            {
                _loc_4 = param2.value;
            }
            switch(_loc_3)
            {
                case Q_HP_RECOVER:
                {
                    param1.q_hp_cover = _loc_4;
                    if (!equipAttrName[Q_HP_RECOVER])
                    {
                        equipAttrName[Q_HP_RECOVER] = "q_hp_cover";
                    }
                    break;
                }
                case Q_ADD_HP_LIMIT:
                {
                    param1.q_add_hplimit = _loc_4;
                    if (!equipAttrName[Q_ADD_HP_LIMIT])
                    {
                        equipAttrName[Q_ADD_HP_LIMIT] = "q_add_hplimit";
                    }
                    break;
                }
                case Q_ADD_MPLIMIT:
                {
                    param1.q_add_mplimit = _loc_4;
                    if (!equipAttrName[Q_ADD_MPLIMIT])
                    {
                        equipAttrName[Q_ADD_MPLIMIT] = "q_add_mplimit";
                    }
                    break;
                }
                case Q_REDUCE_DAMAGE:
                {
                    param1.q_reduce_damage = _loc_4;
                    if (!equipAttrName[Q_REDUCE_DAMAGE])
                    {
                        equipAttrName[Q_REDUCE_DAMAGE] = "q_reduce_damage";
                    }
                    break;
                }
                case Q_REBOUND_DAMAGE:
                {
                    param1.q_rebound_damage = _loc_4;
                    if (!equipAttrName[Q_REBOUND_DAMAGE])
                    {
                        equipAttrName[Q_REBOUND_DAMAGE] = "q_rebound_damage";
                    }
                    break;
                }
                case Q_DEFENCE_REMARK:
                {
                    param1.q_defence_remark = _loc_4;
                    if (!equipAttrName[Q_DEFENCE_REMARK])
                    {
                        equipAttrName[Q_DEFENCE_REMARK] = "q_defence_remark";
                    }
                    break;
                }
                case Q_ADD_MONEY:
                {
                    param1.q_add_money = _loc_4;
                    if (!equipAttrName[Q_ADD_MONEY])
                    {
                        equipAttrName[Q_ADD_MONEY] = "q_add_money";
                    }
                    break;
                }
                case Q_PHYSICATTACK_BYLEVEL:
                {
                    param1.q_physicattack_bylevel = _loc_4;
                    if (!equipAttrName[Q_PHYSICATTACK_BYLEVEL])
                    {
                        equipAttrName[Q_PHYSICATTACK_BYLEVEL] = "q_physicattack_bylevel";
                    }
                    break;
                }
                case Q_REMARK_PHYSICATTACK_PERCENT:
                {
                    param1.q_remark_physicattack_percent = _loc_4;
                    if (!equipAttrName[Q_REMARK_PHYSICATTACK_PERCENT])
                    {
                        equipAttrName[Q_REMARK_PHYSICATTACK_PERCENT] = "q_remark_physicattack_percent";
                    }
                    break;
                }
                case Q_MAGICATTACK_BYLEVEL:
                {
                    param1.q_magicattack_bylevel = _loc_4;
                    if (!equipAttrName[Q_MAGICATTACK_BYLEVEL])
                    {
                        equipAttrName[Q_MAGICATTACK_BYLEVEL] = "q_magicattack_bylevel";
                    }
                    break;
                }
                case Q_REMARK_MAGICATTACK_PERCENT:
                {
                    param1.q_remark_magicattack_percent = _loc_4;
                    if (!equipAttrName[Q_REMARK_MAGICATTACK_PERCENT])
                    {
                        equipAttrName[Q_REMARK_MAGICATTACK_PERCENT] = "q_remark_magicattack_percent";
                    }
                    break;
                }
                case Q_REMARK_ATTACKSPEED:
                {
                    param1.q_remarkable_attackSpeed = _loc_4;
                    if (!equipAttrName[Q_REMARK_ATTACKSPEED])
                    {
                        equipAttrName[Q_REMARK_ATTACKSPEED] = "q_remarkable_attackSpeed";
                    }
                    break;
                }
                case Q_ADDHP_WHENKILL:
                {
                    param1.q_addhp_whenkill = _loc_4;
                    if (!equipAttrName[Q_ADDHP_WHENKILL])
                    {
                        equipAttrName[Q_ADDHP_WHENKILL] = "q_addhp_whenkill";
                    }
                    break;
                }
                case Q_ADDMP_WHENKILL:
                {
                    param1.q_addmp_whenkill = _loc_4;
                    if (!equipAttrName[Q_ADDMP_WHENKILL])
                    {
                        equipAttrName[Q_ADDMP_WHENKILL] = "q_addmp_whenkill";
                    }
                    break;
                }
                case CRIT:
                {
                    param1.q_remarkable_attack = _loc_4;
                    if (!equipAttrName[CRIT])
                    {
                        equipAttrName[CRIT] = "q_remarkable_attack";
                    }
                    break;
                }
                case KNOWING_ATTACKPERCENT:
                {
                    param1.knowing_attackpercent = _loc_4;
                    if (!equipAttrName[KNOWING_ATTACKPERCENT])
                    {
                        equipAttrName[KNOWING_ATTACKPERCENT] = "knowing_attackpercent";
                    }
                    break;
                }
                case IGNORE_ATTACKPERCENT:
                {
                    param1.ignore_attack_percent = _loc_4;
                    if (!equipAttrName[IGNORE_ATTACKPERCENT])
                    {
                        equipAttrName[IGNORE_ATTACKPERCENT] = "ignore_attack_percent";
                    }
                    break;
                }
                case ALLATTACK_BYLEVEL:
                {
                    param1.allattack_bylevel = _loc_4;
                    if (!equipAttrName[ALLATTACK_BYLEVEL])
                    {
                        equipAttrName[ALLATTACK_BYLEVEL] = "allattack_bylevel";
                    }
                    break;
                }
                case ALLATTACK_PERCENT:
                {
                    param1.allattack_percent = _loc_4;
                    if (!equipAttrName[ALLATTACK_PERCENT])
                    {
                        equipAttrName[ALLATTACK_PERCENT] = "allattack_percent";
                    }
                    break;
                }
                case FATAL_BLOW:
                {
                    param1.knowing_attackpercent = _loc_4;
                    if (!equipAttrName[FATAL_BLOW])
                    {
                        equipAttrName[FATAL_BLOW] = "fatal_blow";
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getAttrNameByType(param1:int) : String
        {
            if (equipAttrName[param1])
            {
                return equipAttrName[param1];
            }
            return "";
        }// end function

    }
}
