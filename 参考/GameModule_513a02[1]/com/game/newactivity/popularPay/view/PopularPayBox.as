package com.game.newactivity.popularPay.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class PopularPayBox extends BaseBox
    {
        private var _btnClose:BaseButton;
        private var _btnGotoPay:BaseButton;
        private var _btnGetGift:BaseButton;
        private var _stripPro1:Stripe;
        private var _info:NewActivityInfo;
        private var _txtCurrJoin:TextField;
        private var _downtime:DownTimer;
        private var _mcCardsCont:MovieClip;
        private var _hBox:HBox;
        private const TOTLE_POINTS:int = 7;
        private const TOTLE_CARDS:int = 4;
        private var _cardPoints:Vector.<Point>;
        private var _cards:Vector.<PopularPayCard>;
        private var _cardCurrent:PopularPayCard;
        private var _vecTimesMc:Vector.<MovieClip>;

        public function PopularPayBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this._cardPoints = new Vector.<Point>(this.TOTLE_POINTS);
            this._cards = new Vector.<PopularPayCard>(this.TOTLE_CARDS);
            this._vecTimesMc = new Vector.<MovieClip>(6);
            super(param1, param2, param3, param4);
            loadDisplay("res/popularpay.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("popular_pay");
            this.initUI();
            this.addEvents();
            this.initInfo();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_3:* = null;
            this._btnClose = new BaseButton(getDisplayChildByName("btn_close"));
            this._btnGotoPay = new BaseButton(getDisplayChildByName("btn_goto_pay"));
            this._btnGetGift = new BaseButton(getDisplayChildByName("btn_get_gift"));
            this._stripPro1 = new Stripe(getDisplayChildByName("strip_pro1"));
            this._txtCurrJoin = TextField(getDisplayChildByName("txt_curr_join"));
            this._mcCardsCont = MovieClip(getDisplayChildByName("mc_cards_cont"));
            this._downtime = new DownTimer();
            this._downtime.callBack = this.callDownTime;
            var _loc_1:* = getDisplayChildByName("mc_down_time");
            var _loc_2:* = 0;
            while (_loc_2 < 6)
            {
                
                _loc_3 = MovieClip(_loc_1.getChildByName("mc_time" + (_loc_2 + 1)));
                this._vecTimesMc[_loc_2] = _loc_3;
                _loc_3.gotoAndStop(1);
                _loc_2++;
            }
            this._hBox = new HBox();
            this._hBox.horizontal = true;
            this._hBox.intervalX = 18;
            this._hBox.oneRow = 5;
            this._hBox.move(303 - 117, 377 + 118);
            this.addChild(this._hBox);
            this.initCards();
            return;
        }// end function

        private function initCards() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this.TOTLE_POINTS)
            {
                
                _loc_2 = MovieClip(this._mcCardsCont.getChildByName("card_point_" + (_loc_1 + 1)));
                this._cardPoints[_loc_1] = new Point(_loc_2.x, _loc_2.y);
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this.TOTLE_CARDS)
            {
                
                this._cards[_loc_1] = new PopularPayCard(this._mcCardsCont.getChildByName("card_" + (_loc_1 + 1)));
                this._cards[_loc_1].index = _loc_1;
                this._cards[_loc_1].position = _loc_1;
                this._cards[_loc_1].x = this._cardPoints[_loc_1 + 3].x;
                this._cards[_loc_1].y = this._cardPoints[_loc_1 + 3].y;
                _loc_1++;
            }
            this._cardCurrent = this._cards[0];
            return;
        }// end function

        private function callDownTime() : void
        {
            var _loc_1:* = this._downtime.getTimeBySecond();
            var _loc_2:* = _loc_1.replace(":", "");
            _loc_2 = _loc_2.replace(":", "");
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                this._vecTimesMc[_loc_4].gotoAndStop((int(_loc_2.substr(_loc_4, 1)) + 1));
                _loc_4++;
            }
            return;
        }// end function

        private function initInfo() : void
        {
            this._info = NewActivityModel.getInstance().getActivityByActivityId(NewActivityConfig.ACTID_POPULAR_PAY);
            if (!this._info.isDetailInit)
            {
                NewActivityControl.getInstance().getActivityInfo(this._info.activityId);
            }
            this._info.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            NewActivityControl.getInstance().getActivityInfo(NewActivityConfig.ACTID_POPULAR_PAY);
            return;
        }// end function

        protected function mouseClick(event:MouseEvent) : void
        {
            if (event.target is PopularPayCard)
            {
                this.clickCard(event.target as PopularPayCard);
                return;
            }
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._btnGetGift:
                {
                    this.getGift();
                    break;
                }
                case this._btnGotoPay:
                {
                    MapControl.getInstance().showRecharge();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function clickCard(param1:PopularPayCard) : void
        {
            var point:Point;
            var card:* = param1;
            this._cardCurrent = card;
            this._mcCardsCont.mouseEnabled = false;
            TweenLite.delayedCall(1.5, function () : void
            {
                _mcCardsCont.mouseEnabled = true;
                return;
            }// end function
            );
            var move:* = card.position;
            var tempI:int;
            while (tempI < 4)
            {
                
                this._cards[tempI].position = this._cards[tempI].position - move;
                tempI = (tempI + 1);
            }
            this.sortCards();
            tempI;
            while (tempI < 4)
            {
                
                point = this._cardPoints[this._cards[tempI].position + 3];
                TweenLite.to(this._cards[tempI], 0.3, {x:point.x, y:point.y});
                tempI = (tempI + 1);
            }
            this.freshPanel();
            return;
        }// end function

        private function sortCards() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = this._cards.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = 0;
                while (_loc_3 < _loc_1)
                {
                    
                    _loc_4 = this._cards[_loc_2];
                    _loc_5 = this._cards[_loc_3];
                    if (Math.abs(_loc_4.position) > Math.abs(_loc_5.position))
                    {
                        if (this._mcCardsCont.getChildIndex(_loc_4) > this._mcCardsCont.getChildIndex(_loc_5))
                        {
                            this._mcCardsCont.swapChildren(_loc_4, _loc_5);
                        }
                    }
                    _loc_3++;
                }
                _loc_2++;
            }
            if (this._cardCurrent)
            {
                this._mcCardsCont.setChildIndex(this._cardCurrent, (this._mcCardsCont.numChildren - 1));
            }
            return;
        }// end function

        private function freshPanel() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            if (this._cardCurrent)
            {
                _loc_1 = this._cardCurrent.index;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.TOTLE_CARDS)
            {
                
                _loc_2 = this._info.activityItemLists[_loc_3];
                this._cards[_loc_3].state = _loc_2.canGet;
                _loc_3++;
            }
            var _loc_4:* = this._info.activityItemLists.length;
            var _loc_5:* = NewActivityItemInfo(this._info.activityItemLists[(_loc_4 - 1)]).condiction.split("|")[1];
            var _loc_6:* = int(this._info.otherInfo);
            this._txtCurrJoin.text = _loc_6.toString();
            this._stripPro1.setValue(_loc_6, 120);
            this._downtime.count = this._info.endTime * 1000 - ToolKit.getServerTime();
            if (this._info.activityItemLists[_loc_1].canGet == 0)
            {
                this._btnGetGift.filters = [];
            }
            else if (this._info.activityItemLists[_loc_1].canGet == 1)
            {
                this._btnGetGift.filters = [];
            }
            else if (this._info.activityItemLists[_loc_1].canGet == 2)
            {
                this._btnGetGift.filters = [ColorFilter.getGrayFilter()];
            }
            if (this._info.activityItemLists[0].canGet == 0)
            {
                this._btnGotoPay.visible = true;
                this._btnGetGift.visible = false;
            }
            else
            {
                this._btnGotoPay.visible = false;
                this._btnGetGift.visible = true;
            }
            this.freshAwards();
            return;
        }// end function

        private function freshAwards() : void
        {
            var _loc_1:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this._info)
            {
                return;
            }
            this._hBox.reset();
            var _loc_2:* = 0;
            if (this._cardCurrent)
            {
                _loc_2 = this._cardCurrent.index;
            }
            _loc_1 = this._info.activityItemLists[_loc_2];
            var _loc_3:* = _loc_1.awardList.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = new IconItem("commonRewardBox2_40");
                _loc_6 = _loc_1.awardList[_loc_4];
                _loc_5.image.move(4, 3);
                _loc_5.setWH(46, 46);
                _loc_5.setInfo(_loc_6);
                this._hBox.add(_loc_5);
                _loc_4++;
            }
            return;
        }// end function

        private function getGift() : void
        {
            var _loc_1:* = 0;
            if (this._info)
            {
                _loc_1 = 0;
                if (this._cardCurrent)
                {
                    _loc_1 = this._cardCurrent.index;
                }
                NewActivityControl.getInstance().getActivityReward(this._info.activityId, this._info.activityItemLists[_loc_1].index);
            }
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            this._info = param1;
            this.updateCards();
            return;
        }// end function

        private function updateByActivityInfo(event:NewActivityEvent) : void
        {
            this._info = event.data as NewActivityInfo;
            this.updateCards();
            return;
        }// end function

        private function updateCards() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this.TOTLE_CARDS)
            {
                
                _loc_2 = this._info.activityItemLists[_loc_3];
                if (_loc_2.canGet != 2)
                {
                    _loc_1 = _loc_3;
                    this._cards[_loc_3].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    break;
                }
                _loc_3++;
            }
            this.freshPanel();
            return;
        }// end function

    }
}
