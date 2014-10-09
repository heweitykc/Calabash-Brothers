package com.game.player.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.game.autopk.controller.*;
    import com.game.autopk.model.*;
    import com.game.backpack.model.*;
    import com.game.gradegift.view.component.*;
    import com.game.map.view.bar.*;
    import com.game.player.control.*;
    import com.game.role.*;
    import com.game.shop.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.events.*;
    import flash.text.*;

    public class ReliveBox extends BaseBox
    {
        private const swf:String = "res/relive.swf";
        private var nextBtn:BaseButton;
        private var lastBtn:BaseButton;
        private var costGoldReliveBtn:BaseButton;
        private var safeReliveBtn:BaseButton;
        private var ceterBar:ReliveCenterBar;
        private var num:ImgNumber;
        private var reliveToolBtn:GiftIconItem;
        private var tooltips:TextField;
        private var tip1Txt:TextField;
        private var tip2Txt:TextField;
        public var reliveType:int;
        private var _item:PropInfo;
        private var canClick:Boolean = true;
        private var params:Object;
        private var remain:int = 30;
        private var num2:ImgNumber;
        public static const ShopItemID:int = 200051;

        public function ReliveBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super(param1, param2, param3, param4);
            loadDisplay(this.swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("relive.main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.num2 = new ImgNumber();
            this.num2.move(410, 330);
            this.num2.setScale(0.6);
            this.num2.filters = [FrameworkGlobal.colorMat];
            addChild(this.num2);
            this.num = new ImgNumber();
            this.num.move(470, 340);
            this.num.align = Align.RIGHT;
            addChild(this.num);
            _peaceBox = ["*"];
            this.nextBtn = new BaseButton(getDisplayChildByName("nextBtn"));
            this.lastBtn = new BaseButton(getDisplayChildByName("lastBtn"));
            this.tooltips = getDisplayChildByName("tooltips") as TextField;
            this.ceterBar = new ReliveCenterBar();
            this.ceterBar.move(65, 165);
            addChild(this.ceterBar);
            this.costGoldReliveBtn = new BaseButton(getDisplayChildByName("costGoldReliveBtn"));
            this.costGoldReliveBtn.setText(LanguageCfgObj.getInstance().getByIndex("11010"));
            this.safeReliveBtn = new BaseButton(getDisplayChildByName("safeReliveBtn"));
            this.safeReliveBtn.setText(LanguageCfgObj.getInstance().getByIndex("11011"));
            this.lastBtn.visible = false;
            this.nextBtn.visible = false;
            this.reliveToolBtn = new GiftIconItem("PropBox66");
            this.reliveToolBtn.setWH(66, 66);
            this.reliveToolBtn.move(37, 307);
            addChild(this.reliveToolBtn);
            this.tip1Txt = getDisplayChildByName("tip1Txt") as TextField;
            this.tip2Txt = getDisplayChildByName("tip2Txt") as TextField;
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var info:ShopItemInfo;
            var e:* = event;
            if (this.canClick)
            {
                this.canClick = false;
                TweenLite.delayedCall(0.5, function () : void
            {
                canClick = true;
                return;
            }// end function
            );
            }
            else
            {
                return;
            }
            switch(e.target)
            {
                case this.nextBtn:
                {
                    if (!this.ceterBar.nextFrame())
                    {
                        this.nextBtn.visible = false;
                    }
                    if (this.lastBtn.visible == false)
                    {
                        this.lastBtn.visible = true;
                    }
                    break;
                }
                case this.lastBtn:
                {
                    if (!this.ceterBar.lastFrame())
                    {
                        this.lastBtn.visible = false;
                    }
                    if (this.nextBtn.visible == false)
                    {
                        this.nextBtn.visible = true;
                    }
                    break;
                }
                case this.costGoldReliveBtn:
                {
                    if (BackpackObj.getInstance().getItemCount(200051) <= 0 && UserObj.getInstance().playerInfo.level > GlobalCfgObj.getInstance().getDieLevel())
                    {
                        info = ShopCfgObj.getInstance().getShopItemInfoFromInside(ShopItemID);
                        ShopController.getInstance().openBuyItem(info);
                    }
                    else
                    {
                        PlayerControl.getInstance().reqRevive(AutoReviveType.AUTO_REVIVE, ShopItemID);
                    }
                    break;
                }
                case this.safeReliveBtn:
                {
                    PlayerControl.getInstance().reqRevive(0);
                    break;
                }
                case this.reliveToolBtn:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function initData(param1:Object) : void
        {
            this.params = param1;
            return;
        }// end function

        private function desTime() : void
        {
            var _loc_2:* = false;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            var _loc_5:* = this;
            var _loc_6:* = this.remain - 1;
            _loc_5.remain = _loc_6;
            this.num.setNumber(this.remain.toString(), 5);
            if (this.remain > 25)
            {
                this.num2.setNumber((this.remain - 25).toString(), 5);
            }
            if (this.remain <= 25 && this.num2.visible)
            {
                this.num2.visible = false;
                this.safeReliveBtn.enabled = true;
            }
            var _loc_1:* = RoleList.getInstance().player as Player;
            if (this.remain <= 22 && !_loc_1.alive())
            {
                _loc_2 = UserObj.getInstance().playerInfo.vipid > 0;
                _loc_3 = DieLogic.isContinueAuto;
                if (AutoFightModel.autoBorn && _loc_3)
                {
                    _loc_4 = BackpackObj.getInstance().getItemCount(ShopItemID);
                    if (_loc_4 > 0)
                    {
                        PlayerControl.getInstance().reqRevive(AutoReviveType.AUTO_REVIVE, ShopItemID);
                    }
                    else
                    {
                        DieLogic.isContinueAuto = false;
                    }
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            if (UserObj.getInstance().playerInfo.alive())
            {
                this.close();
            }
            this.safeReliveBtn.enabled = false;
            this.num2.visible = true;
            if (this.params)
            {
                this.tip1Txt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12165"), [this.params.attackername]);
                this.tip2Txt.htmlText = "<font color=\'#ff0000\'>" + LanguageCfgObj.getInstance().getByIndex("12168") + ToolKit.getTimeBySecond2(this.params.dieTime) + "</font>";
            }
            this.remain = PlayerControl.getInstance().remainTime;
            this.num.setNumber(this.remain.toString(), 5);
            var _loc_2:* = this.remain - 25 <= 1 ? (1) : (this.remain - 25);
            this.num2.setNumber("" + _loc_2, 5);
            this._item = PropUtil.createItemByCfg(ShopItemID);
            this.reliveToolBtn.setInfo(this._item);
            this.reliveToolBtn.setNum(BackpackObj.getInstance().getItemCount(ShopItemID));
            Ticker.killTimer(this.desTime);
            Ticker.registerTimer(1, this.desTime, null, this.remain);
            if (UserObj.getInstance().playerInfo.level <= GlobalCfgObj.getInstance().getDieLevel())
            {
                this.tooltips.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12169"), [GlobalCfgObj.getInstance().getDieLevel()]);
            }
            else
            {
                this.tooltips.text = "";
            }
            return;
        }// end function

        override public function openOrClose() : void
        {
            super.openOrClose();
            return;
        }// end function

        public function updateStoneNume() : void
        {
            if (this._item)
            {
                this.reliveToolBtn.setInfo(this._item);
                this.reliveToolBtn.setNum(BackpackObj.getInstance().getItemCount(ShopItemID));
            }
            return;
        }// end function

        override public function close() : void
        {
            Ticker.killTimer(this.desTime);
            super.close();
            return;
        }// end function

    }
}
