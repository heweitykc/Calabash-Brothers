package com.game.backpack.util
{
    import com.game.player.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class EquipUtil extends Object
    {

        public function EquipUtil()
        {
            return;
        }// end function

        public static function checkCanEquip(param1:EquipmentInfo, param2:PlayerInfo) : Boolean
        {
            if (!PropUtil.jobAdapt(param1, param2.job))
            {
                return false;
            }
            if (param1.unInteractive)
            {
                return false;
            }
            if (param1.q_sex != 0 && param1.q_sex != param2.sex)
            {
                return false;
            }
            if (param1.q_level != 0 && param1.q_level > param2.level)
            {
                return false;
            }
            if (PropUtil.checkItemExpire(param1))
            {
                return false;
            }
            return true;
        }// end function

        public static function checkNeedGuide(param1:EquipmentInfo) : Boolean
        {
            if (!checkCanEquip(param1, UserObj.getInstance().playerInfo))
            {
                return false;
            }
            if (!checkFightNumber(param1))
            {
                return false;
            }
            if (!checkPoint(param1 as PropInfo, UserObj.getInstance().playerInfo))
            {
                return false;
            }
            return true;
        }// end function

        public static function checkPoint(param1:PropInfo, param2:PlayerInfo) : Boolean
        {
            var _loc_3:* = 0;
            if (param1.q_str_limit > param2.strength)
            {
                _loc_3 = _loc_3 + (param1.q_str_limit - param2.strength);
            }
            if (param1.q_agile_limit > param2.agile)
            {
                _loc_3 = _loc_3 + (param1.q_agile_limit - param2.agile);
            }
            if (param1.q_int_limit > param2.intelligence)
            {
                _loc_3 = _loc_3 + (param1.q_int_limit - param2.intelligence);
            }
            if (param1.q_vit_limit > param2.vitality)
            {
                _loc_3 = _loc_3 + (param1.q_vit_limit - param2.vitality);
            }
            if (_loc_3 <= param2.unallocatedTalent)
            {
                return true;
            }
            return false;
        }// end function

        public static function checkFightNumber(param1:Object) : Boolean
        {
            if (EquipUtil.compareEquip(param1 as EquipmentInfo) == 1)
            {
                return true;
            }
            return false;
        }// end function

        public static function compareEquip(param1:EquipmentInfo) : int
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (PropUtil.jobAdapt(param1, UserObj.getInstance().playerInfo.job))
            {
                if (PropUtil.isWeapon(param1))
                {
                    _loc_2 = EquipsObj.getInstance().getEquipBy(Params.LEFT_WEAPON);
                    if (_loc_2 && _loc_2.q_secondary_type == 2)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    if (param1.q_secondary_type == 2)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    if (param1.q_kind == 2)
                    {
                        _loc_2 = EquipsObj.getInstance().getEquipBy(Params.RIGHT_WEAPON);
                        return compareEquips(param1, _loc_2);
                    }
                    if (param1.q_third_type == 1)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    if (param1.q_third_type == 3 || param1.q_third_type == 4)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    _loc_4 = EquipsObj.getInstance().getEquipBy(Params.RIGHT_WEAPON);
                    if (_loc_2 == null && _loc_4 == null)
                    {
                        return 1;
                    }
                    if (_loc_2 == null && _loc_4 != null)
                    {
                        return compareEquips(param1, _loc_4);
                    }
                    if (_loc_2 != null && _loc_4 == null)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    _loc_2 = _loc_2.fightNumber < _loc_4.fightNumber ? (_loc_2) : (_loc_4);
                    return compareEquips(param1, _loc_2);
                }
                else if (param1.q_kind == Params.RING1 || param1.q_kind == Params.RING2)
                {
                    _loc_2 = EquipsObj.getInstance().getEquipBy(Params.RING1);
                    _loc_4 = EquipsObj.getInstance().getEquipBy(Params.RING2);
                    if (_loc_2 == null && _loc_4 == null)
                    {
                        return 1;
                    }
                    if (_loc_2 == null && _loc_4 != null)
                    {
                        return compareEquips(param1, _loc_4);
                    }
                    if (_loc_2 != null && _loc_4 == null)
                    {
                        return compareEquips(param1, _loc_2);
                    }
                    _loc_2 = _loc_2.fightNumber < _loc_4.fightNumber ? (_loc_2) : (_loc_4);
                    return compareEquips(param1, _loc_2);
                }
                else
                {
                    if (param1)
                    {
                        _loc_2 = EquipsObj.getInstance().getEquipBy(param1.q_kind);
                        return compareEquips(param1, _loc_2);
                    }
                    return 1;
                }
            }
            return 0;
        }// end function

        public static function compareEquips(param1:EquipmentInfo, param2:EquipmentInfo) : int
        {
            if (param2 == null)
            {
                return 1;
            }
            if (param1.fightNumber > param2.fightNumber)
            {
                return 1;
            }
            if (param1.fightNumber < param2.fightNumber)
            {
                return 2;
            }
            return 0;
        }// end function

        public static function getEquipPosNameByPos(param1:int) : String
        {
            switch(param1)
            {
                case Params.HEAD:
                {
                    return PropUtil.HEAD;
                }
                case Params.WING:
                {
                    return PropUtil.WING;
                }
                case Params.HAND:
                {
                    return PropUtil.HAND;
                }
                case Params.RING1:
                case Params.RING2:
                {
                    return PropUtil.RING;
                }
                case Params.BODY:
                {
                    return PropUtil.BODY;
                }
                case Params.PET:
                {
                    return PropUtil.PET_WEA;
                }
                case Params.LEG:
                {
                    return PropUtil.LEG;
                }
                case Params.SHOE:
                {
                    return PropUtil.SHOE;
                }
                case Params.NICKLACE:
                {
                    return PropUtil.NICKLACE;
                }
                case Params.LEFT_WEAPON:
                {
                    return PropUtil.LEFTWEAPOIN;
                }
                case Params.RIGHT_WEAPON:
                {
                    return PropUtil.RIGHTWEAPON;
                }
                case Params.RIDE:
                {
                    return PropUtil.RIDE;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

    }
}
