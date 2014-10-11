package com.util
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.backpack.bean.*;
    import com.game.masterequip.bean.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;

    public class PropUtil extends Object
    {
        public static const WHITE:uint = 16777215;
        public static const BLUE:uint = 49407;
        public static const PURPLE:uint = 10551551;
        public static const PURPLE_S:uint = 16724940;
        public static const GREEN:uint = 2031360;
        public static const GOLD:uint = 16578048;
        public static const GRAY:uint = 11053224;
        public static var COIN:String = LanguageCfgObj.getInstance().getByIndex("10081");
        public static var MEDICINE:String = LanguageCfgObj.getInstance().getByIndex("10082");
        public static var DIAMOND:String = LanguageCfgObj.getInstance().getByIndex("10083");
        public static var CONVEY:String = LanguageCfgObj.getInstance().getByIndex("10084");
        public static var TASK_REEL:String = LanguageCfgObj.getInstance().getByIndex("10085");
        public static var SKILL_BOOK:String = LanguageCfgObj.getInstance().getByIndex("10086");
        public static var PRESENT:String = LanguageCfgObj.getInstance().getByIndex("10087");
        public static var SCRIPT_ITEM:String = LanguageCfgObj.getInstance().getByIndex("10088");
        public static var OPEN_PANEL_ITEM:String = LanguageCfgObj.getInstance().getByIndex("10089");
        public static var NORMAL:String = LanguageCfgObj.getInstance().getByIndex("10090");
        public static var TASK_ITEM:String = LanguageCfgObj.getInstance().getByIndex("10091");
        public static var SYNTHETIC_MATERIAL:String = LanguageCfgObj.getInstance().getByIndex("10092");
        public static var RIDE_EQUIP:String = LanguageCfgObj.getInstance().getByIndex("10093");
        public static var PET:String = LanguageCfgObj.getInstance().getByIndex("10094");
        public static var RIDE:String = LanguageCfgObj.getInstance().getByIndex("10095");
        public static var USE:String = LanguageCfgObj.getInstance().getByIndex("10096");
        public static var ATTRIBUTE:String = LanguageCfgObj.getInstance().getByIndex("10097");
        public static var RIDEDAN:String = LanguageCfgObj.getInstance().getByIndex("10098");
        public static var MATERIAL:String = LanguageCfgObj.getInstance().getByIndex("10099");
        public static var MAYA:String = LanguageCfgObj.getInstance().getByIndex("10100");
        public static var CHEST:String = LanguageCfgObj.getInstance().getByIndex("10101");
        public static var RELIVERELL:String = LanguageCfgObj.getInstance().getByIndex("10102");
        public static var CURRENCY:String = LanguageCfgObj.getInstance().getByIndex("10103");
        public static var GONGYI:String = LanguageCfgObj.getInstance().getByIndex("10104");
        public static var LEFTWEAPOIN:String = LanguageCfgObj.getInstance().getByIndex("10105");
        public static var BODY:String = LanguageCfgObj.getInstance().getByIndex("10106");
        public static var HEAD:String = LanguageCfgObj.getInstance().getByIndex("10107");
        public static var NICKLACE:String = LanguageCfgObj.getInstance().getByIndex("10108");
        public static var HAND:String = LanguageCfgObj.getInstance().getByIndex("10109");
        public static var LEG:String = LanguageCfgObj.getInstance().getByIndex("10110");
        public static var RING:String = LanguageCfgObj.getInstance().getByIndex("10111");
        public static var SHOE:String = LanguageCfgObj.getInstance().getByIndex("10112");
        public static var RIGHTWEAPON:String = LanguageCfgObj.getInstance().getByIndex("10113");
        public static var WING:String = LanguageCfgObj.getInstance().getByIndex("10114");
        public static var PET_WEA:String = LanguageCfgObj.getInstance().getByIndex("10115");
        public static const RARE_ITEM_TYPE:Array = [3, 19, 6, 20, 22];
        private static const JOB_LEN:int = 12;

        public function PropUtil()
        {
            return;
        }// end function

        public static function getElementColor(param1:int) : uint
        {
            switch(param1)
            {
                case ElementHeartQuality.PURPLE:
                {
                    return PURPLE_S;
                }
                case ElementHeartQuality.BLUE:
                {
                    return BLUE;
                }
                case ElementHeartQuality.GOLD:
                {
                    return GOLD;
                }
                case ElementHeartQuality.GREEN:
                {
                    return GREEN;
                }
                default:
                {
                    break;
                }
            }
            return WHITE;
        }// end function

        public static function getElementColorText(param1:int) : String
        {
            switch(param1)
            {
                case ElementHeartQuality.PURPLE:
                {
                    return LanguageCfgObj.getInstance().getByIndex("eh1014", "lang_elementHeart");
                }
                case ElementHeartQuality.BLUE:
                {
                    return LanguageCfgObj.getInstance().getByIndex("eh1011", "lang_elementHeart");
                }
                case ElementHeartQuality.GOLD:
                {
                    return LanguageCfgObj.getInstance().getByIndex("eh1012", "lang_elementHeart");
                }
                case ElementHeartQuality.GREEN:
                {
                    return LanguageCfgObj.getInstance().getByIndex("eh1013", "lang_elementHeart");
                }
                default:
                {
                    break;
                }
            }
            return LanguageCfgObj.getInstance().getByIndex("eh1011", "lang_elementHeart");
        }// end function

        public static function getPropColor(param1:int) : uint
        {
            switch(param1)
            {
                case PropQuality.GRAY:
                {
                    return GRAY;
                }
                case PropQuality.WHITE:
                {
                    return WHITE;
                }
                case PropQuality.BLUE:
                {
                    return BLUE;
                }
                case PropQuality.ORANGE:
                {
                    return GOLD;
                }
                case PropQuality.PURPLE:
                {
                    return PURPLE;
                }
                case PropQuality.PURPLE_S:
                {
                    return PURPLE;
                }
                case PropQuality.GREEN:
                {
                    return GREEN;
                }
                default:
                {
                    break;
                }
            }
            return 0;
        }// end function

        public static function getQualityColorKind(param1:int) : String
        {
            switch(param1)
            {
                case PropQuality.GRAY:
                {
                    return "";
                }
                case PropQuality.WHITE:
                {
                    return "";
                }
                case PropQuality.BLUE:
                {
                    return "blue";
                }
                case PropQuality.ORANGE:
                {
                    return "gold";
                }
                case PropQuality.PURPLE:
                {
                    return "purple";
                }
                case PropQuality.PURPLE_S:
                {
                    return "purple";
                }
                case PropQuality.GREEN:
                {
                    return "green";
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public static function getPropKind(param1:int) : String
        {
            switch(param1)
            {
                case ItemType.MEDICINE:
                {
                    return MEDICINE;
                }
                case ItemType.CONVEY:
                {
                    return CONVEY;
                }
                case ItemType.DIAMOND:
                {
                    return DIAMOND;
                }
                case ItemType.GOLD:
                {
                    return COIN;
                }
                case ItemType.NORMAL:
                {
                    return NORMAL;
                }
                case ItemType.OPEN_PANEL_ITEM:
                {
                    return OPEN_PANEL_ITEM;
                }
                case ItemType.PET:
                {
                    return PET;
                }
                case ItemType.PRESENT:
                {
                    return PRESENT;
                }
                case ItemType.RIDE:
                {
                    return RIDE;
                }
                case ItemType.RIDE_EQUIP:
                {
                    return RIDE_EQUIP;
                }
                case ItemType.SCRIPT_ITEM:
                {
                    return SCRIPT_ITEM;
                }
                case ItemType.SYNTHETIC_MATERIAL:
                {
                    return SYNTHETIC_MATERIAL;
                }
                case ItemType.TASK_ITEM:
                {
                    return TASK_ITEM;
                }
                case ItemType.TASK_REEL:
                {
                    return TASK_REEL;
                }
                case ItemType.SKILL_BOOK:
                {
                    return SKILL_BOOK;
                }
                case ItemType.RIDEDAN:
                {
                    return RIDEDAN;
                }
                case ItemType.USE:
                {
                    return USE;
                }
                case ItemType.ATTRIBUTE:
                {
                    return ATTRIBUTE;
                }
                case ItemType.MATERIAL:
                {
                    return MATERIAL;
                }
                case ItemType.WING:
                {
                    return WING;
                }
                case ItemType.MAYA:
                {
                    return MAYA;
                }
                case ItemType.CHEST:
                {
                    return CHEST;
                }
                case ItemType.RELIVERELL:
                {
                    return RELIVERELL;
                }
                case ItemType.CURRENCY:
                {
                    return CURRENCY;
                }
                case ItemType.GONGYI:
                {
                    return GONGYI;
                }
                default:
                {
                    break;
                }
            }
            return null;
        }// end function

        public static function getHtmlTxt(param1:PropInfo, param2:Boolean = false, param3:Boolean = false) : String
        {
            var _loc_4:* = PropUtil.getEquipColor(param1);
            var _loc_5:* = PropUtil.getEquipName(param1, param2, param3);
            return "<font color = \'#" + _loc_4.toString(16) + "\'>" + _loc_5 + "</font>";
        }// end function

        public static function getEquipType(param1:int) : String
        {
            switch(param1)
            {
                case Params.LEFT_WEAPON:
                {
                    return LEFTWEAPOIN;
                }
                case Params.RIGHT_WEAPON:
                {
                    return RIGHTWEAPON;
                }
                case Params.BODY:
                {
                    return BODY;
                }
                case Params.LEG:
                {
                    return LEG;
                }
                case Params.SHOE:
                {
                    return SHOE;
                }
                case Params.HEAD:
                {
                    return HEAD;
                }
                case Params.HAND:
                {
                    return HAND;
                }
                case Params.NICKLACE:
                {
                    return NICKLACE;
                }
                case Params.RING1:
                {
                    return RING;
                }
                case Params.RING2:
                {
                    return RING;
                }
                case Params.WING:
                {
                    return WING;
                }
                case Params.PET:
                {
                    return PET;
                }
                default:
                {
                    break;
                }
            }
            return "";
        }// end function

        public static function getEquipNameAndColor(param1:PropInfo) : Array
        {
            var _loc_2:* = getEquipName(param1, true);
            var _loc_3:* = getEquipColor(param1);
            return [_loc_2, _loc_3];
        }// end function

        public static function getSuitName(param1:int) : String
        {
            var _loc_2:* = null;
            if (param1)
            {
                _loc_2 = SuitCfgObj.instance.getSuitById(param1);
            }
            return _loc_2 ? (_loc_2.q_firstname) : ("");
        }// end function

        public static function getIntensify(param1:PropInfo) : String
        {
            if (param1.intensify > 0)
            {
                return "+" + param1.intensify;
            }
            return "";
        }// end function

        public static function getEquipName(param1:PropInfo, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : String
        {
            var _loc_6:* = null;
            var _loc_5:* = "";
            if (param1.suitId && param4)
            {
                _loc_6 = SuitCfgObj.instance.getSuitById(param1.suitId);
                _loc_5 = _loc_5 + (_loc_6.q_firstname + " ");
            }
            if (param1 is EquipmentInfo && param3)
            {
                if (param1.q_kind == Params.SHOW)
                {
                }
                else if (param1.q_quality_lv == PropQuality.PURPLE_S)
                {
                    _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("11785") + " ");
                    if (param1.q_remarkable)
                    {
                        _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("11786") + " ");
                    }
                }
                else if (param1.q_quality_lv == PropQuality.PURPLE)
                {
                    _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("11785") + " ");
                    if (param1.q_remarkable)
                    {
                        _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("11786") + " ");
                    }
                }
                else if (param1.q_quality_lv < PropQuality.PURPLE)
                {
                    if (param1.q_remarkable)
                    {
                        _loc_5 = _loc_5 + (LanguageCfgObj.getInstance().getByIndex("11786") + " ");
                    }
                }
            }
            _loc_5 = _loc_5 + param1.q_name;
            if (param2)
            {
                if (param1 is EquipmentInfo)
                {
                    if (param1.q_quality_lv == PropQuality.GREEN)
                    {
                    }
                    else if (param1.intensify > 0)
                    {
                        _loc_5 = _loc_5 + ("  +" + param1.intensify);
                    }
                }
            }
            return _loc_5;
        }// end function

        public static function getEquipColor(param1:PropInfo) : uint
        {
            if (param1 is EquipmentInfo)
            {
                if (param1.q_kind == Params.SHOW)
                {
                    return getPropColor(param1.q_quality_lv);
                }
                if (param1.q_quality_lv == PropQuality.PURPLE_S)
                {
                    return PURPLE;
                }
                if (param1.q_quality_lv == PropQuality.PURPLE)
                {
                    if (param1.q_remarkable)
                    {
                        return GREEN;
                    }
                    if (param1.intensify >= 7)
                    {
                        return GOLD;
                    }
                    return PURPLE;
                }
                else if (param1.q_quality_lv < PropQuality.PURPLE)
                {
                    if (param1.q_remarkable)
                    {
                        return GREEN;
                    }
                    if (param1.intensify >= 7 || param1.suitId)
                    {
                        return GOLD;
                    }
                    if (param1.addAttributLevel || (param1 as EquipmentInfo).knowing_attackpercent)
                    {
                        return BLUE;
                    }
                    return getPropColor(param1.q_quality_lv);
                }
            }
            return getPropColor(param1.q_quality_lv);
        }// end function

        public static function getQualityColor(param1:PropInfo) : String
        {
            var _loc_2:* = [];
            var _loc_3:* = "";
            if (param1 is EquipmentInfo)
            {
                if (param1.q_kind == Params.SHOW)
                {
                    return getQualityColorKind(param1.q_quality_lv);
                }
                if (param1.q_quality_lv == PropQuality.PURPLE_S)
                {
                    return "purple";
                }
                if (param1.q_quality_lv == PropQuality.PURPLE)
                {
                    if (param1.q_remarkable)
                    {
                        return "green";
                    }
                    if (param1.intensify >= 7)
                    {
                        return "gold";
                    }
                    return "purple";
                }
                else if (param1.q_quality_lv < PropQuality.PURPLE)
                {
                    if (param1.q_remarkable)
                    {
                        return "green";
                    }
                    if (param1.intensify >= 7)
                    {
                        return "gold";
                    }
                    if (param1.addAttributLevel || (param1 as EquipmentInfo).knowing_attackpercent)
                    {
                        return "blue";
                    }
                    return getQualityColorKind(param1.q_quality_lv);
                }
            }
            else
            {
                return getQualityColorKind(param1.q_quality_lv);
            }
            return "";
        }// end function

        public static function isEquip(param1:int) : Boolean
        {
            if (param1 == ItemType.EQUIP || param1 == ItemType.RIDE || param1 == ItemType.RIDE_EQUIP || param1 == ItemType.PET || param1 == ItemType.WING)
            {
                return true;
            }
            return false;
        }// end function

        public static function isElementHeart(param1:int) : Boolean
        {
            return param1 == ItemType.ELEMENT_HEART;
        }// end function

        public static function jobAdapt(param1:PropInfo, param2:int) : Boolean
        {
            return param1.isUseForJob(param2);
        }// end function

        public static function getProfessionStr(param1:Number) : String
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = false;
            var _loc_9:* = false;
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_2:* = "";
            var _loc_3:* = [];
            var _loc_4:* = [];
            var _loc_5:* = param1.toString();
            if (_loc_5.length < JOB_LEN)
            {
                _loc_6 = JOB_LEN - _loc_5.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_5 = "0" + _loc_5;
                    _loc_7++;
                }
            }
            _loc_7 = 0;
            while (_loc_7 < 3)
            {
                
                _loc_8 = false;
                _loc_9 = false;
                _loc_10 = 0;
                while (_loc_10 < 4)
                {
                    
                    _loc_11 = int(_loc_5.charAt(_loc_7 + _loc_10 * 3));
                    _loc_12 = 100 + _loc_7 + _loc_10 * 3 + 1;
                    _loc_13 = JobType.getJobName(_loc_7 + _loc_10 * 3 + 1);
                    _loc_14 = JobType.getJobName(_loc_12);
                    if (_loc_11 == 1)
                    {
                        if (!_loc_8)
                        {
                            _loc_3.push(_loc_13);
                            _loc_8 = true;
                        }
                    }
                    else if (_loc_11 == 2)
                    {
                        if (!_loc_9)
                        {
                            _loc_4.push(_loc_14);
                            _loc_9 = true;
                        }
                    }
                    else if (_loc_11 == 9)
                    {
                        if (!_loc_8)
                        {
                            _loc_3.push(_loc_13);
                            _loc_8 = true;
                        }
                        if (!_loc_9)
                        {
                            _loc_4.push(_loc_14);
                            _loc_9 = true;
                        }
                    }
                    _loc_10++;
                }
                _loc_7++;
            }
            _loc_3 = _loc_3.concat(_loc_4);
            _loc_2 = _loc_2 + _loc_3[0];
            _loc_7 = 1;
            while (_loc_7 < _loc_3.length)
            {
                
                _loc_2 = _loc_2 + ("、" + _loc_3[_loc_7]);
                _loc_7++;
            }
            return _loc_2;
        }// end function

        public static function isFitForPerson(param1:int, param2:int) : Boolean
        {
            if (param1 == 0)
            {
                return true;
            }
            if (int(param1 * 0.01) % 10 == 1)
            {
                if (param2 == JobType.WARRIOR)
                {
                    return true;
                }
            }
            if (int(param1 * 0.1) % 10 == 1)
            {
                if (param2 == JobType.MAGICER)
                {
                    return true;
                }
            }
            if (int(param1) % 10 == 1)
            {
                if (param2 == JobType.BOWMAN)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function checkCanEquip(param1:PropInfo, param2:PlayerInfo) : Boolean
        {
            if (!jobAdapt(param1, param2.job))
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
            if (checkItemExpire(param1))
            {
                return false;
            }
            if (param1.q_str_limit > param2.strength)
            {
                return false;
            }
            if (param1.q_agile_limit > param2.agile)
            {
                return false;
            }
            if (param1.q_int_limit > param2.intelligence)
            {
                return false;
            }
            if (param1.q_vit_limit > param2.vitality)
            {
                return false;
            }
            return true;
        }// end function

        public static function checkItemExpire(param1:PropInfo) : Boolean
        {
            var _loc_2:* = ToolKit.getServerTime() * 0.001;
            if (param1.lostTime == 0 || param1.lostTime > _loc_2)
            {
                return false;
            }
            return true;
        }// end function

        public static function isItemExist(param1:PropInfo) : Boolean
        {
            if (param1 == null || param1.itemId == null && param1.itemId.toString() == "0")
            {
                return false;
            }
            return true;
        }// end function

        public static function createItemByJson(param1:Object) : PropInfo
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!param1)
            {
                return null;
            }
            if (param1 is String)
            {
                param1 = JSON.decode(String(param1));
            }
            var _loc_2:* = new ItemInfo();
            _loc_2.addAttributLevel = param1.addAttributLevel;
            _loc_2.attributs = param1.attributs;
            _loc_2.fightNumber = param1.fightPower;
            _loc_2.gridId = param1.gridId;
            _loc_2.intensify = param1.intensify;
            _loc_2.isFullAppend = param1.isFullAppend;
            _loc_2.isbind = param1.isbind;
            _loc_2.itemId = long.parselong(param1.itemId);
            _loc_2.itemModelId = param1.itemModelId;
            _loc_2.lostTime = param1.lostTime;
            _loc_2.num = long.fromNumber(param1.num);
            _loc_2.params = param1.type;
            _loc_2.goodAttributes = new Vector.<GoodsAttribute>;
            for each (_loc_4 in param1.goodAttributes)
            {
                
                _loc_3 = new GoodsAttribute();
                _loc_3.type = _loc_4.type;
                _loc_3.value = _loc_4.value;
                _loc_2.goodAttributes.push(_loc_3);
            }
            return createItemByItemInfo(_loc_2);
        }// end function

        public static function createJsonByItem(param1:ItemInfo) : String
        {
            return null;
        }// end function

        public static function createItemByItemInfo(param1:ItemInfo) : PropInfo
        {
            var _loc_3:* = null;
            var _loc_2:* = ItemCfgObj.getInstance().getItemCfg(param1.itemModelId);
            if (!_loc_2)
            {
                switch(param1.itemModelId)
                {
                    case SpecialItemType.COIN:
                    {
                        _loc_3 = new PropInfo();
                        _loc_3.q_name = LanguageCfgObj.getInstance().getByIndex("10116");
                        _loc_3.itemModelId = SpecialItemType.COIN;
                        _loc_3.url = Params.ITEM_PATH + "i50002.png";
                        _loc_3.num = param1.num;
                        _loc_3.itemId = param1.itemId;
                        return _loc_3;
                    }
                    case SpecialItemType.DIAMOND:
                    {
                        _loc_3 = new PropInfo();
                        _loc_3.q_name = LanguageCfgObj.getInstance().getByIndex("10117");
                        _loc_3.url = Params.ITEM_PATH + "i50003.png";
                        _loc_3.itemModelId = SpecialItemType.DIAMOND;
                        _loc_3.num = param1.num;
                        _loc_3.itemId = param1.itemId;
                        return _loc_3;
                    }
                    case SpecialItemType.EXP:
                    {
                        _loc_3 = new PropInfo();
                        _loc_3.q_name = LanguageCfgObj.getInstance().getByIndex("10118");
                        _loc_3.url = Params.ITEM_PATH + "i50001.png";
                        _loc_3.itemModelId = SpecialItemType.EXP;
                        _loc_3.num = param1.num;
                        _loc_3.itemId = param1.itemId;
                        return _loc_3;
                    }
                    case SpecialItemType.BINDDIAMOND:
                    {
                        _loc_3 = new PropInfo();
                        _loc_3.q_name = LanguageCfgObj.getInstance().getByIndex("10119");
                        _loc_3.url = Params.ITEM_PATH + "i50005.png";
                        _loc_3.itemModelId = SpecialItemType.BINDDIAMOND;
                        _loc_3.num = param1.num;
                        _loc_3.itemId = param1.itemId;
                        return _loc_3;
                    }
                    default:
                    {
                        break;
                    }
                }
                return null;
            }
            _loc_2 = ItemCfgObj.getInstance().getCfgBy(param1.itemModelId);
            if (PropUtil.isEquip(_loc_2.q_type))
            {
                _loc_3 = new EquipmentInfo();
                _loc_3.conv(param1);
            }
            else
            {
                _loc_3 = new PropInfo();
                _loc_3.conv(param1);
            }
            return _loc_3;
        }// end function

        public static function getTips(param1:PropInfo) : BaseTips
        {
            var _loc_2:* = null;
            if (param1 is EquipmentInfo)
            {
                _loc_2 = new EquipTips();
            }
            else if (param1.itemModelId > 0)
            {
                _loc_2 = new PropTips();
            }
            else
            {
                _loc_2 = new CurrencyTips();
            }
            return _loc_2;
        }// end function

        public static function createItemByCfg(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:Array = null) : PropInfo
        {
            var _loc_7:* = null;
            var _loc_6:* = ItemCfgObj.getInstance().getCfgBy(param1);
            if (!ItemCfgObj.getInstance().getCfgBy(param1))
            {
                return null;
            }
            switch(param1)
            {
                case SpecialItemType.COIN:
                {
                    _loc_7 = new PropInfo();
                    _loc_7.q_name = LanguageCfgObj.getInstance().getByIndex("10116");
                    _loc_7.itemModelId = SpecialItemType.COIN;
                    _loc_7.url = Params.ITEM_PATH + "i50002.png";
                    return _loc_7;
                }
                case SpecialItemType.DIAMOND:
                {
                    _loc_7 = new PropInfo();
                    _loc_7.q_name = LanguageCfgObj.getInstance().getByIndex("10117");
                    _loc_7.url = Params.ITEM_PATH + "i50003.png";
                    _loc_7.itemModelId = SpecialItemType.DIAMOND;
                    return _loc_7;
                }
                case SpecialItemType.EXP:
                {
                    _loc_7 = new PropInfo();
                    _loc_7.q_name = LanguageCfgObj.getInstance().getByIndex("10118");
                    _loc_7.url = Params.ITEM_PATH + "i50001.png";
                    _loc_7.itemModelId = SpecialItemType.EXP;
                    return _loc_7;
                }
                case SpecialItemType.BINDDIAMOND:
                {
                    _loc_7 = new PropInfo();
                    _loc_7.q_name = LanguageCfgObj.getInstance().getByIndex("10119");
                    _loc_7.url = Params.ITEM_PATH + "i50005.png";
                    _loc_7.itemModelId = SpecialItemType.BINDDIAMOND;
                    return _loc_7;
                }
                default:
                {
                    break;
                }
            }
            if (PropUtil.isEquip(_loc_6.q_type))
            {
                _loc_7 = new EquipmentInfo();
                (_loc_7 as EquipmentInfo).convEquipByCfg(param1, param2, param3, param4, param5);
            }
            else
            {
                _loc_7 = new PropInfo();
                _loc_7.convByCfg(param1);
            }
            return _loc_7;
        }// end function

        public static function createElementHeart(param1:EheartInfo) : ElementHeartInfo
        {
            var _loc_2:* = QEHeartCfgObj.getInstance().getItem(param1.modelId);
            _loc_2.lock = param1.lock;
            _loc_2.eheartId = param1.eheartId;
            _loc_2.exp = param1.exp;
            _loc_2.index = param1.index;
            return _loc_2;
        }// end function

        public static function createElementHeartById(param1:int) : ElementHeartInfo
        {
            var _loc_2:* = QEHeartCfgObj.getInstance().getItem(param1);
            return _loc_2;
        }// end function

        public static function getItemInfoByString(param1:String) : PropInfo
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_2 = param1.split("_");
            _loc_3 = PropUtil.createItemByCfg(_loc_2[0]);
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                setValue(_loc_3, _loc_4, _loc_2[_loc_4]);
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public static function getItemInfos(param1:String, param2:Boolean = false) : Vector.<PropInfo>
        {
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_8:* = null;
            var _loc_10:* = 0;
            var _loc_3:* = new Vector.<PropInfo>;
            var _loc_5:* = param1.split(",");
            var _loc_7:* = _loc_5.length;
            var _loc_9:* = 0;
            while (_loc_9 < _loc_7)
            {
                
                _loc_6 = _loc_5[_loc_9].replace("\"", "");
                _loc_6 = (_loc_6 as String).substr(1, _loc_6.length - 2);
                _loc_8 = _loc_6.split("_");
                _loc_4 = PropUtil.createItemByCfg(_loc_8[0]);
                if (param2)
                {
                    if (!_loc_4.isUseForJob(UserObj.getInstance().playerInfo.job))
                    {
                        ;
                    }
                }
                _loc_10 = 0;
                while (_loc_10 < _loc_8.length)
                {
                    
                    setValue(_loc_4, _loc_10, _loc_8[_loc_10]);
                    _loc_10++;
                }
                _loc_3.push(_loc_4);
                _loc_9++;
            }
            return _loc_3;
        }// end function

        private static function setValue(param1:PropInfo, param2:int, param3) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            switch(param2)
            {
                case 1:
                {
                    param1.num = param3;
                    break;
                }
                case 2:
                {
                    param1.q_effective_time = param3;
                    break;
                }
                case 3:
                {
                    param1.intensify = param3;
                    break;
                }
                case 4:
                {
                    param1.addAttributLevel = param3;
                    break;
                }
                case 5:
                {
                    _loc_4 = (param3 as String).split(";");
                    _loc_7 = 0;
                    while (_loc_7 < _loc_4.length)
                    {
                        
                        _loc_6 = _loc_4[_loc_7].split("|");
                        _loc_5 = {attributeType:_loc_6[0], attributeValue:_loc_6[1]};
                        Attributes.setEquipAttr(param1 as EquipmentInfo, _loc_5);
                        _loc_7++;
                    }
                    break;
                }
                case 6:
                {
                    (param1 as EquipmentInfo).knowing_attackpercent = param3;
                    break;
                }
                case 7:
                {
                    (param1 as EquipmentInfo).ignore_attack_percent = param3;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function isWeapon(param1:EquipmentInfo) : Boolean
        {
            if (param1.q_kind == Params.LEFT_WEAPON || param1.q_kind == Params.RIGHT_WEAPON)
            {
                return true;
            }
            return false;
        }// end function

        public static function hasAutoPickCutePet(param1:uint) : int
        {
            var _loc_2:* = null;
            if (param1 > 0)
            {
                _loc_2 = ItemCfgObj.getInstance().getCfgBy(param1);
                if (_loc_2.q_third_type == 5 || _loc_2.q_third_type == 6)
                {
                    return _loc_2.q_third_type;
                }
            }
            return 0;
        }// end function

        public static function checkJobLimitvalid(param1:Number) : Boolean
        {
            return param1 && param1 != 111111111111;
        }// end function

        public static function canUseByJob(param1:Number, param2:int) : Boolean
        {
            var _loc_3:* = false;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            if (checkJobLimitvalid(param1))
            {
                _loc_3 = false;
                _loc_4 = param1.toString();
                _loc_5 = JOB_LEN - _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_4 = "0" + _loc_4;
                    _loc_6++;
                }
                if (param2 > 100)
                {
                    param2 = param2 % 100;
                    _loc_7 = int(_loc_4.toString().charAt((param2 - 1)));
                    if (_loc_7 == 2 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                }
                else
                {
                    _loc_7 = int(_loc_4.toString().charAt((param2 - 1)));
                    if (_loc_7 == 1 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                }
            }
            else
            {
                _loc_3 = true;
            }
            return _loc_3;
        }// end function

        public static function canUseByJobKind(param1:Number, param2:int) : Boolean
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_3:* = false;
            if (checkJobLimitvalid(param1))
            {
                _loc_4 = param1.toString();
                _loc_5 = JOB_LEN - _loc_4.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_5)
                {
                    
                    _loc_4 = "0" + _loc_4;
                    _loc_6++;
                }
                if (param2 < 4)
                {
                    _loc_7 = int(_loc_4.toString().charAt((param2 - 1)));
                    if (_loc_7 == 1 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                    _loc_7 = int(_loc_4.toString().charAt(param2 + 2));
                    if (_loc_7 == 1 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                    _loc_7 = int(_loc_4.toString().charAt(param2 + 5));
                    if (_loc_7 == 1 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                }
                else
                {
                    param2 = param2 % 3;
                    _loc_7 = int(_loc_4.toString().charAt((param2 - 1)));
                    if (_loc_7 == 2 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                    _loc_7 = int(_loc_4.toString().charAt(param2 + 2));
                    if (_loc_7 == 2 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                    _loc_7 = int(_loc_4.toString().charAt(param2 + 5));
                    if (_loc_7 == 2 || _loc_7 == 9)
                    {
                        _loc_3 = true;
                    }
                }
            }
            else
            {
                _loc_3 = true;
            }
            return _loc_3;
        }// end function

        public static function isSpecial(param1:int) : Boolean
        {
            return param1 < 0;
        }// end function

        public static function isRare(param1:int) : Boolean
        {
            var _loc_2:* = createItemByCfg(param1);
            if (_loc_2.q_type == 1 && _loc_2.q_remarkable == 1)
            {
                return true;
            }
            if (RARE_ITEM_TYPE.indexOf(_loc_2.q_type) != -1)
            {
                return true;
            }
            if (_loc_2.q_lock == 1)
            {
                return true;
            }
            return false;
        }// end function

    }
}
