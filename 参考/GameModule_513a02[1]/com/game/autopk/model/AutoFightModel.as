package com.game.autopk.model
{
    import __AS3__.vec.*;
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.game.autopk.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.event.*;
    import com.game.autopk.protocol.*;
    import flash.events.*;

    public class AutoFightModel extends EventDispatcher
    {
        public static var hp:int = 60;
        public static var autohp:Boolean = true;
        public static var mp:int = 30;
        public static var automp:Boolean = true;
        public static var autoArtifact:Boolean = false;
        public static var fightType:int;
        public static var fightRange:int = 20;
        public static var fightRangeType:int = 1;
        public static var autoPick:Boolean = true;
        public static var pickType:uint;
        public static var fightSkill:int;
        public static var fightSell:int;
        public static var autoBuyBlood:Boolean = true;
        public static var autoBuyBloodType:int;
        public static var autoBuyMagic:Boolean = true;
        public static var autoBuyMagicType:int;
        public static var autoBorn:Boolean = false;
        public static var autoBack:Boolean = false;
        public static var skillIdList:Vector.<int>;
        public static var sellLimit1:Boolean;
        public static var sellLimit2:Boolean;
        public static var sellLimit3:Boolean;
        public static var sellLimit5:Boolean;
        public static var sellLimit6:Boolean;
        public static var sellLimit8:Boolean;
        public static var sellRank1:int;
        public static var sellRank2:int;
        public static var forcePick:Boolean;
        public static var mounsterType:Vector.<int>;

        public function AutoFightModel()
        {
            return;
        }// end function

        public function setPickItemList(param1:uint) : Array
        {
            var _loc_5:* = 0;
            var _loc_2:* = new Array(6);
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = 2 << _loc_4;
                if ((param1 & _loc_5) == _loc_5)
                {
                    _loc_2[_loc_4] = 1;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function toString() : String
        {
            var _loc_1:* = {};
            _loc_1.hp = hp;
            _loc_1.mp = mp;
            _loc_1.autohp = autohp;
            _loc_1.automp = automp;
            _loc_1.autoArtifact = autoArtifact;
            _loc_1.fightType = fightType;
            _loc_1.autoPick = autoPick;
            _loc_1.pickType = pickType;
            _loc_1.fightSkill = fightSkill;
            _loc_1.fightSell = fightSell;
            _loc_1.fightRange = fightRange;
            _loc_1.autoBuyBlood = autoBuyBlood;
            _loc_1.autoBuyBloodType = autoBuyBloodType;
            _loc_1.autoBuyMagic = autoBuyMagic;
            _loc_1.autoBuyMagicType = autoBuyMagicType;
            _loc_1.autoBorn = autoBorn;
            _loc_1.autoBack = autoBack;
            _loc_1.skillIdList = skillIdList ? (skillIdList.join(",")) : ("");
            _loc_1.sellLimit1 = sellLimit1;
            _loc_1.sellLimit2 = sellLimit2;
            _loc_1.sellLimit3 = sellLimit3;
            _loc_1.sellLimit5 = sellLimit5;
            _loc_1.sellLimit6 = sellLimit6;
            _loc_1.sellLimit8 = sellLimit8;
            _loc_1.sellRank1 = sellRank1;
            _loc_1.sellRank2 = sellRank2;
            return JSON.encode(_loc_1);
        }// end function

        public static function parse(param1:String) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (param1 == "")
            {
                setDefaultValue();
            }
            else
            {
                _loc_2 = JSON.decode(param1);
                hp = _loc_2.hp;
                mp = _loc_2.mp;
                autohp = _loc_2.autohp;
                automp = _loc_2.automp;
                autoArtifact = _loc_2.autoArtifact;
                fightType = _loc_2.fightType;
                autoPick = _loc_2.autoPick;
                pickType = _loc_2.pickType;
                fightSkill = _loc_2.fightSkill;
                fightSell = _loc_2.fightSell;
                fightRange = _loc_2.fightRange;
                autoBuyBlood = _loc_2.autoBuyBlood;
                autoBuyBloodType = _loc_2.autoBuyBloodType;
                autoBuyMagic = _loc_2.autoBuyMagic;
                autoBuyMagicType = _loc_2.autoBuyMagicType;
                autoBorn = _loc_2.autoBorn;
                autoBack = _loc_2.autoBack;
                skillIdList = new Vector.<int>;
                if (String(_loc_2.skillIdList) != "")
                {
                    _loc_3 = String(_loc_2.skillIdList).split(",");
                    _loc_4 = 0;
                    while (_loc_4 < _loc_3.length)
                    {
                        
                        _loc_5 = int(_loc_3[_loc_4]);
                        skillIdList[_loc_4] = _loc_5;
                        _loc_4++;
                    }
                }
                sellLimit1 = _loc_2.sellLimit1;
                sellLimit2 = _loc_2.sellLimit2;
                sellLimit3 = _loc_2.sellLimit3;
                sellLimit5 = _loc_2.sellLimit5;
                sellLimit6 = _loc_2.sellLimit6;
                sellLimit8 = _loc_2.sellLimit8;
                sellRank1 = _loc_2.sellRank1;
                sellRank2 = _loc_2.sellRank2;
            }
            AutoFightController.getInstance().update();
            FrameworkGlobal.sendMsg(new AutoFightEvent(AutoFightEvent.AUTO_FIGHT_CONFIG_UPDATE));
            return;
        }// end function

        public static function setDefaultValue() : void
        {
            hp = 60;
            mp = 30;
            autohp = true;
            automp = true;
            autoArtifact = false;
            fightType = 1;
            autoPick = true;
            pickType = 510;
            fightSkill = 1;
            fightSell = 1;
            fightRange = 20;
            autoBuyBlood = true;
            autoBuyBloodType = 0;
            autoBuyMagic = true;
            autoBuyMagicType = 0;
            autoBorn = false;
            autoBack = false;
            skillIdList = new Vector.<int>;
            sellLimit1 = false;
            sellLimit2 = false;
            sellLimit3 = false;
            sellLimit5 = false;
            sellLimit6 = false;
            sellLimit8 = true;
            sellRank1 = 0;
            sellRank2 = 0;
            return;
        }// end function

        public static function save() : void
        {
            AutoFightProtocol.getInstance().reqSaveAssistantMessage(toString());
            AutoFightManager.getInstance().fightLogic.reset();
            FrameworkGlobal.sendMsg(new AutoFightEvent(AutoFightEvent.AUTO_FIGHT_CONFIG_UPDATE));
            return;
        }// end function

    }
}
