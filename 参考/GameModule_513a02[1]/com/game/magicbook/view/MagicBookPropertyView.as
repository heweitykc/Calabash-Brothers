package com.game.magicbook.view
{
    import com.*;
    import com.cfg.info.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.magicbook.bean.*;
    import com.game.magicbook.control.*;
    import com.game.magicbook.model.*;
    import com.game.magicbook.view.compent.*;
    import com.game.map.control.*;
    import com.game.shop.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class MagicBookPropertyView extends Component
    {
        private var _attackNumTxt:TextField;
        private var _attackAddTxt:TextField;
        private var _attackSpeedTxt:TextField;
        private var _attackSpeedAddTxt:TextField;
        private var _attackSuccessTxt:TextField;
        private var _attackSuccessAddTxt:TextField;
        private var _attackDeepTxt:TextField;
        private var _attackDeepAddTxt:TextField;
        private var _inorgeDefendTxt:TextField;
        private var _inorgeDefendAddTxt:TextField;
        private var _remainExpToolTxt:TextField;
        private var _expToolIcon:IconItem;
        private var _levelExpreTxt:TextField;
        private var _magicbookLevelTxt:TextField;
        private var _ExpBar:Stripe;
        private var _breakBtn:BaseButton;
        private var _opBtn:BaseButton;
        private var _onekeyBtn:BaseButton;
        private var _breaktoolsNumlTxt:TextField;
        private var _magicBook:MagicBookInfo;
        private var _currentUseItem:PropInfo;
        private var isOneKeying:Boolean = false;
        private var isAutoBuyItem:Boolean = false;
        private var iscomfirm:Boolean = true;
        private var before:Number = 0;
        public static var magicBookLang:String = "lang_magicBook";

        public function MagicBookPropertyView()
        {
            initComponentUI("magicBook_property");
            this._magicBook = MagicBookData.getMagicBookInfo();
            this.move(390, 90);
            this.initUI();
            this.addEvent();
            this.updateUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._opBtn = new BaseButton(getDisplayChildByName("opBtn"));
            this._opBtn.setText(LanguageCfgObj.getInstance().getByIndex("10007", magicBookLang));
            this._breakBtn = new BaseButton(getDisplayChildByName("breakBtn"));
            this._breakBtn.setText(LanguageCfgObj.getInstance().getByIndex("10006", magicBookLang));
            this._onekeyBtn = new BaseButton(getDisplayChildByName("onekeyBtn"));
            this._breaktoolsNumlTxt = getDisplayChildByName("breaktoolsNumlTxt");
            this._onekeyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10012", magicBookLang));
            ItemTips.create(this._onekeyBtn, new Object(), MagicBookAutoExpUpTip);
            this._attackNumTxt = getDisplayChildByName("attackNumTxt");
            this._attackAddTxt = getDisplayChildByName("attackAddTxt");
            this._attackSpeedTxt = getDisplayChildByName("attackSpeedTxt");
            this._attackSpeedAddTxt = getDisplayChildByName("attackSpeedAddTxt");
            this._attackSuccessTxt = getDisplayChildByName("attackSuccessTxt");
            this._attackSuccessAddTxt = getDisplayChildByName("attackSuccessAddTxt");
            this._attackDeepTxt = getDisplayChildByName("attackDeepTxt");
            this._attackDeepAddTxt = getDisplayChildByName("attackDeepAddTxt");
            this._inorgeDefendTxt = getDisplayChildByName("inorgeDefendTxt");
            this._inorgeDefendAddTxt = getDisplayChildByName("inorgeDefendAddTxt");
            this._remainExpToolTxt = getDisplayChildByName("remainExpToolTxt");
            this._magicbookLevelTxt = getDisplayChildByName("magicbookLevelTxt");
            this._levelExpreTxt = getDisplayChildByName("levelExpreTxt");
            this._ExpBar = new Stripe(getDisplayChildByName("magicBookExpBar"));
            this._ExpBar.isOnlyIncrease = true;
            this._expToolIcon = new MagicBookUpIconItem();
            addChild(this._expToolIcon);
            this._expToolIcon.move(142, 204);
            return;
        }// end function

        private function addEvent() : void
        {
            this._opBtn.addEventListener(MouseEvent.MOUSE_OVER, this.__showPropTips);
            this._opBtn.addEventListener(MouseEvent.MOUSE_OUT, this.__showPropTips);
            this._breakBtn.addEventListener(MouseEvent.MOUSE_OVER, this.__showPropTips);
            this._breakBtn.addEventListener(MouseEvent.MOUSE_OUT, this.__showPropTips);
            this._onekeyBtn.addEventListener(MouseEvent.MOUSE_OVER, this.__showPropTips);
            this._onekeyBtn.addEventListener(MouseEvent.MOUSE_OUT, this.__showPropTips);
            this.addEvtListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoveFromStage);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function __showPropTips(event:MouseEvent = null) : void
        {
            var _loc_2:* = null;
            if (event.type == MouseEvent.MOUSE_OVER)
            {
                _loc_2 = QMagicbookLevelCfg.getInstance().getMagicBookCfg((this._magicBook.level + 1));
                MagicBookControl.getIntance().mouseOverCompareProp(_loc_2 ? (_loc_2.prop) : (null));
            }
            else if (event.type == MouseEvent.MOUSE_OUT)
            {
                MagicBookControl.getIntance().mouseOverCompareProp(null);
            }
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.updateUI();
            this._magicBook.addEvtListener(MagicBookEvent.EXP_CHANGE, this.__updateExp);
            this._magicBook.addEvtListener(MagicBookEvent.ATTRINFO_CHANGE, this.__updateAtrr);
            this._magicBook.addEvtListener(MagicBookEvent.UPDATEINFO, this.__updateLevel);
            BackpackObj.getInstance().addEvtListener(BackpackEvent.GOODS_CHANGE, this.__updateRemainTools);
            MagicBookData.addEventListener(MagicBookData.STOP_ONEKEY, this.__stopOnekey);
            MagicBookData.addEventListener(MagicBookData.ONEKEY_UP_EXP, this.onekeyExpUp);
            return;
        }// end function

        protected function onRemoveFromStage(event:Event) : void
        {
            this._magicBook.removeEvtListener(MagicBookEvent.EXP_CHANGE, this.__updateExp);
            this._magicBook.removeEvtListener(MagicBookEvent.ATTRINFO_CHANGE, this.__updateAtrr);
            this._magicBook.removeEvtListener(MagicBookEvent.UPDATEINFO, this.__updateLevel);
            BackpackObj.getInstance().removeEvtListener(BackpackEvent.GOODS_CHANGE, this.__updateRemainTools);
            MagicBookData.removeEventListener(MagicBookData.STOP_ONEKEY, this.__stopOnekey);
            MagicBookData.removeEventListener(MagicBookData.ONEKEY_UP_EXP, this.onekeyExpUp);
            this.__stopOnekey();
            return;
        }// end function

        private function updateUI() : void
        {
            if (UILoaded)
            {
                this.__updateLevel();
                this.__updateExp();
                this.__updateAtrr();
                this.__updateRemainTools();
            }
            return;
        }// end function

        private function __updateLevel(event:MagicBookEvent = null) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBook.level);
            if (_loc_2.breakthrough < 0 || _loc_2.max_exp > this._magicBook.exp_m)
            {
                this._onekeyBtn.enabled = true;
                if (!this._opBtn.visible)
                {
                    this._opBtn.visible = true;
                }
                if (!this._onekeyBtn.visible)
                {
                    this._onekeyBtn.visible = true;
                }
                this._breakBtn.visible = false;
                this._breaktoolsNumlTxt.visible = false;
                _loc_4 = _loc_2.useItemId;
                this._currentUseItem = PropUtil.createItemByCfg(_loc_4[0]);
                this._expToolIcon.setInfo(this._currentUseItem);
            }
            else
            {
                this._opBtn.visible = false;
                this._onekeyBtn.visible = false;
                this._breakBtn.visible = true;
                _loc_5 = _loc_2.breakthrough_items_str.split("_");
                this._currentUseItem = PropUtil.createItemByCfg(_loc_5[0]);
                this._currentUseItem.num = _loc_5[1];
                this._expToolIcon.setInfo(this._currentUseItem);
                this._breaktoolsNumlTxt.visible = true;
                this._breaktoolsNumlTxt.htmlText = "";
            }
            this.__updateRemainTools();
            var _loc_3:* = _loc_2.getMagicLevel();
            this._magicbookLevelTxt.text = "Lv." + _loc_3;
            if (_loc_3 < 20)
            {
                this._levelExpreTxt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10005", magicBookLang), [20 - _loc_3]);
            }
            else
            {
                this._levelExpreTxt.text = LanguageCfgObj.getInstance().getByIndex("10019", magicBookLang);
            }
            return;
        }// end function

        private function onekeyExpUp(event:Event = null) : void
        {
            if (!this.isOneKeying || event)
            {
                this.isOneKeying = true;
                TweenLite.delayedCall(0.2, this.reqOneKeyUpExpHandler);
            }
            else
            {
                this.__stopOnekey();
            }
            return;
        }// end function

        private function reqOneKeyUpExpHandler() : void
        {
            var info:ShopItemInfo;
            var gold:int;
            if (!this.isOneKeying)
            {
                return;
            }
            if (!this.isAutoBuyItem && BackpackObj.getInstance().getItemCount(this._currentUseItem.itemModelId) <= 0)
            {
                info = ShopCfgObj.getInstance().getShopItemInfoFromInside(this._currentUseItem.itemModelId);
                gold = info.gold;
                Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10014", magicBookLang), [this._currentUseItem.q_name, gold]), LanguageCfgObj.getInstance().getByIndex("11869"), null, function () : void
            {
                if (!UserObj.getInstance().chechGoldEnough(gold))
                {
                    MapControl.getInstance().showRechargeD();
                    __stopOnekey();
                    return;
                }
                isAutoBuyItem = true;
                startOneKey();
                return;
            }// end function
            , null, 2, null, false, true, function (param1:Boolean) : void
            {
                iscomfirm = !param1;
                return;
            }// end function
            );
            }
            else
            {
                this.startOneKey();
            }
            return;
        }// end function

        private function startOneKey() : void
        {
            this.isOneKeying = true;
            this._onekeyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10013", magicBookLang));
            MagicBookControl.getIntance().reqOneKeyUpExp();
            return;
        }// end function

        private function __stopOnekey(event:Event = null) : void
        {
            this._onekeyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10012", magicBookLang));
            this.isOneKeying = false;
            return;
        }// end function

        private function __updateExp(event:MagicBookEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = NaN;
            if (UILoaded)
            {
                _loc_2 = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBook.level);
                _loc_3 = this._magicBook.exp_m / _loc_2.max_exp;
                if (this.before < _loc_3)
                {
                    this._ExpBar.setValue(this._magicBook.exp_m, _loc_2.max_exp, true);
                }
                else
                {
                    this._ExpBar.setValue(this._magicBook.exp_m, _loc_2.max_exp);
                }
                this.before = _loc_3;
                this._ExpBar.setText(this._magicBook.exp_m.toString() + "/" + _loc_2.max_exp);
                this.__updateLevel();
            }
            return;
        }// end function

        private function __updateAtrr(event:MagicBookEvent = null) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            if (UILoaded)
            {
                _loc_2 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.ATK_MIN);
                _loc_3 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.ATK_MAX);
                _loc_4 = MagicBookData.isOpenGrowFunction;
                if (!_loc_2)
                {
                    return;
                }
                this._attackNumTxt.text = _loc_2.attrValue.toString() + "-" + _loc_3.attrValue;
                this._attackAddTxt.text = "( +" + _loc_2.attrValueBefor + " )";
                this._attackAddTxt.visible = _loc_4;
                StringTip.create(this._attackAddTxt, LanguageCfgObj.getInstance().getByIndex("10016", magicBookLang));
                _loc_2 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.ATTACK_SPEED);
                this._attackSpeedTxt.text = _loc_2.attrValue.toString();
                this._attackSpeedAddTxt.text = "( +" + _loc_2.attrValueBefor + " )";
                this._attackSpeedAddTxt.visible = _loc_4;
                StringTip.create(this._attackSpeedAddTxt, LanguageCfgObj.getInstance().getByIndex("10016", magicBookLang));
                _loc_2 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.ATTACK_SUCCESS);
                this._attackSuccessTxt.text = _loc_2.attrValue.toString();
                this._attackSuccessAddTxt.text = "( +" + _loc_2.attrValueBefor + " )";
                this._attackSuccessAddTxt.visible = _loc_4;
                StringTip.create(this._attackSuccessAddTxt, LanguageCfgObj.getInstance().getByIndex("10016", magicBookLang));
                _loc_2 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.ATTACK_DEEP);
                this._attackDeepTxt.text = _loc_2.attrValue / 100 + "%";
                this._attackDeepAddTxt.text = "( +" + _loc_2.attrValueBefor / 100 + "% )";
                this._attackDeepAddTxt.visible = _loc_4;
                StringTip.create(this._attackDeepAddTxt, LanguageCfgObj.getInstance().getByIndex("10016", magicBookLang));
                _loc_2 = this._magicBook.getMagicAttrInfo(MagicBookPropertyType.INORGE_INFENCE);
                this._inorgeDefendTxt.text = _loc_2.attrValue / 100 + "%";
                this._inorgeDefendAddTxt.text = "";
                this._inorgeDefendAddTxt.visible = _loc_4;
            }
            return;
        }// end function

        private function __updateRemainTools(event:BackpackEvent = null) : void
        {
            var _loc_2:* = BackpackObj.getInstance().getItemCount(this._currentUseItem.itemModelId);
            this._remainExpToolTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10011", magicBookLang), [_loc_2]);
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            switch(event.target)
            {
                case this._opBtn:
                {
                    this.__stopOnekey();
                    if (this._magicBook.level >= 200)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10017", magicBookLang));
                        return;
                    }
                    if (BackpackObj.getInstance().getItemCount(this._currentUseItem.itemModelId) <= 0)
                    {
                        _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(this._currentUseItem.itemModelId);
                        ShopController.getInstance().openBuyItem(_loc_2);
                        return;
                    }
                    MagicBookControl.getIntance().reqUpExp();
                    break;
                }
                case this._onekeyBtn:
                {
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(this._currentUseItem.itemModelId);
                    if (BackpackObj.getInstance().getItemCount(this._currentUseItem.itemModelId) <= 0)
                    {
                        if (!UserObj.getInstance().chechGoldEnough(_loc_2.gold))
                        {
                            MapControl.getInstance().showRechargeD();
                            return;
                        }
                    }
                    if (this.iscomfirm)
                    {
                        this.isAutoBuyItem = false;
                    }
                    this.onekeyExpUp();
                    break;
                }
                case this._breakBtn:
                {
                    this.__stopOnekey();
                    _loc_3 = QMagicbookLevelCfg.getInstance().getMagicBookCfg(this._magicBook.level);
                    _loc_4 = _loc_3.breakthrough_items_str.split("_")[1];
                    _loc_5 = BackpackObj.getInstance().getItemCount(this._currentUseItem.itemModelId);
                    if (_loc_5 < _loc_4)
                    {
                        _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(this._currentUseItem.itemModelId);
                        ShopController.getInstance().openBuyItem(_loc_2, _loc_4 - _loc_5);
                        return;
                    }
                    MagicBookControl.getIntance().reqBreakthrough();
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

    }
}
