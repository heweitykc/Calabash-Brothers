package com.game.map.view.topbtnspanel
{
    import com.*;
    import com.cfg.obj.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.bank.control.*;
    import com.game.card.control.*;
    import com.game.card.model.*;
    import com.game.challenge.control.*;
    import com.game.cloudbuy.control.*;
    import com.game.country.control.*;
    import com.game.desktop.control.*;
    import com.game.facebook.control.*;
    import com.game.gradegift.control.*;
    import com.game.greedisland.control.*;
    import com.game.magicbook.control.*;
    import com.game.map.control.*;
    import com.game.newactivity.firstrecharge.control.*;
    import com.game.newactivity.ftmidaut.control.*;
    import com.game.newactivity.gift360.control.*;
    import com.game.newactivity.gift360home.control.*;
    import com.game.newactivity.gift360home.view.*;
    import com.game.newactivity.gift37.control.*;
    import com.game.newactivity.giftBaidu.control.*;
    import com.game.newactivity.giftDuowan.control.*;
    import com.game.newactivity.giftLiebao.control.*;
    import com.game.newactivity.giftLiebao.view.*;
    import com.game.newactivity.giftXunlei.control.*;
    import com.game.newactivity.mayactivity.control.*;
    import com.game.newactivity.mergeService.control.*;
    import com.game.newactivity.moonFestival.control.*;
    import com.game.newactivity.nothink.control.*;
    import com.game.newactivity.nothink.view.*;
    import com.game.newactivity.personalInfo.view.*;
    import com.game.newactivity.popularPay.control.*;
    import com.game.newactivity.rechargedays.control.*;
    import com.game.newactivity.sevenactivity.control.*;
    import com.game.newactivity.singlerecharge.control.*;
    import com.game.newactivity.valent.control.*;
    import com.game.offline.control.*;
    import com.game.onlineactivity.control.*;
    import com.game.perfectInfo.control.*;
    import com.game.player.control.*;
    import com.game.redfortress.control.*;
    import com.game.signwage.control.*;
    import com.game.supervip.control.*;
    import com.game.task.control.*;
    import com.game.vipcopy.control.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class TopActivatePanel extends Component
    {
        private var _vecIcon1:Array;
        private var _vecIcon2:Array;
        private var _waitList:Array;
        private var _waitDelList:Array;
        private var _dic:Dictionary;
        private var _hasClick:Dictionary;
        private var _isShowMoveEffect:Boolean;
        private var _effectBtn:TopActivateIcon;
        private var _moveArr:Array;
        private var endX:int;
        private var endY:int;
        private var btnIcon_360:TopActivateIcon;

        public function TopActivatePanel(param1 = null, param2:String = null)
        {
            this._dic = new Dictionary();
            this._hasClick = new Dictionary();
            super(param1, param2);
            this.initPanel();
            this.initIcon();
            this.addEvents();
            return;
        }// end function

        private function initPanel() : void
        {
            this._vecIcon1 = [];
            this._vecIcon2 = [];
            this._waitList = [];
            this._waitDelList = [];
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            if (PlayerConfig.getInstance().getValue(PlayerConfig.PHONE_VERIFY_CLICK) == 0)
            {
                CardControl.getInstance().reqCardPhone(Params.username, UserObj.getInstance().playerInfo.personId, "-1");
            }
            BankControl.getInstance().reqQueryBank(0);
            BankControl.getInstance().reqQueryBank(1);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target is TopActivateIcon)
            {
                _loc_2 = event.target as TopActivateIcon;
                this.clickTopIcon(_loc_2);
            }
            return;
        }// end function

        private function clickTopIcon(param1:TopActivateIcon) : void
        {
            switch(param1.nameTop)
            {
                case TopActivateName.TOP_ICON_BELIAL_WORLD:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case TopActivateName.TOP_ICON_BOSS_HOME:
                {
                    ZonesControl.getInstance().openBossHome();
                    break;
                }
                case TopActivateName.TOP_ICON_COUNTRY:
                {
                    CountryControl.getInstance().openCountryBox();
                    break;
                }
                case TopActivateName.TOP_ICON_DEKARON:
                {
                    ZonesControl.getInstance().openZonesDekaron();
                    break;
                }
                case TopActivateName.TOP_ICON_REWARDS_THOLD:
                {
                    SignWageControl.getInstance().openOrcloseSignWageBox();
                    break;
                }
                case TopActivateName.TOP_ICON_LINK_TO_DESKTOP:
                {
                    if (WeiDuanType.NO_WEIDUAN == Params.wdType)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("12106"));
                    }
                    else
                    {
                        DesktopControl.getInsatnce().saveLinkToDeskTop();
                    }
                    break;
                }
                case TopActivateName.TOP_ICON_SCARLET_HOLD:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case TopActivateName.TOP_ICON_RETURN_EXP:
                {
                    OfflineControl.instance.openOrCloseOfflinePanel();
                    break;
                }
                case TopActivateName.TOP_ICON_CARD_PHONE:
                {
                    if (Params.pvType == PhoneVerifyType.GO_PANEL)
                    {
                        CardControl.getInstance().openCardBox();
                    }
                    else if (Params.pvType == PhoneVerifyType.GO_PAGE)
                    {
                        if (Params.pvPage == "")
                        {
                            Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("12107"));
                        }
                        else
                        {
                            JSTools.openWindow("http://" + Params.pvPage);
                            PlayerControl.getInstance().saveConfig(1, PlayerConfig.PHONE_VERIFY_CLICK);
                            CardData.getInstance().state = 2;
                            MapControl.getInstance().showOrHideCardPhone(false);
                        }
                    }
                    break;
                }
                case TopActivateName.TOP_ICON_CHANGE_JOB:
                {
                    ChangeJobControl.getInstance().openChangeJobBox();
                    break;
                }
                case TopActivateName.TOP_ICON_GOLD_RAFFLE:
                {
                    break;
                }
                case TopActivateName.TOP_ICON_BANK:
                {
                    param1.setEffect(false, TopActivateIcon.EFFECT_FIRST_CLICK);
                    BankControl.getInstance().openBankBox();
                    break;
                }
                case TopActivateName.TOP_ICON_BOSS_GUILD:
                {
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_DAILY_TASK:
                {
                    TaskControl.getInstance().openOrClose(1);
                    break;
                }
                case TopActivateName.TOP_ICON_ZHU_ZAO:
                {
                    break;
                }
                case TopActivateName.TOP_ICON_RED_FORTRESS:
                {
                    ZonesRedFortressControl.getInstance().openOrCloseRedFortressPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_LEVEL_GIFT:
                {
                    GradeGiftControl.getInstance().openOrCloseGradeGiftPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_FIRST_RECHARGE:
                {
                    param1.setEffect(false, TopActivateIcon.EFFECT_FIRST_CLICK);
                    FirstRechargeControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.TOP_ICON_SINGLE_RECHARGE:
                {
                    param1.setEffect(false, TopActivateIcon.EFFECT_FIRST_CLICK);
                    SingleRechargeControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.TOP_ICON_SEVEN_DAY:
                {
                    SevenActivityControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.TOP_ICON_VIP_COPY:
                {
                    VipCopyControl.getInstance().openVipCopyBox();
                    break;
                }
                case TopActivateName.TOP_ICON_ONLINE:
                {
                    OnlineActivityControl.getInstance().openOnlineActivityBox();
                    break;
                }
                case TopActivateName.TOP_ICON_WOLF_SOUL:
                {
                    ZonesControl.getInstance().openZonesWolfSoul();
                    break;
                }
                case TopActivateName.SUPERVIP:
                {
                    SupervipControl.getInstance().openOrCloseSupervipPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_CLOUD_BUY:
                {
                    CloudBuyControl.getInstance().openCloudBuyBox();
                    break;
                }
                case TopActivateName.TOP_ICON_MAY_ACTIVITY:
                {
                    MayControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_360:
                {
                    param1.setEffect(false, TopActivateIcon.EFFECT_NORMAL);
                    Gift360Control.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_XUNLEI:
                {
                    param1.setEffect(false, TopActivateIcon.EFFECT_NORMAL);
                    GiftXunleiControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_DUOWAN:
                {
                    GiftDuowanControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_37:
                {
                    Gift37Control.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_BAIDU:
                {
                    GiftBaiduControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.GIFT_LIEBAO:
                {
                    GiftLiebaoControl.getInstance().gainGift();
                    break;
                }
                case TopActivateName.TOP_ICON_ISLAND:
                {
                    IslandControl.getInstance().openIslandBox();
                    break;
                }
                case TopActivateName.GIFT_360HOME:
                {
                    Gift360HomeControl.getInstance().gainGift();
                    break;
                }
                case TopActivateName.GIFT_NOTHINK:
                {
                    GiftNothinkControl.getInstance().gainGift();
                    break;
                }
                case TopActivateName.MERGE_SERVICE:
                {
                    MergeServiceControl.instance.openOrClose(TopActivateName.MERGE_SERVICE, -1);
                    break;
                }
                case TopActivateName.PREV_MERGE:
                {
                    MergeServiceControl.instance.openOrClose(TopActivateName.PREV_MERGE, 0);
                    break;
                }
                case TopActivateName.RECHARGE_DAYS:
                {
                    RechargetDaysControl.getInstance().openOrCloseRechargeDays();
                    break;
                }
                case TopActivateName.FACEBOOK_INVITE:
                {
                    FacebookControl.getInstance().openOrCloseInvitePanel();
                    break;
                }
                case TopActivateName.FACEBOOK_SHARE:
                {
                    FacebookControl.getInstance().openOrCloseSharePanel();
                    break;
                }
                case TopActivateName.TOP_ICON_ACTIVE_VALENT:
                {
                    ValentControl.getInstance().openValentPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_PERSONAL_INFORMATION:
                {
                    if (Params.isadult == AdultType.WEB_COMPLETE)
                    {
                        Log.log("完善信息:" + Params.adulturl);
                        if (Params.adulturl)
                        {
                            ToolKit.gotoWeb(Params.adulturl);
                        }
                    }
                    else
                    {
                        PerfectInfoControl.getInstance().openOrColsePerfectPanel();
                    }
                    break;
                }
                case TopActivateName.TOP_ICON_MAGIC_BOOK:
                {
                    param1.setEffect(true, TopActivateIcon.EFFECT_FIRST_CLICK);
                    MagicBookControl.getIntance().openOrCloseGainMagicBoookPanel();
                    break;
                }
                case TopActivateName.TOP_ICON_MID_AUTUMN:
                {
                    FtMidAutControl.getInstance().openOrClose();
                    break;
                }
                case TopActivateName.TOP_ICON_MOOD_FEASTIVAL:
                {
                    MoonFestivalControl.getInstance().openOrClose(1);
                    break;
                }
                case TopActivateName.TOP_ICON_POPULAR:
                {
                    PopularPayControl.getInstance().openPanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function initIcon() : void
        {
            var _loc_1:* = null;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_RETURN_EXP);
            this._dic[TopActivateName.TOP_ICON_RETURN_EXP] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_BELIAL_WORLD);
            this._dic[TopActivateName.TOP_ICON_BELIAL_WORLD] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_BOSS_HOME);
            this._dic[TopActivateName.TOP_BOSS_HOME] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_COUNTRY);
            this._dic[TopActivateName.TOP_ICON_COUNTRY] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_LINK_TO_DESKTOP);
            this._dic[TopActivateName.TOP_ICON_LINK_TO_DESKTOP] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_DEKARON);
            this._dic[TopActivateName.TOP_ICON_DEKARON] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_SCARLET_HOLD);
            this._dic[TopActivateName.TOP_ICON_SCARLET_HOLD] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_REWARDS_THOLD);
            this._dic[TopActivateName.TOP_ICON_REWARDS_THOLD] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_DEKARON);
            this._dic[TopActivateName.TOP_ICON_DEKARON] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
            this._dic[TopActivateName.TOP_ICON_CHANGE_JOB] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_CARD_PHONE);
            this._dic[TopActivateName.TOP_ICON_CARD_PHONE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_BOSS_GUILD);
            this._dic[TopActivateName.TOP_ICON_BOSS_GUILD] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_BANK);
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_FIRST_CLICK);
            this._dic[TopActivateName.TOP_ICON_BANK] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_DAILY_TASK);
            this._dic[TopActivateName.TOP_ICON_DAILY_TASK] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_RED_FORTRESS);
            this._dic[TopActivateName.TOP_ICON_RED_FORTRESS] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_LEVEL_GIFT);
            this._dic[TopActivateName.TOP_ICON_LEVEL_GIFT] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_FIRST_RECHARGE);
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_FIRST_CLICK);
            this._dic[TopActivateName.TOP_ICON_FIRST_RECHARGE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_SINGLE_RECHARGE);
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_FIRST_CLICK);
            this._dic[TopActivateName.TOP_ICON_SINGLE_RECHARGE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_SEVEN_DAY);
            this._dic[TopActivateName.TOP_ICON_SEVEN_DAY] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_VIP_COPY);
            this._dic[TopActivateName.TOP_ICON_VIP_COPY] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_ONLINE);
            this._dic[TopActivateName.TOP_ICON_ONLINE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_WOLF_SOUL);
            this._dic[TopActivateName.TOP_ICON_WOLF_SOUL] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.SUPERVIP);
            this._dic[TopActivateName.SUPERVIP] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_CLOUD_BUY);
            this._dic[TopActivateName.TOP_ICON_CLOUD_BUY] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_MAY_ACTIVITY);
            this._dic[TopActivateName.TOP_ICON_MAY_ACTIVITY] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_360);
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_NORMAL);
            this._dic[TopActivateName.GIFT_360] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_DUOWAN);
            this._dic[TopActivateName.GIFT_DUOWAN] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_37);
            this._dic[TopActivateName.GIFT_37] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_XUNLEI);
            this._dic[TopActivateName.GIFT_XUNLEI] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_BAIDU);
            this._dic[TopActivateName.GIFT_BAIDU] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_LIEBAO);
            this._dic[TopActivateName.GIFT_LIEBAO] = _loc_1;
            ItemTips.create(_loc_1, new Object(), GiftLiebaoTipView);
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_ISLAND);
            this._dic[TopActivateName.TOP_ICON_ISLAND] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_360HOME);
            this._dic[TopActivateName.GIFT_360HOME] = _loc_1;
            this.btnIcon_360 = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.GIFT_NOTHINK);
            this._dic[TopActivateName.GIFT_NOTHINK] = _loc_1;
            ItemTips.create(_loc_1, new Object(), GiftNothinkTipView);
            _loc_1 = new TopActivateIcon(TopActivateName.MERGE_SERVICE);
            this._dic[TopActivateName.MERGE_SERVICE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.PREV_MERGE);
            this._dic[TopActivateName.PREV_MERGE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.RECHARGE_DAYS);
            this._dic[TopActivateName.RECHARGE_DAYS] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.FACEBOOK_INVITE);
            this._dic[TopActivateName.FACEBOOK_INVITE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.FACEBOOK_SHARE);
            this._dic[TopActivateName.FACEBOOK_SHARE] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_ACTIVE_VALENT);
            this._dic[TopActivateName.TOP_ICON_ACTIVE_VALENT] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_PERSONAL_INFORMATION);
            this._dic[TopActivateName.TOP_ICON_PERSONAL_INFORMATION] = _loc_1;
            if (Params.isadult == AdultType.WEB_COMPLETE)
            {
                ItemTips.create(_loc_1, new Object(), PersonalInfoTip);
            }
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_MAGIC_BOOK);
            this._dic[TopActivateName.TOP_ICON_MAGIC_BOOK] = _loc_1;
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_FIRST_CLICK);
            _loc_1.setEffect(true, TopActivateIcon.EFFECT_NORMAL);
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_MID_AUTUMN);
            this._dic[TopActivateName.TOP_ICON_MID_AUTUMN] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_MOOD_FEASTIVAL);
            this._dic[TopActivateName.TOP_ICON_MOOD_FEASTIVAL] = _loc_1;
            _loc_1 = new TopActivateIcon(TopActivateName.TOP_ICON_POPULAR);
            this._dic[TopActivateName.TOP_ICON_POPULAR] = _loc_1;
            return;
        }// end function

        public function addTipsToBtn(param1:String, param2) : void
        {
            if (param2 is String)
            {
                TopActivateIcon(this._dic[param1]).tips = param2 as String;
            }
            return;
        }// end function

        public function addTopBtn(param1:String, param2:Boolean = false) : void
        {
            var _loc_7:* = 0;
            var _loc_3:* = this._dic[param1];
            var _loc_4:* = UserObj.getInstance().playerInfo.level;
            var _loc_5:* = TopActivateCfgObj.getInstance().getButtonShowLevel(param1);
            if (TopActivateCfgObj.getInstance().getButtonShowLevel(param1) != 999 && _loc_4 < _loc_5)
            {
                return;
            }
            if (this._isShowMoveEffect)
            {
                this._waitList.push(_loc_3);
                return;
            }
            if (_loc_3)
            {
                this.addChild(_loc_3);
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.TOP_ACTIVATE_BTN_ADD, param1));
                _loc_7 = this.isHasIcon(param1);
                if (_loc_7 == -1 && !param2)
                {
                    if (_loc_3.line == 1)
                    {
                        this._vecIcon1.push(_loc_3);
                    }
                    else
                    {
                        this._vecIcon2.push(_loc_3);
                    }
                }
                if (param2)
                {
                    this.beginShowMoveEffect(_loc_3);
                }
                else
                {
                    this.resetLine(_loc_3.line);
                }
            }
            var _loc_6:* = this._vecIcon1.length > this._vecIcon2.length ? (this._vecIcon1.length) : (this._vecIcon2.length);
            setWH(_loc_6 * TopActivateIcon.WIDTH, TopActivateIcon.HEIGHT * 2);
            return;
        }// end function

        public function hasTopBtn(param1:String) : Boolean
        {
            return this.isHasIcon(param1) != -1;
        }// end function

        public function removeTopBtn(param1:String) : void
        {
            var _loc_4:* = 0;
            var _loc_2:* = this._dic[param1];
            if (this._isShowMoveEffect)
            {
                this._waitDelList.push(_loc_2);
                return;
            }
            if (_loc_2 && _loc_2.parent)
            {
                this.removeChild(_loc_2);
                _loc_4 = this.isHasIcon(param1);
                if (_loc_4 != -1)
                {
                    if (_loc_2.line == 1)
                    {
                        this._vecIcon1.splice(_loc_4, 1);
                    }
                    else
                    {
                        this._vecIcon2.splice(_loc_4, 1);
                    }
                }
                this.resetLine(_loc_2.line);
                FrameworkGlobal.sendMsg(new GameEvent(GameEvent.TOP_ACTIVATE_BTN_REMOVE, param1));
            }
            var _loc_3:* = this._vecIcon1.length > this._vecIcon2.length ? (this._vecIcon1.length) : (this._vecIcon2.length);
            setWH(_loc_3 * TopActivateIcon.WIDTH, TopActivateIcon.HEIGHT * 2);
            return;
        }// end function

        public function showNormalEffect(param1:String, param2:Boolean, param3:int = 1) : void
        {
            var _loc_4:* = this.getTopActivateIcon(param1);
            if (this.getTopActivateIcon(param1))
            {
                _loc_4.setEffect(param2, TopActivateIcon.EFFECT_NORMAL);
            }
            return;
        }// end function

        public function showFuncEffect(param1:String) : void
        {
            var _loc_2:* = this.getTopActivateIcon(param1);
            if (_loc_2)
            {
                _loc_2.setEffect(true, TopActivateIcon.EFFECT_FUNC_EFFECT);
            }
            return;
        }// end function

        public function setTopBtnCountText(param1:String, param2:String) : void
        {
            var _loc_3:* = this.getTopActivateIcon(param1);
            if (_loc_3)
            {
                _loc_3.countText = param2;
            }
            return;
        }// end function

        public function setTopBtnCd(param1:String, param2:int) : void
        {
            var _loc_3:* = this.getTopActivateIcon(param1);
            if (_loc_3)
            {
                _loc_3.CD = param2;
            }
            return;
        }// end function

        public function setTopBtnTips(param1:String, param2:String) : void
        {
            var _loc_3:* = this.getTopActivateIcon(param1);
            if (_loc_3)
            {
                _loc_3.tips = param2;
            }
            return;
        }// end function

        public function getTopActivateIcon(param1:String) : TopActivateIcon
        {
            return this._dic[param1];
        }// end function

        private function resetLine(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_6:* = null;
            var _loc_10:* = 0;
            if (param1 == 1)
            {
                _loc_2 = this._vecIcon1;
                _loc_3 = this._vecIcon2;
                _loc_4 = 2;
            }
            else
            {
                _loc_2 = this._vecIcon2;
                _loc_3 = this._vecIcon1;
                _loc_4 = 1;
            }
            _loc_2.sortOn("index", Array.DESCENDING | Array.NUMERIC);
            var _loc_5:* = _loc_2.length;
            var _loc_7:* = (_loc_3.length > _loc_2.length ? (_loc_3.length) : (_loc_2.length)) - _loc_5;
            var _loc_8:* = (param1 - 1) * TopActivateIcon.HEIGHT;
            var _loc_9:* = _loc_7 * TopActivateIcon.WIDTH;
            _loc_10 = 0;
            while (_loc_10 < _loc_5)
            {
                
                _loc_6 = _loc_2[_loc_10];
                _loc_6.x = _loc_9;
                _loc_9 = _loc_9 + TopActivateIcon.WIDTH;
                _loc_6.y = _loc_8;
                _loc_10++;
            }
            _loc_5 = _loc_3.length;
            _loc_8 = (_loc_4 - 1) * TopActivateIcon.HEIGHT;
            _loc_7 = (_loc_3.length > _loc_2.length ? (_loc_3.length) : (_loc_2.length)) - _loc_5;
            _loc_9 = _loc_7 * TopActivateIcon.WIDTH;
            _loc_10 = 0;
            while (_loc_10 < _loc_5)
            {
                
                _loc_6 = _loc_3[_loc_10];
                _loc_6.x = _loc_9;
                _loc_9 = _loc_9 + TopActivateIcon.WIDTH;
                _loc_6.y = _loc_8;
                _loc_10++;
            }
            return;
        }// end function

        private function isHasIcon(param1:String) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = this._vecIcon1.length;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._vecIcon1[_loc_3].nameTop == param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            _loc_3 = 0;
            _loc_2 = this._vecIcon2.length;
            while (_loc_3 < _loc_2)
            {
                
                if (this._vecIcon2[_loc_3].nameTop == param1)
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        private function beginShowMoveEffect(param1:TopActivateIcon) : void
        {
            var _loc_4:* = 0;
            var _loc_7:* = false;
            param1.mouseEnabled = false;
            param1.mouseChildren = _loc_7;
            this._isShowMoveEffect = true;
            this._effectBtn = param1;
            var _loc_2:* = param1.line == 1 ? (this._vecIcon1.concat()) : (this._vecIcon2.concat());
            _loc_2.push(param1);
            _loc_2.sortOn("index", Array.DESCENDING | Array.NUMERIC);
            var _loc_3:* = _loc_2.length;
            if (param1.line == 1)
            {
                _loc_4 = (_loc_2.length > this._vecIcon2.length ? (_loc_2.length) : ((this._vecIcon2.length + 1))) - _loc_3;
            }
            else
            {
                _loc_4 = (this._vecIcon1.length > _loc_2.length ? ((this._vecIcon1.length + 1)) : (_loc_2.length)) - _loc_3;
            }
            var _loc_5:* = _loc_2.indexOf(param1);
            this._moveArr = _loc_2.slice(0, _loc_5);
            param1.x = FrameworkGlobal.stageW - param1.width >> 1;
            param1.y = (FrameworkGlobal.stageH - param1.height >> 1) - 80;
            this.endX = (_loc_4 + _loc_5 - 1) * TopActivateIcon.WIDTH;
            this.endY = (param1.line - 1) * TopActivateIcon.HEIGHT;
            Global.mainUIManager.addUI(param1);
            var _loc_6:* = localToGlobal(new Point(this.endX - TopActivateIcon.WIDTH, this.endY + TopActivateIcon.HEIGHT));
            TweenLite.to(param1, 0.8, {x:_loc_6.x, y:_loc_6.y, ease:Expo.easeIn, onComplete:this._moveStep1Complete});
            return;
        }// end function

        private function _moveStep1Complete() : void
        {
            var _loc_2:* = null;
            if (this._moveArr && this._moveArr.length)
            {
                for each (_loc_2 in this._moveArr)
                {
                    
                    TweenLite.to(_loc_2, 0.6, {x:_loc_2.x - TopActivateIcon.WIDTH * 1.5});
                }
            }
            var _loc_1:* = localToGlobal(new Point(this.endX, this.endY));
            TweenLite.to(this._effectBtn, 0.8, {x:_loc_1.x, y:_loc_1.y, onComplete:this._moveStep2Complete});
            return;
        }// end function

        private function _moveStep2Complete() : void
        {
            var _loc_1:* = null;
            if (this._moveArr && this._moveArr.length)
            {
                for each (_loc_1 in this._moveArr)
                {
                    
                    TweenLite.to(_loc_1, 0.4, {x:_loc_1.x + TopActivateIcon.WIDTH * 0.5});
                }
            }
            this._effectBtn.setEffect(true, TopActivateIcon.EFFECT_FUNC_EFFECT);
            TweenLite.delayedCall(0.6, this._moveStep3Complete);
            return;
        }// end function

        private function _moveStep3Complete() : void
        {
            var _loc_1:* = null;
            this._isShowMoveEffect = false;
            this.addTopBtn(this._effectBtn.nameTop);
            for each (_loc_1 in this._waitList)
            {
                
                this.addTopBtn(_loc_1.nameTop);
            }
            for each (_loc_1 in this._waitDelList)
            {
                
                this.removeTopBtn(_loc_1.nameTop);
            }
            this._waitList.splice(0, this._waitList.length);
            _loc_3.splice(0, _loc_3.length);
            this._effectBtn = null;
            this._moveArr = null;
            Global.mainUIManager.layoutUI(this);
            return;
        }// end function

        public function openOrClose(param1:Boolean = true) : void
        {
            var _loc_3:* = null;
            TweenLite.killTweensOf(this);
            var _loc_2:* = new Bitmap();
            if (width != 0 && height != 0)
            {
                _loc_3 = new BitmapData(width, height, true, 0);
                _loc_3.draw(this);
                _loc_2.bitmapData = _loc_3;
                this.parent.addChild(_loc_2);
                mouseEnabled = false;
                mouseChildren = false;
                this.visible = false;
                _loc_2.x = x;
                _loc_2.y = y;
                if (param1)
                {
                    TweenLite.from(_loc_2, 0.2, {scaleX:0.1, scaleY:0.1, y:30, x:x + width, onComplete:this.shrinkComp, onCompleteParams:[_loc_2, true]});
                }
                else
                {
                    TweenLite.to(_loc_2, 0.2, {scaleX:0.1, scaleY:0.1, y:30, x:x + width, onComplete:this.shrinkComp, onCompleteParams:[_loc_2, false]});
                }
            }
            return;
        }// end function

        private function shrinkComp(param1:Bitmap, param2:Boolean) : void
        {
            param1.parent.removeChild(param1);
            mouseEnabled = true;
            mouseChildren = true;
            this.visible = param2;
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            if (param1)
            {
                FrameworkGlobal.sendMsg(new Event("top_panel_show"));
            }
            else
            {
                FrameworkGlobal.sendMsg(new Event("top_panel_hide"));
            }
            return;
        }// end function

        public function update360Tips(event:NewActivityEvent) : void
        {
            var _loc_2:* = event.target as NewActivityInfo;
            if (int(_loc_2.otherInfo) == 1)
            {
                ItemTips.create(this.btnIcon_360, new Object(), Gift360HomeTipView);
            }
            else
            {
                ItemTips.dispose(this.btnIcon_360);
            }
            return;
        }// end function

    }
}
