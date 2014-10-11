package com.cfg.obj
{
    import com.f1.manager.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class GlobalCfgObj extends Object
    {
        private var _map:Object;
        private var vipTex:Number = 0;
        private var tex:Number = 0;
        public static var URL_GOLD:String;
        public static var URL_FCM:String;
        public static var URL_OFFICIAL_WEBSITE:String;
        public static var URL_NAME:String;
        private static var instance:GlobalCfgObj;

        public function GlobalCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_global");
            GlobalCfgObj.URL_GOLD = this._map["88"].q_string_value;
            GlobalCfgObj.URL_FCM = this._map["87"].q_string_value;
            GlobalCfgObj.URL_OFFICIAL_WEBSITE = this._map["85"].q_string_value;
            GlobalCfgObj.URL_NAME = this._map["86"].q_string_value;
            Params.PLAYER_RUN_ACT_DEFAULT_TIME = uint(this._map["102"].q_int_value);
            Params.MONSTER_RUN_ACT_DEFAULT_TIME = uint(this._map["103"].q_int_value);
            Params.EXP_VIP_GUIDE_TASK = String(this._map["174"].q_string_value).split(";");
            return;
        }// end function

        public function getCfgById(param1:Object) : Object
        {
            return this._map[param1];
        }// end function

        public function getDieLevel() : Number
        {
            return this._map["32"].q_int_value;
        }// end function

        public function getVipTex() : Number
        {
            if (this.vipTex == 0)
            {
                this.vipTex = this._map["75"].q_int_value * 0.01;
            }
            return Math.round(this.vipTex);
        }// end function

        public function getTex() : Number
        {
            if (this.tex == 0)
            {
                this.tex = this._map["74"].q_int_value * 0.01;
            }
            return this.tex;
        }// end function

        public function getSelfShop() : int
        {
            return this._map["76"].q_int_value;
        }// end function

        public function getDiamondShop() : int
        {
            return this._map["77"].q_int_value;
        }// end function

        public function getBindDiamondShop() : int
        {
            return this._map["78"].q_int_value;
        }// end function

        public function getVipShop() : int
        {
            return this._map["79"].q_int_value;
        }// end function

        public function getStallOpenUpLevel() : int
        {
            return this._map["20"].q_int_value;
        }// end function

        public function getPKlowestLevel() : int
        {
            return this._map["89"].q_int_value;
        }// end function

        public function getChatWarningLevel() : int
        {
            if (this._map.hasOwnProperty("252"))
            {
                return this._map["252"].q_int_value;
            }
            return 120;
        }// end function

        public function getAttackDifLevel() : int
        {
            return this._map["90"].q_int_value;
        }// end function

        public function getFightChangeValue() : int
        {
            if (this._map["204"])
            {
                return this._map["204"].q_int_value;
            }
            return 0;
        }// end function

        public function getHorseCultureCost() : int
        {
            return this._map["100"].q_int_value;
        }// end function

        public function getHorseTransGoldToExp() : int
        {
            return this._map["101"].q_int_value;
        }// end function

        public function getHorseToolsCost(param1:int) : int
        {
            var _loc_2:* = 0;
            switch(param1)
            {
                case HorseCfgObj.HORSE_UP_TOOLS_1:
                {
                    _loc_2 = this._map["201"].q_int_value;
                    break;
                }
                case HorseCfgObj.HORSE_UP_TOOLS_2:
                {
                    _loc_2 = this._map["202"].q_int_value;
                    break;
                }
                case HorseCfgObj.HORSE_UP_TOOLS_3:
                {
                    _loc_2 = this._map["203"].q_int_value;
                    break;
                }
                case HorseCfgObj.HORSE_UP_TOOLS_4:
                {
                    _loc_2 = this._map["210"].q_int_value;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function getCostOnekeyCasting() : int
        {
            return this._map["205"].q_int_value;
        }// end function

        public function getPlatbuffId() : int
        {
            return this._map["207"].q_int_value;
        }// end function

        public function getWeiDuanUrl() : String
        {
            return this._map["211"].q_string_value;
        }// end function

        public function getPkRedBuff() : int
        {
            return this._map["212"].q_int_value;
        }// end function

        public function getRemark() : String
        {
            return this._map["213"].q_string_value;
        }// end function

        public function getArtifactGoldExtractCostGold() : String
        {
            return this._map["220"].q_string_value;
        }// end function

        public function getArtifactHelp() : String
        {
            return this._map["222"].q_string_value;
        }// end function

        public function getMousterLevel1() : int
        {
            return this._map["224"].q_int_value;
        }// end function

        public function getMousterLevel2() : int
        {
            return this._map["225"].q_int_value;
        }// end function

        public function getMousterLevel3() : int
        {
            return this._map["226"].q_int_value;
        }// end function

        public function getMousterLevel4() : int
        {
            return this._map["227"].q_int_value;
        }// end function

        public function getNotDropLevel() : int
        {
            return this._map["224"].q_int_value;
        }// end function

        public function getPreciousItemMinIntensify() : int
        {
            return this._map["231"].q_int_value;
        }// end function

        public function getPreciousItemMinAddAttributLevel() : int
        {
            return this._map["232"].q_int_value;
        }// end function

        public function getWorldLevelBuff() : int
        {
            return this._map["234"].q_int_value;
        }// end function

        public function getWorldLevelEnablePlayerLevel() : int
        {
            return this._map["235"].q_int_value;
        }// end function

        public function getSupervipAwardItemModelId() : int
        {
            return this._map["237"].q_int_value;
        }// end function

        public function getSupervipAwardTitleId() : int
        {
            return this._map["238"].q_int_value;
        }// end function

        public function getWorldLevelEnableMinPlayerLevelDif() : int
        {
            return this._map["239"].q_int_value;
        }// end function

        public function getStoreOpenNPC() : int
        {
            return this._map["240"].q_int_value;
        }// end function

        public function getProtectEnablePlayerLevel() : int
        {
            return this._map["244"].q_int_value;
        }// end function

        public function getSuitOpenLevel() : int
        {
            var _loc_1:* = this._map["236"];
            return _loc_1 ? (_loc_1.q_int_value) : (0);
        }// end function

        public function getMayOneGeftAward() : String
        {
            return this._map["246"].q_string_value;
        }// end function

        public function getMayFireCrackersGoods() : String
        {
            return this._map["247"].q_string_value;
        }// end function

        public function getBossVipLevel() : int
        {
            var _loc_1:* = this._map["251"];
            return _loc_1 ? (_loc_1.q_int_value) : (2);
        }// end function

        public function getGift360Website() : String
        {
            return this._map["257"].q_string_value;
        }// end function

        public function getGiftBaiduOpenVipWebsite() : String
        {
            return this._map["258"].q_string_value;
        }// end function

        public function getGiftBaiduRuleWebsite() : String
        {
            return this._map["259"].q_string_value;
        }// end function

        public function getGiftDuowanOpenVipWebsite() : String
        {
            return this._map["260"].q_string_value;
        }// end function

        public function getGiftDuowanRuleWebsite() : String
        {
            return this._map["261"].q_string_value;
        }// end function

        public function getGift37OpenVipWebsite() : String
        {
            return this._map["263"].q_string_value;
        }// end function

        public function getGift37RuleWebsite() : String
        {
            return this._map["264"].q_string_value;
        }// end function

        public function getSkillComboDelayHide() : int
        {
            return this._map["266"].q_int_value;
        }// end function

        public function getGiftXunleiRulesite() : String
        {
            return this._map["272"].q_string_value;
        }// end function

        public function getGiftXunleiWebsite() : String
        {
            return this._map["271"].q_string_value;
        }// end function

        public function getChangeLineCd() : int
        {
            return this._map["265"].q_int_value;
        }// end function

        public function getBossHomeKey() : String
        {
            return this._map["267"].q_string_value;
        }// end function

        public function getOpenFacebookShareTaskId() : int
        {
            return this._map["269"].q_int_value;
        }// end function

        public function getCompleteInfoRewards() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = new Array();
            var _loc_2:* = this._map["270"].q_string_value;
            if (_loc_2)
            {
                _loc_4 = _loc_2.split(";");
                _loc_5 = _loc_4.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_5)
                {
                    
                    _loc_6 = _loc_4[_loc_7].split("_");
                    _loc_3 = PropUtil.createItemByCfg(int(_loc_6[0]));
                    if ((_loc_6[0] as String).search("!") != -1)
                    {
                        _loc_3.isbind = 0;
                    }
                    else
                    {
                        _loc_3.isbind = 1;
                    }
                    _loc_3.num = _loc_6[1];
                    _loc_1.push(_loc_3);
                    _loc_7++;
                }
            }
            return _loc_1;
        }// end function

        public function getElementLimit() : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_1:* = new Array();
            var _loc_2:* = this._map["275"].q_string_value;
            if (_loc_2)
            {
                _loc_3 = _loc_2.split(";");
                _loc_4 = _loc_3.length;
                _loc_6 = 0;
                _loc_8 = 0;
                while (_loc_8 < _loc_4)
                {
                    
                    _loc_5 = _loc_3[_loc_8].split("_");
                    _loc_7 = _loc_5[0] - _loc_6;
                    _loc_9 = 0;
                    while (_loc_9 < _loc_7)
                    {
                        
                        _loc_6++;
                        _loc_1.push(_loc_5[1]);
                        _loc_9++;
                    }
                    _loc_8++;
                }
            }
            return _loc_1;
        }// end function

        public function getGift360LeadingRowActivityWebsite() : String
        {
            return this._map["274"].q_string_value;
        }// end function

        public function getElementHelpTips() : String
        {
            return this._map["277"].q_string_value;
        }// end function

        public static function getInstance() : GlobalCfgObj
        {
            if (instance == null)
            {
                instance = new GlobalCfgObj;
            }
            return instance;
        }// end function

    }
}
