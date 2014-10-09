package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.image.*;
    import com.f1.ui.stripe.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.vip.bean.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import com.game.vip.model.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VIPPanel extends BaseBox
    {
        private var _vipBtn:BaseButton;
        private var _stripe:Stripe;
        private var _selectedEffect:VMCView;
        private var _lastTime:TextField;
        private var _levelTxt:TextField;
        private const YEAR:int = 3;
        private const MONTHS:int = 2;
        private const MONTH:int = 1;
        private var TEMPLETE:String;
        private var _linkTxt:TextField;
        private var _yearBtn:VIPcard;
        private var _monthesBtn:VIPcard;
        private var _monthBtn:VIPcard;
        private var _curBtn:VIPcard;
        private var _opBtn:BaseButton;
        private var _friendname:String;
        private var _helpBtn:BaseButton;
        private var _type:int;
        private var _cardType:int;
        private var _cardTab:HBox;
        private var _info:VipInfo;
        private var _image:Image;
        private var _pic:Image;
        private var _powerCard:VipInfoCard;
        private var _moneyCard:VipInfoCard;
        private var _influenceCard:VipInfoCard;
        private var _reputationCard:VipInfoCard;
        private var _rechargeBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _lastTimeId:String;
        private var _timeTxt:TextField;

        public function VIPPanel()
        {
            this.TEMPLETE = LanguageCfgObj.getInstance().getByIndex("11405");
            super.loadDisplay("res/vippanel.swf");
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

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get curBtn() : VIPcard
        {
            return this._curBtn;
        }// end function

        public function set curBtn(param1:VIPcard) : void
        {
            var _loc_2:* = 0;
            this._curBtn = param1;
            switch(this._curBtn)
            {
                case this._yearBtn:
                {
                    this._cardType = this.YEAR;
                    _loc_2 = 4;
                    break;
                }
                case this._monthesBtn:
                {
                    this._cardType = this.MONTHS;
                    _loc_2 = 2;
                    break;
                }
                case this._monthBtn:
                {
                    this._cardType = this.MONTH;
                    _loc_2 = 1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.showInfo();
            if (this._yearBtn != this.curBtn)
            {
                this._yearBtn.select = false;
            }
            if (this._monthesBtn != this.curBtn)
            {
                this._monthesBtn.select = false;
            }
            if (this._monthBtn != this.curBtn)
            {
                this._monthBtn.select = false;
            }
            this.curBtn.select = true;
            StringTip.create(this._linkTxt, VIPShowCfgObj.getInstance().getProfession(_loc_2));
            this._selectedEffect.move(_loc_3.x + _loc_3.width * 0.5, _loc_3.y + _loc_3.height * 0.5);
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("vippanel");
            this.initUI();
            this.addlistener();
            this.curBtn = this._yearBtn;
            this._cardTab.addChild(this._selectedEffect);
            this._type = 1;
            if (VIPControl.getInstance().vipinfo)
            {
                this.info = VIPControl.getInstance().vipinfo;
            }
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._pic = new Image();
            this._pic.move(48, 41);
            this._pic.scaleX = 0.8;
            this._pic.scaleY = 0.8;
            this._pic.load(UserObj.getInstance().playerInfo.headPic, this.onPic);
            addChild(this._pic);
            this._cardTab = new HBox();
            this._cardTab.intervalX = 12;
            this._cardTab.horizontal = true;
            this._yearBtn = new VIPcard(getDisplayChildByName("btn_year"), this.YEAR);
            this._cardTab.move(this._yearBtn.x, this._yearBtn.y);
            this._cardTab.add(this._yearBtn);
            this._monthesBtn = new VIPcard(getDisplayChildByName("btn_monthes"), this.MONTHS);
            this._cardTab.add(this._monthesBtn);
            this._monthBtn = new VIPcard(getDisplayChildByName("btn_month"), this.MONTH);
            this._cardTab.add(this._monthBtn);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            addChild(this._cardTab);
            this._selectedEffect = new VMCView();
            this._selectedEffect.auto = true;
            this._selectedEffect.updatePose("90", true);
            this._selectedEffect.loadRes("res/effect/vipselected.png");
            this._rechargeBtn = new BaseButton(getDisplayChildByName("btn_recharge"));
            this._powerCard = new VipInfoCard(getDisplayChildByName("pic_1"));
            this._moneyCard = new VipInfoCard(getDisplayChildByName("pic_2"));
            this._influenceCard = new VipInfoCard(getDisplayChildByName("pic_3"));
            this._reputationCard = new VipInfoCard(getDisplayChildByName("pic_4"));
            this._powerCard.type = VipInfoCard.POWER;
            this._moneyCard.type = VipInfoCard.MONEY;
            this._influenceCard.type = VipInfoCard.INFLUENCE;
            this._reputationCard.type = VipInfoCard.REPUTATION;
            this._lastTime = getDisplayChildByName("txt_time");
            this._lastTime.htmlText = this.TEMPLETE.replace("{@}", UserObj.getInstance().playerInfo.name);
            this._opBtn = new BaseButton(getDisplayChildByName("btn_op"));
            this._helpBtn = new BaseButton(getDisplayChildByName("btn_caption"));
            this._vipBtn = new BaseButton(getDisplayChildByName("btn_vip"));
            this._linkTxt = new TextField();
            this._linkTxt.selectable = false;
            this._linkTxt.autoSize = "left";
            this._linkTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._linkTxt.textColor = 16766079;
            var _loc_1:* = this._linkTxt.defaultTextFormat;
            _loc_1.font = "SimSun";
            _loc_1.size = 12;
            this._linkTxt.defaultTextFormat = _loc_1;
            this._linkTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("11408");
            addChild(this._linkTxt);
            this._linkTxt.x = 604;
            this._linkTxt.y = 498;
            this._opBtn.visible = true;
            return;
        }// end function

        private function onPic(param1:BitmapData) : void
        {
            return;
        }// end function

        private function showInfo() : void
        {
            switch(this._cardType)
            {
                case this.YEAR:
                {
                    this.cardShow(4);
                    break;
                }
                case this.MONTHS:
                {
                    this.cardShow(2);
                    break;
                }
                case this.MONTH:
                {
                    this.cardShow(1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function cardShow(param1:int) : void
        {
            this._powerCard.showVIP(param1);
            this._moneyCard.showVIP(param1, 0.1);
            this._influenceCard.showVIP(param1, 0.2);
            this._reputationCard.showVIP(param1, 0.3);
            return;
        }// end function

        private function update() : void
        {
            if (this._info && this._info.stageLevel != 0)
            {
                if (this._info.stageLevel > VipConst.EXPERIENCE_LEVEL)
                {
                    this._opBtn.visible = false;
                }
                else
                {
                    this._opBtn.visible = true;
                }
            }
            else if (this._info.level != 0)
            {
                this._opBtn.visible = false;
            }
            else
            {
                this._opBtn.visible = true;
            }
            return;
        }// end function

        private function addlistener() : void
        {
            this._vipBtn.addEvtListener(MouseEvent.CLICK, this.__vipInfoClick);
            this._monthesBtn.addEvtListener(MouseEvent.CLICK, this.__cardClick);
            this._yearBtn.addEvtListener(MouseEvent.CLICK, this.__cardClick);
            this._monthBtn.addEvtListener(MouseEvent.CLICK, this.__cardClick);
            this._opBtn.addEvtListener(MouseEvent.CLICK, this.__opClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._helpBtn.addEvtListener(MouseEvent.CLICK, this.__helpClick);
            this._rechargeBtn.addEvtListener(MouseEvent.CLICK, this.__rechargeClick);
            return;
        }// end function

        private function __rechargeClick(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        private function __vipInfoClick(event:MouseEvent) : void
        {
            VIPControl.getInstance().openOrCloseInfoPanel(UserObj.getInstance().playerInfo.vipid);
            return;
        }// end function

        private function __cardClick(event:MouseEvent) : void
        {
            if (this.curBtn && this.curBtn != event.target)
            {
                this.curBtn.select = false;
            }
            this.curBtn = event.currentTarget as VIPcard;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.curBtn = this._yearBtn;
                this.type = 1;
                this.update();
            }
            return;
        }// end function

        private function __opClick(event:MouseEvent) : void
        {
            ClickStream.add(ClickStreamId.CLICK_Vip_LiJiKaiTong);
            if (this.curBtn.info.gold <= UserObj.getInstance().playerInfo.gold)
            {
                VIPControl.getInstance().openVip(this.type, this._cardType);
                VipModel.getInstance().isOpeningVip = true;
            }
            else
            {
                MapControl.getInstance().showRechargeD();
            }
            return;
        }// end function

        private function __helpClick(event:MouseEvent) : void
        {
            VIPControl.getInstance().openOrCloseCaptionPanel();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            TimerManager.killTimer(this._lastTimeId);
            return;
        }// end function

    }
}
