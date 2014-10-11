package com.game.prompt.utils
{
    import __AS3__.vec.*;
    import com.*;
    import com.adobe.serialization.json.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.artifact.control.*;
    import com.game.bank.control.*;
    import com.game.challenge.control.*;
    import com.game.chat.bean.*;
    import com.game.chat.control.*;
    import com.game.chat.model.*;
    import com.game.equipstreng.control.*;
    import com.game.goldRaffle.control.*;
    import com.game.gradegift.control.*;
    import com.game.grandMasterPanel.control.*;
    import com.game.guide.model.*;
    import com.game.magicbook.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.newactivity.firstrecharge.control.*;
    import com.game.newactivity.mayactivity.control.*;
    import com.game.newactivity.mergeService.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.moonFestival.control.*;
    import com.game.newactivity.moonFestival.model.*;
    import com.game.newactivity.popularPay.control.*;
    import com.game.newactivity.sevenactivity.control.*;
    import com.game.newactivity.singlerecharge.control.*;
    import com.game.newactivity.valent.control.*;
    import com.game.primaryrole.control.*;
    import com.game.prompt.message.*;
    import com.game.prompt.model.*;
    import com.game.role.util.*;
    import com.game.shop.control.*;
    import com.game.skill.control.*;
    import com.game.vip.control.*;
    import com.game.vipcopy.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;

    public class PromptUtil extends Object
    {
        private static var _instance:PromptUtil;

        public function PromptUtil()
        {
            return;
        }// end function

        public function transPromptVoToChatInfo(param1:PersonalNoticeMessage) : ChatInfo
        {
            return null;
        }// end function

        public function transPromptMsgToHtmlWithGood(param1:String, param2:Vector.<String>, param3:Vector.<GoodsInfoRes>, param4:int) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (param1.search("{@}") == -1)
            {
                param1 = this.transMsgToString(param1, param2);
            }
            else
            {
                _loc_5 = JSON.decode(param1);
                _loc_6 = _loc_5.ps;
                _loc_7 = new Array();
                _loc_8 = 0;
                while (_loc_8 < _loc_6.length)
                {
                    
                    _loc_9 = this.getParmFromType(_loc_6[_loc_8].type);
                    _loc_9.info = _loc_6[_loc_8];
                    _loc_10 = this.getEventStringFromParm(_loc_9, param3);
                    _loc_11 = StringHelper.getEventLinkText(_loc_10[0], _loc_10[1]);
                    _loc_7.push(_loc_11);
                    _loc_8++;
                }
                param1 = _loc_5.t;
                _loc_8 = 0;
                while (_loc_8 < _loc_7.length)
                {
                    
                    param1 = param1.replace("{@}", _loc_7[_loc_8]);
                    _loc_8++;
                }
            }
            if (param3.length > 0)
            {
                _loc_12 = "<font color = \'#00cc00\'><a href=\'event:buy|" + param3[0].ItemInfo.itemModelId + "\'><u>";
                switch(param4)
                {
                    case 47:
                    {
                        _loc_12 = _loc_12 + LanguageCfgObj.getInstance().getByIndex("11086");
                        break;
                    }
                    case 12:
                    {
                        _loc_12 = _loc_12 + LanguageCfgObj.getInstance().getByIndex("11079");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_12 = _loc_12 + "</u></a></font>";
                param1 = param1 + _loc_12;
            }
            return param1;
        }// end function

        public function transPromptMsgToHtml(param1:String, param2:Vector.<String>, param3:Vector.<GoodsInfoRes>) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (param1.search("{@}") == -1)
            {
                param1 = this.transMsgToString(param1, param2);
            }
            else
            {
                _loc_4 = JSON.decode(param1);
                _loc_5 = _loc_4.ps;
                _loc_6 = new Array();
                _loc_7 = 0;
                while (_loc_7 < _loc_5.length)
                {
                    
                    _loc_8 = this.getParmFromType(_loc_5[_loc_7].type);
                    _loc_8.info = _loc_5[_loc_7];
                    _loc_9 = this.getEventStringFromParm(_loc_8, param3);
                    _loc_10 = StringHelper.getEventLinkText(_loc_9[0], _loc_9[1]);
                    _loc_6.push(_loc_10);
                    _loc_7++;
                }
                param1 = _loc_4.t;
                _loc_7 = 0;
                while (_loc_7 < _loc_6.length)
                {
                    
                    param1 = param1.replace("{@}", _loc_6[_loc_7]);
                    _loc_7++;
                }
            }
            return param1;
        }// end function

        public function transMsgToObject(param1:String, param2:Vector.<String>, param3:Vector.<GoodsInfoRes>) : ChatSimpleVo
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_4:* = new ChatSimpleVo();
            if (param2 == null)
            {
                param2 = new Vector.<String>;
            }
            if (param3 == null)
            {
                param3 = new Vector.<GoodsInfoRes>;
            }
            if (param1.search("{@}") != -1)
            {
                _loc_7 = JSON.decode(param1);
                _loc_8 = _loc_7.ps;
                _loc_9 = new Array();
                _loc_10 = 0;
                while (_loc_10 < _loc_8.length)
                {
                    
                    _loc_11 = this.getParmFromType(_loc_8[_loc_10].type);
                    _loc_11.info = _loc_8[_loc_10];
                    _loc_12 = this.getEventStringFromParm(_loc_11, param3);
                    _loc_13 = StringHelper.getEventLinkText(_loc_12[0], _loc_12[1]);
                    _loc_9.push(_loc_13);
                    _loc_10++;
                }
                param1 = _loc_7.t;
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    param1 = param1.replace("{@}", _loc_9[_loc_10]);
                    _loc_10++;
                }
            }
            _loc_9 = [];
            var _loc_5:* = new Vector.<PropInfo>;
            param1 = this.transMsgToString(param1, param2);
            var _loc_6:* = 0;
            while (_loc_6 < param3.length)
            {
                
                _loc_14 = PropUtil.createItemByItemInfo(param3[_loc_6].ItemInfo);
                _loc_15 = PropUtil.getEquipColor(_loc_14);
                _loc_16 = PropUtil.getEquipName(_loc_14, false, false);
                _loc_9[_loc_6] = "<font color=\'#" + _loc_15.toString(16) + "\'><a href=\'event:item|" + _loc_14.itemId + "|" + _loc_14.itemModelId + "\'><u>" + _loc_16 + "</u></a></font>";
                _loc_5.push(_loc_14);
                _loc_6++;
            }
            _loc_10 = 0;
            while (_loc_10 < _loc_9.length)
            {
                
                param1 = param1.replace("{$}", _loc_9[_loc_10]);
                _loc_10++;
            }
            _loc_4.content = param1;
            _loc_4.goods = _loc_5;
            return _loc_4;
        }// end function

        public function transMsgToObjectForChat(param1:String, param2:Vector.<String>, param3:Vector.<GoodsInfoRes>) : ChatInfo
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_4:* = new Object();
            var _loc_5:* = new ChatInfo();
            if (param1.search("{@}") != -1)
            {
                _loc_7 = JSON.decode(param1);
                _loc_8 = _loc_7.ps;
                _loc_9 = new Array();
                _loc_10 = 0;
                while (_loc_10 < _loc_8.length)
                {
                    
                    _loc_11 = this.getParmFromType(_loc_8[_loc_10].type);
                    _loc_11.info = _loc_8[_loc_10];
                    _loc_12 = this.getEventStringFromParm(_loc_11, param3);
                    _loc_13 = StringHelper.getEventLinkText(_loc_12[0], _loc_12[1]);
                    _loc_9.push(_loc_13);
                    _loc_10++;
                }
                param1 = _loc_7.t;
                _loc_10 = 0;
                while (_loc_10 < _loc_9.length)
                {
                    
                    param1 = param1.replace("{@}", _loc_9[_loc_10]);
                    _loc_10++;
                }
            }
            param1 = this.transMsgToString(param1, param2);
            var _loc_6:* = [];
            if (param3)
            {
                _loc_10 = 0;
                while (_loc_10 < param3.length)
                {
                    
                    param1 = param1.replace("{$}", "\f");
                    _loc_10++;
                }
            }
            _loc_5.condition = param1;
            _loc_5.data = param3;
            _loc_5.chattype = ChatType.CHATTYPE_SYSTEM;
            _loc_5.parse();
            return _loc_5;
        }// end function

        private function getEventStringFromParm(param1:Parm, param2:Vector.<GoodsInfoRes> = null) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            switch(param1.type)
            {
                case 1:
                {
                    _loc_3 = "user|" + PlayerParm(param1).name + "|" + PlayerParm(param1).pid;
                    _loc_5 = PlayerParm(param1).name;
                    _loc_4 = "<u><font color = \'#ffde00\'>" + _loc_5 + "</font></u>";
                    break;
                }
                case 2:
                {
                    _loc_3 = "map|" + MapParm(param1).mapid + "|" + MapParm(param1).line + "|" + MapParm(param1).x + "|" + MapParm(param1).y + "|" + MapParm(param1).transType;
                    if (MapParm(param1).mapname == null || MapParm(param1).mapname == "")
                    {
                        _loc_5 = MapCfgObj.getInstance().getMap(MapParm(param1).mapid).mapName;
                    }
                    else
                    {
                        _loc_5 = MapParm(param1).mapname;
                    }
                    _loc_4 = "<u>" + _loc_5 + "</u>";
                    break;
                }
                case 3:
                {
                    _loc_3 = "goto|" + VipParm(param1).vipLv + "|" + VipParm(param1).idx;
                    if (param2 && param2.length > 0)
                    {
                        _loc_3 = _loc_3 + ("|" + param2[0].ItemInfo.itemModelId);
                    }
                    _loc_5 = this.getPanelName(VipParm(param1).idx);
                    _loc_5 = _loc_5.length <= 0 ? ("VIP") : (_loc_5);
                    _loc_4 = "<u><font color = \'#00ff00\'>" + _loc_5 + "</font></u>";
                    break;
                }
                case 4:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return [_loc_4, _loc_3];
        }// end function

        private function getParmFromType(param1:int) : Parm
        {
            var _loc_2:* = null;
            switch(param1)
            {
                case 1:
                {
                    _loc_2 = new PlayerParm();
                    break;
                }
                case 2:
                {
                    _loc_2 = new MapParm();
                    break;
                }
                case 3:
                {
                    _loc_2 = new VipParm();
                    break;
                }
                case 4:
                {
                    _loc_2 = new WebParm();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function transMsgToString(param1:String, param2:Vector.<String>) : String
        {
            var _loc_3:* = param1;
            var _loc_4:* = param2.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = _loc_3.replace("{" + (_loc_5 + 1) + "}", param2[_loc_5]);
                _loc_5++;
            }
            return _loc_3;
        }// end function

        public function transPromptVoToHtml(param1:PromptVo, param2:Vector.<String>) : String
        {
            var _loc_3:* = null;
            if (param1)
            {
                _loc_3 = param1.system_message;
                return _loc_3;
            }
            return "";
        }// end function

        public function getPanelName(param1:int) : String
        {
            var _loc_2:* = "";
            switch(param1)
            {
                case 3:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11073");
                    break;
                }
                case 7:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11074");
                    break;
                }
                case 8:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11075");
                    break;
                }
                case 9:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11076");
                    break;
                }
                case 10:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11077");
                    break;
                }
                case 11:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11078");
                    break;
                }
                case 12:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11079");
                    break;
                }
                case 41:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11080");
                    break;
                }
                case 42:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11081");
                    break;
                }
                case 43:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11082");
                    break;
                }
                case 44:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11083");
                    break;
                }
                case 45:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11084");
                    break;
                }
                case 46:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11085");
                    break;
                }
                case 47:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11086");
                    break;
                }
                case 48:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11087");
                    break;
                }
                case 49:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("11084");
                    break;
                }
                case 50:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12172");
                    break;
                }
                case 51:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12358");
                    break;
                }
                case 55:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12358");
                    break;
                }
                case 56:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("PromptUtil_1406365170");
                    break;
                }
                case 58:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10018", MagicBookControl.MAGICBOOK_LANG);
                    break;
                }
                case 60:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12459");
                    break;
                }
                case 65:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("12460");
                    break;
                }
                case 66:
                {
                    _loc_2 = LanguageCfgObj.getInstance().getByIndex("10009", MoonDiceModel.LANG_VER);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public function openOtherPanel(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case 3:
                {
                    PrimaryRoleControl.getInstance().openHorse();
                    break;
                }
                case 7:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(1);
                    break;
                }
                case 8:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(2);
                    break;
                }
                case 9:
                {
                    EquipComposeControl.getInstance().openEquipComposeBox();
                    break;
                }
                case 10:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case 11:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case 12:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case 13:
                {
                    ChatController.getInstance().openHorn();
                    break;
                }
                case 14:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 16:
                {
                    SkillControl.getInstance().openToTabSkill(2);
                    break;
                }
                case 17:
                {
                    SevenActivityControl.getInstance().openOrClose();
                    break;
                }
                case 19:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(3);
                    break;
                }
                case 21:
                {
                    if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().SUIT_OPT_TEAM)) == 0)
                    {
                        Global.popManager.addedToMouseCue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12437"), TaskCfgObj.getInstance().getOpenLevelByTeam(GuideConfigObj.getInstance().SUIT_OPT_TEAM)));
                    }
                    else
                    {
                        EquipForgeControl.getInstance().openEquipForgeBox(4);
                    }
                    break;
                }
                case 22:
                {
                    if (GuideConfigObj.getInstance().getGuideConfig(int(GuideConfigObj.getInstance().SUIT_OPT_TEAM)) == 0)
                    {
                        Global.popManager.addedToMouseCue(StringUtil.formatString(LanguageCfgObj.getInstance().getByIndex("12438"), TaskCfgObj.getInstance().getOpenLevelByTeam(GuideConfigObj.getInstance().SUIT_OPT_TEAM)));
                    }
                    else
                    {
                        EquipForgeControl.getInstance().openEquipForgeBox(5);
                    }
                    break;
                }
                case 41:
                {
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case 42:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 43:
                {
                    ArtifactControl.getInstance().openArtifactPanel();
                    break;
                }
                case 44:
                {
                    FirstRechargeControl.getInstance().openOrClose();
                    break;
                }
                case 45:
                {
                    SingleRechargeControl.getInstance().openOrClose();
                    break;
                }
                case 46:
                {
                    BankControl.getInstance().openBankBox();
                    break;
                }
                case 48:
                {
                    GradeGiftControl.getInstance().openOrCloseGradeGiftPanel();
                    break;
                }
                case 49:
                {
                    MayControl.getInstance().openOrClose(1);
                    break;
                }
                case 50:
                {
                    MayControl.getInstance().openOrClose(3);
                    break;
                }
                case 51:
                {
                    MayControl.getInstance().openOrClose(1);
                    break;
                }
                case 52:
                {
                    VipCopyControl.getInstance().openVipCopyBox();
                    break;
                }
                case 53:
                {
                    ArtifactControl.getInstance().openArtifactAndExtractPanel();
                    break;
                }
                case 54:
                {
                    ZonesControl.getInstance().openBossHome();
                    break;
                }
                case 55:
                {
                    ValentControl.getInstance().openValentPanel();
                    break;
                }
                case 56:
                {
                    if (NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_BIGPACK_TITLE))
                    {
                        MergeServiceControl.instance.openOrClose(TopActivateName.MERGE_SERVICE, 2);
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("PromptUtil_1406632862"));
                    }
                    break;
                }
                case 57:
                {
                    PrimaryRoleControl.getInstance().openMagicBook();
                    break;
                }
                case 58:
                {
                    break;
                }
                case 66:
                {
                    MoonFestivalControl.getInstance().openOrClose();
                    break;
                }
                case 70:
                {
                    if (RoleLevelUtil.isMasterLevel(UserObj.getInstance().playerInfo.level))
                    {
                        MasterSkillControl.instance.openOrCloseSkillPanel();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("PromptUtil_1409561667"));
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

        public function openPanelWithParams(... args) : void
        {
            args = null;
            switch(int(args[2]))
            {
                case 12:
                case 47:
                {
                    if (args[3])
                    {
                        args = ShopCfgObj.getInstance().getShopItemInfoFromInside(args[3]);
                        ShopController.getInstance().openBuyItem(args);
                    }
                    else
                    {
                        throw new Error(args[3]);
                    }
                    break;
                }
                case 1:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case 3:
                {
                    PrimaryRoleControl.getInstance().openHorse();
                    break;
                }
                case 7:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(1);
                    break;
                }
                case 8:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(2);
                    break;
                }
                case 9:
                {
                    EquipComposeControl.getInstance().openEquipComposeBox();
                    break;
                }
                case 10:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case 11:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case 12:
                {
                    VIPControl.getInstance().openOrCloseVip();
                    break;
                }
                case 13:
                {
                    ChatController.getInstance().openHorn();
                    break;
                }
                case 14:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 16:
                {
                    SkillControl.getInstance().openToTabSkill(2);
                    break;
                }
                case 17:
                {
                    SevenActivityControl.getInstance().openOrClose();
                    break;
                }
                case 19:
                {
                    EquipForgeControl.getInstance().openEquipForgeBox(3);
                    break;
                }
                case 41:
                {
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case 42:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                case 43:
                {
                    ArtifactControl.getInstance().openArtifactPanel();
                    break;
                }
                case 44:
                {
                    FirstRechargeControl.getInstance().openOrClose();
                    break;
                }
                case 45:
                {
                    SingleRechargeControl.getInstance().openOrClose();
                    break;
                }
                case 46:
                {
                    BankControl.getInstance().openBankBox();
                    break;
                }
                case 48:
                {
                    GradeGiftControl.getInstance().openOrCloseGradeGiftPanel();
                    break;
                }
                case 49:
                {
                    MayControl.getInstance().openOrClose(1);
                    break;
                }
                case 50:
                {
                    MayControl.getInstance().openOrClose(3);
                    break;
                }
                case 51:
                {
                    MayControl.getInstance().openOrClose(1);
                    break;
                }
                case 55:
                {
                    ValentControl.getInstance().openValentPanel();
                    break;
                }
                case 57:
                {
                    if (UserObj.getInstance().playerInfo.magicBook)
                    {
                        PrimaryRoleControl.getInstance().openMagicBook();
                    }
                    else
                    {
                        MagicBookControl.getIntance().openOrCloseGainMagicBoookPanel();
                    }
                }
                case 60:
                {
                    MoonFestivalControl.getInstance().openOrClose(3);
                    break;
                }
                case 65:
                {
                    PopularPayControl.getInstance().openPanel();
                    break;
                }
                case 66:
                {
                    MoonFestivalControl.getInstance().openOrClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getInstance() : PromptUtil
        {
            if (!_instance)
            {
                _instance = new PromptUtil;
            }
            return _instance;
        }// end function

    }
}
