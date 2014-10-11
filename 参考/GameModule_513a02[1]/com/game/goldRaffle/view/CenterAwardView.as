package com.game.goldRaffle.view
{
    import __AS3__.vec.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.goldRaffle.view.component.*;
    import com.util.*;
    import flash.events.*;

    public class CenterAwardView extends BaseSprite
    {
        private var awardList:Vector.<Lottery>;
        private var effectX:int;
        private var effectY:int;

        public function CenterAwardView()
        {
            this.awardList = LotteryCfgObj.getInstance().getLotteryList();
            this.initRoundView();
            this.initCenterView();
            return;
        }// end function

        private function initRoundView() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = this.awardList.length;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_2 < 18 && _loc_2 < _loc_1)
            {
                
                _loc_5 = new RaffleBoxItem();
                _loc_5.info = PropUtil.createItemByCfg(this.awardList[_loc_2].lottery_item_id);
                _loc_5._x = _loc_3;
                _loc_5._y = _loc_4;
                addChild(_loc_5);
                if (_loc_2 < 6)
                {
                    _loc_3 = _loc_3 + 61;
                }
                else if (_loc_2 < 9)
                {
                    _loc_4 = _loc_4 + 56;
                }
                else if (_loc_2 < 15)
                {
                    _loc_3 = _loc_3 - 61;
                }
                else
                {
                    _loc_4 = _loc_4 - 56;
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function initCenterView() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = this.awardList.length;
            var _loc_2:* = 18;
            var _loc_3:* = 67;
            var _loc_4:* = 58;
            while (_loc_2 < 21 && _loc_2 < _loc_1)
            {
                
                _loc_5 = new RaffleBoxItem("goldraffle_item_bg");
                _loc_5.setWH(82, 92);
                _loc_5.info = PropUtil.createItemByCfg(this.awardList[_loc_2].lottery_item_id);
                _loc_5._x = _loc_3;
                _loc_5._y = _loc_4;
                _loc_5.image.move(14, 19);
                if (_loc_2 == 19)
                {
                    this.effectX = _loc_3 + 41;
                    this.effectY = _loc_4 + 46;
                }
                _loc_3 = _loc_3 + 95;
                addChild(_loc_5);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function doEffect() : void
        {
            var _loc_1:* = new VMCView();
            _loc_1._x = this.effectX;
            _loc_1._y = this.effectY;
            _loc_1.loadRes("res/effect/goldRaffle_effect.png");
            _loc_1.auto = true;
            _loc_1.updatePose();
            _loc_1.addEvtListener(Event.COMPLETE, this.__fadeout);
            addChild(_loc_1);
            return;
        }// end function

        private function __fadeout(event:Event) : void
        {
            var _loc_2:* = event.target as VMCView;
            if (_loc_2)
            {
                if (_loc_2.parent)
                {
                    _loc_2.stop();
                    removeChild(_loc_2);
                }
                _loc_2.finalize();
            }
            return;
        }// end function

    }
}
