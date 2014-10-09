package com.game.goldRaffle.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.goldRaffle.bean.*;
    import com.game.goldRaffle.message.*;
    import com.game.goldRaffle.protocol.*;
    import com.game.goldRaffle.view.*;
    import com.game.map.control.*;
    import com.game.protect.control.*;
    import com.model.*;
    import flash.geom.*;

    public class GoldRaffleControl extends Object
    {
        private var _protocol:GoldRaffleProtocol;
        public var rewardslist:Vector.<GoldRaffleGridInfo>;
        public var expExchangelist:Array;
        public var loglist:Vector.<GoldRaffleEventInfo>;
        public var rafflesExp:int;
        public var lotteryTicket:int;
        public var chestsCapacity:int = 0;
        public const CHESTS_MAX_CAPACITY:int = 1000;
        private var _goldRafflesPanel:GoldRafflesPanel;
        private var _treasureHoursePanel:TreasureHousePanel;
        private var _rafflesExpExchangePanel:RafflesExpExchangePanel;
        private static var _instance:GoldRaffleControl;

        public function GoldRaffleControl()
        {
            this._protocol = new GoldRaffleProtocol();
            return;
        }// end function

        private function initGoldRafflesPanel() : GoldRafflesPanel
        {
            if (!this._goldRafflesPanel)
            {
                this._goldRafflesPanel = new GoldRafflesPanel();
                Global.popManager.addPop(this._goldRafflesPanel);
            }
            return this._goldRafflesPanel;
        }// end function

        private function initTreasureHoursePanel() : TreasureHousePanel
        {
            if (!this._treasureHoursePanel && this._goldRafflesPanel)
            {
                this._treasureHoursePanel = new TreasureHousePanel();
                this._treasureHoursePanel.setRealitiveBtn(this._goldRafflesPanel.treasureHouseBtn);
                Global.popManager.addPop(this._treasureHoursePanel);
            }
            return this._treasureHoursePanel;
        }// end function

        private function initRafflesExpExchangePanel() : RafflesExpExchangePanel
        {
            if (!this._rafflesExpExchangePanel)
            {
                this._rafflesExpExchangePanel = new RafflesExpExchangePanel();
                Global.popManager.addPop(this._rafflesExpExchangePanel);
            }
            return this._rafflesExpExchangePanel;
        }// end function

        public function openRafflesOrClosePanel() : void
        {
            if (!this._goldRafflesPanel)
            {
                this.initGoldRafflesPanel();
            }
            this._goldRafflesPanel.openOrClose();
            return;
        }// end function

        public function openOrCloseTreasureHousePanel() : void
        {
            this.initTreasureHoursePanel().openOrClose();
            return;
        }// end function

        public function openOrCloseRafflesExpExchangePanel() : void
        {
            this.initRafflesExpExchangePanel().openOrClose();
            return;
        }// end function

        public function updateFraction(param1:int) : void
        {
            this.rafflesExp = param1;
            if (this._rafflesExpExchangePanel)
            {
                this._rafflesExpExchangePanel.updateInfo();
            }
            if (this._goldRafflesPanel)
            {
                this._goldRafflesPanel.updateTaffleExp();
            }
            return;
        }// end function

        public function updateLogList(param1:Vector.<GoldRaffleEventInfo>) : void
        {
            this.loglist = param1;
            return;
        }// end function

        public function updateChestsCapacity() : void
        {
            if (this._goldRafflesPanel)
            {
                this._goldRafflesPanel.updateInfo();
            }
            if (this._goldRafflesPanel)
            {
                this._treasureHoursePanel.updateCapacity();
            }
            return;
        }// end function

        public function updateLotteryTicket(param1:int) : void
        {
            this.lotteryTicket = param1;
            return;
        }// end function

        public function reqGoldRaffle(param1:int) : Boolean
        {
            var _loc_2:* = {GOLD1:1, GOLD2:10, GOLD3:50};
            var _loc_3:* = {GOLD1:50, GOLD2:500, GOLD3:2500};
            var _loc_4:* = _loc_3["GOLD" + param1] - _loc_3["GOLD" + param1] / _loc_2["GOLD" + param1] * this.lotteryTicket;
            if (_loc_3["GOLD" + param1] - _loc_3["GOLD" + param1] / _loc_2["GOLD" + param1] * this.lotteryTicket < 0)
            {
                _loc_4 = 0;
            }
            if (!UserObj.getInstance().chechGoldEnough(_loc_4))
            {
                MapControl.getInstance().showRechargeD();
                return false;
            }
            if (ProtectControl.getInstance().promptIfLocked())
            {
                return false;
            }
            this._protocol.reqGoldRaffleToServer(param1);
            return true;
        }// end function

        public function reqOpenGoldRaffleBoxInfo() : void
        {
            this._protocol.reqOpenGoldRaffleBoxInfoToServer();
            return;
        }// end function

        public function reqFraction(param1:int) : void
        {
            this._protocol.reqFractionToServer(param1);
            return;
        }// end function

        public function reqOpenRaffleInfo() : void
        {
            this._protocol.reqOpenRaffleInfoToServer();
            return;
        }// end function

        public function reqGoldRaffleBoxUseItemToServer(param1:int = -1, param2:int = 2) : void
        {
            this._protocol.reqGoldRaffleBoxUseItemToServer(param1, param2);
            return;
        }// end function

        public function updateGoldRafflesPanel() : void
        {
            if (this._goldRafflesPanel)
            {
                this._goldRafflesPanel.updateInfo();
            }
            return;
        }// end function

        public function updateTreasureHousePanel() : void
        {
            if (this._treasureHoursePanel)
            {
                this._treasureHoursePanel.updateInfo();
            }
            return;
        }// end function

        public function openTreasureHousePanel() : void
        {
            this.initTreasureHoursePanel().open();
            return;
        }// end function

        public function closeTreasureHousePanel() : void
        {
            if (this._treasureHoursePanel)
            {
                this._treasureHoursePanel.close();
            }
            return;
        }// end function

        public function continueRaffle() : void
        {
            if (this._goldRafflesPanel && !this._goldRafflesPanel.isOpen)
            {
                this._goldRafflesPanel.open();
            }
            if (this._rafflesExpExchangePanel)
            {
                this._rafflesExpExchangePanel.close();
            }
            return;
        }// end function

        public function doAnonationFly(param1:Vector.<int>, param2:Vector.<int>) : void
        {
            if (!this._goldRafflesPanel)
            {
                return;
            }
            var _loc_3:* = new Array();
            var _loc_4:* = 0;
            while (_loc_4 < param2.length)
            {
                
                _loc_3.push(param2[_loc_4]);
                _loc_4++;
            }
            var _loc_5:* = this._goldRafflesPanel.localToGlobal(new Point(100, 200));
            MapControl.getInstance().flashToMail(_loc_3, _loc_5);
            return;
        }// end function

        public function doFractionItemFly(param1:ResGoldRaffleBoxUseItemToClientMessage) : void
        {
            if (param1.isSuccess == 1)
            {
                if (this._rafflesExpExchangePanel)
                {
                    this._rafflesExpExchangePanel.itemFlayToBack(param1.grididx);
                }
            }
            return;
        }// end function

        public function addLogEvent(param1:GoldRaffleEventInfo) : void
        {
            if (this.loglist == null)
            {
                this.loglist = new Vector.<GoldRaffleEventInfo>;
            }
            this.loglist.push(param1);
            if (this.loglist.length > 100)
            {
                this.loglist = this.loglist.slice(this.loglist.length - 50, this.loglist.length);
            }
            return;
        }// end function

        public function addBoxes(param1:GoldRaffleBoxInfo) : void
        {
            if (!this.rewardslist)
            {
                return;
            }
            this.rewardslist = this.rewardslist.concat(param1.goldRaffleGridList);
            if (this._treasureHoursePanel && this._treasureHoursePanel.isOpen)
            {
                this._treasureHoursePanel.addBoxes(param1.goldRaffleGridList);
            }
            return;
        }// end function

        public function removeReward(param1:int, param2:int) : int
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (!this._treasureHoursePanel)
            {
                return -1;
            }
            if (param1 == -1)
            {
                this.rewardslist = new Vector.<GoldRaffleGridInfo>;
                this._treasureHoursePanel.updateInfo();
            }
            while (_loc_4 < this.rewardslist.length)
            {
                
                _loc_3 = this.rewardslist[_loc_4];
                if (_loc_3.grididx == param1)
                {
                    if (param2 == 2 || _loc_3.coupon.num.toNumber() == 1)
                    {
                        this.rewardslist = this.rewardslist.splice(0, this.rewardslist.length, _loc_3);
                        this._treasureHoursePanel.removeItem(param1, 2);
                    }
                    else if (param2 == 1)
                    {
                        this._treasureHoursePanel.removeItem(param1, 1);
                    }
                    return _loc_4;
                }
                _loc_4++;
            }
            return -1;
        }// end function

        public function reqGoldRaffleBoxArrangeToServer() : void
        {
            this._protocol.reqGoldRaffleBoxArrangeToServer();
            return;
        }// end function

        public static function getInstance() : GoldRaffleControl
        {
            if (!_instance)
            {
                _instance = new GoldRaffleControl;
            }
            return _instance;
        }// end function

    }
}
