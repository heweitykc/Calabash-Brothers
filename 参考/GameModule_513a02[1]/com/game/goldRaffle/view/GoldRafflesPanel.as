package com.game.goldRaffle.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.game.goldRaffle.bean.*;
    import com.game.goldRaffle.control.*;
    import com.game.goldRaffle.view.component.*;
    import flash.events.*;
    import flash.text.*;

    public class GoldRafflesPanel extends BaseBox
    {
        private var btnClose:BaseButton;
        private var rafflesBtn1:BaseButton;
        private var rafflesBtn10:BaseButton;
        private var rafflesBtn50:BaseButton;
        private var _treasureHouseBtn:BaseButton;
        private var rafflesExpBtn:BaseButton;
        private var logEventList:List;
        private var couponTxt:TextField;
        private var raffleExpTxt:TextField;
        private var chestsCapacityTxt:TextField;
        private var cav:CenterAwardView;
        private var _grControl:GoldRaffleControl;
        private var flag_isIn:Boolean = false;
        public static const SWF:String = "res/goldRaffle.swf";

        public function GoldRafflesPanel()
        {
            _combinedBox = ["com.game.goldRaffle.view::RafflesExpExchangePanel", "com.game.goldRaffle.view::TreasureHousePanel", "com.game.challenge.view::BossGuidePanel"];
            var _loc_1:* = LotteryCfgObj.getInstance().getLotteryList();
            var _loc_2:* = new Array();
            var _loc_3:* = _loc_1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_2.push(ItemCfgObj.getInstance().getIconUrl(_loc_1[_loc_4].lottery_item_id));
                _loc_4++;
            }
            _loc_2.push(SWF);
            loadDisplay(_loc_2);
            this._grControl = GoldRaffleControl.getInstance();
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("goldRaffles_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.rafflesBtn1 = new BaseButton(getDisplayChildByName("rafflesBtn1"));
            this.rafflesBtn10 = new BaseButton(getDisplayChildByName("rafflesBtn10"));
            this.rafflesBtn50 = new BaseButton(getDisplayChildByName("rafflesBtn50"));
            this._treasureHouseBtn = new BaseButton(getDisplayChildByName("treasureHouseBtn"), true);
            this.rafflesExpBtn = new BaseButton(getDisplayChildByName("rafflesExpBtn"));
            this.couponTxt = getDisplayChildByName("couponTxt");
            this.raffleExpTxt = getDisplayChildByName("raffleExpTxt");
            StringTip.create(this.raffleExpTxt, LanguageCfgObj.getInstance().getByIndex("10705"));
            this.chestsCapacityTxt = getDisplayChildByName("chestsCapacityTxt");
            this.logEventList = new List(307, 220);
            this.logEventList.cellRenderer = LogEventItem;
            this.logEventList.move(510, 99);
            this.addChild(this.logEventList);
            this.cav = new CenterAwardView();
            this.cav.move(51, 120);
            addChild(this.cav);
            var _loc_1:* = new VMCView();
            _loc_1.loadRes("res/effect/zones/zonesgetgift.png", null, true);
            _loc_1.auto = true;
            _loc_1.updatePose("90", true);
            _loc_1.move(65, 15);
            this.rafflesBtn1.addChild(_loc_1);
            _loc_1 = new VMCView();
            _loc_1.loadRes("res/effect/zones/zonesgetgift.png", null, true);
            _loc_1.auto = true;
            _loc_1.updatePose("90", true);
            _loc_1.move(65, 15);
            this.rafflesBtn10.addChild(_loc_1);
            _loc_1 = new VMCView();
            _loc_1.loadRes("res/effect/zones/zonesgetgift.png", null, true);
            _loc_1.auto = true;
            _loc_1.updatePose("90", true);
            _loc_1.move(65, 15);
            this.rafflesBtn50.addChild(_loc_1);
            _loc_1 = new VMCView();
            _loc_1.loadRes("res/effect/zones/zonesgetgift.png", null, true);
            _loc_1.auto = true;
            _loc_1.updatePose("90", true);
            _loc_1.move(75, 25);
            this.treasureHouseBtn.addChild(_loc_1);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.logEventList.addEvtListener(MouseEvent.MOUSE_OVER, this.__handlerLog);
            this.logEventList.addEvtListener(MouseEvent.MOUSE_OUT, this.__handlerLog);
            return;
        }// end function

        private function __handlerLog(event:MouseEvent) : void
        {
            if (event.type == MouseEvent.MOUSE_OVER)
            {
                this.flag_isIn = true;
            }
            else if (event.type == MouseEvent.MOUSE_OUT)
            {
                this.flag_isIn = false;
            }
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.rafflesBtn1:
                {
                    if (this._grControl.reqGoldRaffle(1))
                    {
                        this.cav.doEffect();
                        this._grControl.openTreasureHousePanel();
                    }
                    break;
                }
                case this.rafflesBtn10:
                {
                    if (this._grControl.reqGoldRaffle(2))
                    {
                        this.cav.doEffect();
                        this._grControl.openTreasureHousePanel();
                    }
                    break;
                }
                case this.rafflesBtn50:
                {
                    if (this._grControl.reqGoldRaffle(3))
                    {
                        this.cav.doEffect();
                        this._grControl.openTreasureHousePanel();
                    }
                    break;
                }
                case this.treasureHouseBtn:
                {
                    this._grControl.openOrCloseTreasureHousePanel();
                    break;
                }
                case this.rafflesExpBtn:
                {
                    this._grControl.openOrCloseRafflesExpExchangePanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            GoldRaffleControl.getInstance().reqOpenRaffleInfo();
            return;
        }// end function

        public function updateInfo() : void
        {
            if (UILoaded && isOpen)
            {
                this.couponTxt.text = this._grControl.lotteryTicket.toString();
                this.raffleExpTxt.text = this._grControl.rafflesExp.toString();
                this.chestsCapacityTxt.text = this._grControl.chestsCapacity + "/" + this._grControl.CHESTS_MAX_CAPACITY;
                if (!this.flag_isIn)
                {
                    this.updateLogEvent();
                }
            }
            return;
        }// end function

        private function updateLogEvent() : void
        {
            var _loc_1:* = this._grControl.loglist;
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = new Array();
            var _loc_4:* = _loc_2 - 30 > 0 ? (_loc_2 - 30) : (0);
            while (_loc_4 < _loc_2)
            {
                
                _loc_3.push(_loc_1[_loc_4]);
                _loc_4++;
            }
            this.logEventList.objs = _loc_3;
            this.logEventList.scrollToBottom();
            return;
        }// end function

        public function updateTaffleExp() : void
        {
            this.raffleExpTxt.text = this._grControl.rafflesExp.toString();
            return;
        }// end function

        public function flashAddTo(param1:Vector.<int>) : void
        {
            this._grControl.openTreasureHousePanel();
            this.cav.doEffect();
            return;
        }// end function

        public function addLogEvent(param1:GoldRaffleEventInfo) : void
        {
            this.logEventList.addObj(GoldRaffleEventInfo);
            this.logEventList.updateThumb();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            this.logEventList.reset();
            return;
        }// end function

        public function get treasureHouseBtn() : BaseButton
        {
            return this._treasureHouseBtn;
        }// end function

    }
}
