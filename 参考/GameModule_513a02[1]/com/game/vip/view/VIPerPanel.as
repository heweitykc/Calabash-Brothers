package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.events.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.scroller.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.vip.bean.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VIPerPanel extends BaseBox
    {
        private var _mcVip:Sprite;
        private var _stageLevelVip:MovieClip;
        private var _levelVip:MovieClip;
        private var _info:VipInfo;
        private var _welcomeTxt:TextField;
        private var _tipsTxt:TextField;
        private var _rechargeBtn:BaseButton;
        private var _continueBtn:BaseButton;
        private var _recommand:VIPRecommand;
        private var _closeBtn:BaseButton;
        private var _sheet:Sprite;
        private var _bagSp:Sprite;
        private var _bagContainer:HBox;
        private var _scrollpanel:ScrollPanel;
        private var _lastTimeId:String;
        private var _lastTime:TextField;
        private var _timeCount:int;
        private var _stripe:Stripe;
        private var _expPoint:int;

        public function VIPerPanel()
        {
            super.loadDisplay("res/viperpanel.swf");
            return;
        }// end function

        public function get info() : VipInfo
        {
            return this._info;
        }// end function

        public function set info(param1:VipInfo) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("viperpanel");
            this.initUI();
            this.addlisteners();
            if (VIPControl.getInstance().vipinfo)
            {
                this.info = VIPControl.getInstance().vipinfo;
            }
            this.initView();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._mcVip = getDisplayChildByName("mc_vip") as Sprite;
            this._levelVip = this._mcVip.getChildByName("mc_count") as MovieClip;
            this._stageLevelVip = this._mcVip.getChildByName("bg") as MovieClip;
            this._stripe = new Stripe(getDisplayChildByName("stripe"));
            this._lastTime = getDisplayChildByName("txt_time");
            this._welcomeTxt = getDisplayChildByName("txt_welcome");
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._sheet = getDisplayChildByName("vip_sheet");
            this._sheet.mouseEnabled = false;
            this._bagContainer = new HBox();
            this._bagContainer.intervalX = 1;
            this._bagContainer.intervalY = 0;
            this._bagContainer.oneRow = 1;
            this._bagSp = new Sprite();
            this._bagContainer.y = 38;
            this._bagSp.addChild(this._bagContainer);
            this._sheet.visible = false;
            var _loc_1:* = 0;
            while (_loc_1 < VipConst.rights.length)
            {
                
                if (FrameworkGlobal.language == "ft" && VipConst.rights[_loc_1] == VipConst.VIP_KLM)
                {
                }
                else
                {
                    _loc_2 = new VIPFunItem();
                    _loc_2.info = VipConst.rights[_loc_1];
                    this._bagContainer.add(_loc_2);
                }
                _loc_1++;
            }
            this._scrollpanel = new ScrollPanel(635, 335, "scrollBar2");
            this._scrollpanel.content = this._bagSp;
            this._scrollpanel.offsetY = 38;
            this._scrollpanel.move(39, 191);
            addChild(this._scrollpanel);
            this._sheet.y = this._scrollpanel.y + 40;
            this._recommand = new VIPRecommand();
            this._recommand.move(698, 94);
            this._continueBtn = new BaseButton(getDisplayChildByName("btn_continue"));
            this._rechargeBtn = new BaseButton(getDisplayChildByName("btn_recharge"));
            addChild(this._sheet);
            return;
        }// end function

        private function refreshTime(event:TimerManagerEvent = null) : void
        {
            if (this._timeCount <= 0)
            {
                TimerManager.killTimer(this._lastTimeId);
                this._lastTime.text = "";
                return;
            }
            this._lastTime.htmlText = LanguageCfgObj.getInstance().getByIndex("12292") + ToolKit.second2TimeStr(VipModel.getInstance().getCount(), LanguageCfgObj.getInstance().getByIndex("10026") + LanguageCfgObj.getInstance().getByIndex("10027") + LanguageCfgObj.getInstance().getByIndex("10028") + LanguageCfgObj.getInstance().getByIndex("10029")) + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12293"), [this._expPoint]);
            var _loc_2:* = this;
            var _loc_3:* = this._timeCount - 1;
            _loc_2._timeCount = _loc_3;
            return;
        }// end function

        private function addlisteners() : void
        {
            this._continueBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._rechargeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._rechargeBtn:
                {
                    MapControl.getInstance().showRecharge();
                    break;
                }
                case this._continueBtn:
                {
                    if (this._recommand.parent)
                    {
                        if (this._recommand.parent)
                        {
                            this._recommand.parent.removeChild(this._recommand);
                        }
                    }
                    else
                    {
                        addChild(this._recommand);
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

        private function resetMc() : void
        {
            if (this._recommand.parent)
            {
                this._recommand.parent.removeChild(this._recommand);
            }
            return;
        }// end function

        public function closeRecommand() : void
        {
            TweenLite.killTweensOf(this._recommand);
            TweenLite.to(this._recommand, 0.4, {delay:0, onComplete:this.resetMc, alpha:0.1});
            return;
        }// end function

        private function initView() : void
        {
            return;
        }// end function

        private function update() : void
        {
            if (this._info && this._info.stageLevel != 0)
            {
                this._mcVip.filters = [];
                if (this._info.stageLevel == VipConst.MONTH_LEVEL || this._info.stageLevel == VipConst.EXPERIENCE_LEVEL || this._info.stageLevel == VipConst.MONTHES_LEVEL)
                {
                    this._stageLevelVip.gotoAndStop(2);
                }
                else
                {
                    this._stageLevelVip.gotoAndStop(1);
                }
                this._levelVip.gotoAndStop((this._info.level + 1));
                this._stripe.setValue(this._info.exp, VipCfgObj.getInstance().getVipExp(this._info.realLevel));
                this._stripe.filters = [];
                this._lastTime.visible = true;
                this._timeCount = VipModel.getInstance().getCount();
                this._lastTimeId = TimerManager.registerTimer(1, this._timeCount, this.refreshTime);
                if (this._info.stageLevel == VipConst.YEAR_LEVEL)
                {
                    this._expPoint = 15;
                }
                else
                {
                    this._expPoint = 10;
                }
                this.refreshTime(null);
            }
            else
            {
                this._levelVip.gotoAndStop(1);
                this._stageLevelVip.gotoAndStop(2);
                this._mcVip.filters = [FrameworkGlobal.colorMat];
                this._lastTime.visible = false;
                if (this._info.realLevel == 0)
                {
                    this._stripe.setValue(this._info.exp, VipCfgObj.getInstance().getVipExp(1));
                }
                else
                {
                    this._stripe.setValue(this._info.exp, VipCfgObj.getInstance().getVipExp(this._info.realLevel));
                }
                this._stripe.filters = [FrameworkGlobal.colorMat];
            }
            this._sheet.visible = true;
            this._sheet.x = this._scrollpanel.x + 112 + 56 * (this._info.level - 1);
            this._welcomeTxt.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12294"), [this._info.realLevel]);
            return;
        }// end function

    }
}
