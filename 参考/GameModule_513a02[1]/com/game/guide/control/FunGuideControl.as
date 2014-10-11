package com.game.guide.control
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.backpack.control.*;
    import com.game.challenge.control.*;
    import com.game.guide.consts.*;
    import com.game.guide.model.*;
    import com.game.guide.view.*;
    import com.game.mall.control.*;
    import com.game.map.control.*;
    import com.game.player.control.*;
    import com.game.prey.control.*;
    import com.game.primaryrole.control.*;
    import com.game.shop.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.utils.*;

    public class FunGuideControl extends Object
    {
        private var _remindObj:Vector.<FunGuideCfg>;
        public const SELL:int = 1;
        public const TALENT:int = 2;
        public const ITEM_EXPANSION:int = 3;
        public const SELF_SHOP:int = 4;
        public var TEMPLETE:Object;
        public var _panels:Array;
        public var _shopTime:int;
        private var _reminPanel:FunGuideRemindPanel;
        private var _funguideremind:FunGuideRemindPanel;
        private static var _inst:FunGuideControl;

        public function FunGuideControl()
        {
            var _loc_2:* = null;
            this.TEMPLETE = {1:LanguageCfgObj.getInstance().getByIndex("12052"), 2:LanguageCfgObj.getInstance().getByIndex("12053"), 3:LanguageCfgObj.getInstance().getByIndex("12054"), 4:LanguageCfgObj.getInstance().getByIndex("12055")};
            this._panels = [];
            this._remindObj = new Vector.<FunGuideCfg>;
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                _loc_2 = FuncGuideCfgObj.getInstance().getFunGuide((_loc_1 + 1));
                this._remindObj.push(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        public function addGuide(param1:int) : void
        {
            var _loc_3:* = 0;
            if (!UserObj.getInstance().playerInfo.alive())
            {
                return;
            }
            if (param1 == this.SELF_SHOP)
            {
                if (UserObj.getInstance().playerInfo.pkValue > 0)
                {
                    return;
                }
                _loc_3 = getTimer();
                if (this._shopTime == 0 || _loc_3 - this._shopTime > 120000)
                {
                    this._shopTime = _loc_3;
                }
                else
                {
                    return;
                }
            }
            var _loc_2:* = this.getGuidePanel(param1);
            _loc_2.type = param1;
            _loc_2.open();
            this._panels.push(_loc_2);
            return;
        }// end function

        public function clearShopTime() : void
        {
            this._shopTime = 0;
            return;
        }// end function

        public function closeGuide(param1:int) : void
        {
            var _loc_2:* = this.hasGuidePanel(param1);
            if (_loc_2)
            {
                _loc_2.__close();
            }
            return;
        }// end function

        public function hasGuidePanel(param1:int) : FunGuidePanel
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._panels.length)
            {
                
                if (this._panels[_loc_2].type == param1)
                {
                    return this._panels[_loc_2];
                }
                _loc_2++;
            }
            return null;
        }// end function

        public function getGuidePanel(param1:int) : FunGuidePanel
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._panels.length)
            {
                
                if (this._panels[_loc_2].type == param1)
                {
                    return this._panels[_loc_2];
                }
                _loc_2++;
            }
            return ObjectPool.CheckOut(FunGuidePanel);
        }// end function

        public function openFunGuide(param1:int) : void
        {
            if (!UserObj.getInstance().playerInfo.alive())
            {
                return;
            }
            switch(param1)
            {
                case FunGuideConst.PRAY:
                {
                    PrayControl.getInstance().openOrClosePrayBox();
                    break;
                }
                case FunGuideConst.SCARLETHOLD:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
                    break;
                }
                case FunGuideConst.BELIAWORLD:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case FunGuideConst.BOSSGUIDE:
                {
                    BossGuideControl.getInstance().openOrCloseBossGuildPanel();
                    break;
                }
                case FunGuideConst.STALLS:
                {
                    if (UserObj.getInstance().playerInfo.pkValue > 0)
                    {
                        PlayerControl.getInstance().openBannerTips();
                        return;
                    }
                    BackPackControl.getInstance().openBackpack();
                    AuctionControl.getInstance().openStalls();
                    break;
                }
                case FunGuideConst.MALL:
                {
                    MallControl.getInstance().openMall();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function openGuide(param1:int) : void
        {
            if (!UserObj.getInstance().playerInfo.alive())
            {
                return;
            }
            switch(param1)
            {
                case this.SELL:
                {
                    ShopController.getInstance().openOneKey();
                    BackPackControl.getInstance().openBackpack();
                    break;
                }
                case this.TALENT:
                {
                    PrimaryRoleControl.getInstance().openExtraPanel(1);
                    break;
                }
                case this.ITEM_EXPANSION:
                {
                    BackPackControl.getInstance().openBackpack();
                    BackPackControl.getInstance().showOpenItemrenderer();
                    break;
                }
                case this.SELF_SHOP:
                {
                    if (UserObj.getInstance().playerInfo.pkValue > 0)
                    {
                        PlayerControl.getInstance().openBannerTips();
                    }
                    else
                    {
                        BackPackControl.getInstance().openBackpack();
                        ShopController.getInstance().openShop();
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

        public function showRemind(param1:int) : void
        {
            if (!UserObj.getInstance().playerInfo.alive())
            {
                return;
            }
            var _loc_2:* = this._remindObj[(param1 - 1)];
            var _loc_3:* = [];
            var _loc_4:* = _loc_2.funArr;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                switch(_loc_4[_loc_5].type)
                {
                    case FunGuideConst.PRAY:
                    {
                        if (MapControl.getInstance().getPrayTimes() > 0)
                        {
                            _loc_3.push(_loc_4[_loc_5]);
                        }
                        break;
                    }
                    case FunGuideConst.SCARLETHOLD:
                    {
                        if (ZonesControl.getInstance().getZoneLastTimes(ZoneType.ZONES_XS) > 0)
                        {
                            _loc_3.push(_loc_4[_loc_5]);
                        }
                        break;
                    }
                    case FunGuideConst.BELIAWORLD:
                    {
                        if (ZonesControl.getInstance().getZoneLastTimes(ZoneType.ZONES_BELIAL_WORLD) > 0)
                        {
                            _loc_3.push(_loc_4[_loc_5]);
                        }
                        break;
                    }
                    case FunGuideConst.BOSSGUIDE:
                    {
                        _loc_3.push(_loc_4[_loc_5]);
                        break;
                    }
                    case FunGuideConst.STALLS:
                    {
                        _loc_3.push(_loc_4[_loc_5]);
                        break;
                    }
                    case FunGuideConst.MALL:
                    {
                        _loc_3.push(_loc_4[_loc_5]);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_5++;
            }
            _loc_2.funArr = _loc_3;
            if (this._funguideremind == null)
            {
                this._funguideremind = new FunGuideRemindPanel();
            }
            this._funguideremind.info = _loc_2;
            this._funguideremind.open();
            return;
        }// end function

        public function checkItem(param1:int) : void
        {
            switch(param1)
            {
                case ItemConst.BLESS_STONE:
                {
                    this.showRemind(FunGuideConst.BLESS);
                    break;
                }
                case ItemConst.SOUL_STONE:
                {
                    this.showRemind(FunGuideConst.SOUL);
                    break;
                }
                case ItemConst.LIFE_STONE:
                {
                    this.showRemind(FunGuideConst.LIFE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function removeGuide(param1:BaseBox) : void
        {
            ObjectPool.CheckIn(param1);
            this._panels.splice(this._panels.indexOf(param1), 1);
            return;
        }// end function

        public static function getInstance() : FunGuideControl
        {
            var _loc_1:* = new FunGuideControl;
            _inst = new FunGuideControl;
            return _inst || _loc_1;
        }// end function

    }
}
