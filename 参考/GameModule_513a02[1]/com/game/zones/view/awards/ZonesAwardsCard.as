package com.game.zones.view.awards
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.bean.*;
    import com.game.zones.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class ZonesAwardsCard extends BaseButton
    {
        private var HIT_OPENCARD:String;
        private var _stateCard:int = 0;
        private var _index:int = 0;
        private var _card:MovieClip;
        private var _itemAward:IconItem;
        private static var isShowPopCue:Boolean = true;
        public static var countFreeCard:int;

        public function ZonesAwardsCard()
        {
            this.HIT_OPENCARD = LanguageCfgObj.getInstance().getByIndex("11487");
            this.initCard();
            this.addEvent();
            return;
        }// end function

        private function initCard() : void
        {
            this._card = ToolKit.getNew("card_image");
            this.addChild(this._card);
            this._itemAward = new IconItem(null);
            this._itemAward.setWH(40, 40);
            this._itemAward.y = 40;
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.mouseChildren = true;
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (this.stateCard == 1)
            {
                return;
            }
            var _loc_2:* = this.forFreeCount();
            if (countFreeCard == 0 && _loc_2 > 0)
            {
                ZonesControl.getInstance().reqSelectAward(this.index, 0);
            }
            else
            {
                if (!isShowPopCue)
                {
                    ZonesControl.getInstance().reqSelectAward(this.index, 0);
                    return;
                }
                _loc_4 = this.HIT_OPENCARD;
                _loc_3 = Math.pow(2, countFreeCard) * 10;
                _loc_4 = _loc_4.replace("[0]", _loc_2.toString());
                _loc_4 = _loc_4.replace("[1]", _loc_3.toString());
                Global.popManager.cue(_loc_4, "", null, this.callClickYes, null, 2, null, false, true, this.callCkeckFun, false);
            }
            event.stopPropagation();
            return;
        }// end function

        private function callCkeckFun(param1:Boolean) : void
        {
            isShowPopCue = !param1;
            return;
        }// end function

        private function callClickYes() : void
        {
            ZonesControl.getInstance().reqSelectAward(this.index, 0);
            return;
        }// end function

        private function forFreeCount() : int
        {
            var _loc_1:* = UserObj.getInstance().playerInfo.vipid;
            var _loc_2:* = VipCfgObj.getInstance().getVipInfo(_loc_1).q_lottery;
            return _loc_2;
        }// end function

        public function playOpenCard() : void
        {
            if (this.stateCard == 1)
            {
                return;
            }
            this.playEffect();
            this.stateCard = 1;
            var _loc_2:* = countFreeCard + 1;
            countFreeCard = _loc_2;
            return;
        }// end function

        private function playEffect() : void
        {
            this.rotationY = -180;
            TweenLite.to(this, 0.1, {rotationY:-90, onComplete:this.callBack});
            return;
        }// end function

        private function callBack() : void
        {
            if (this._itemAward)
            {
                addChild(this._itemAward);
                this._itemAward.x = -20;
            }
            TweenLite.to(this, 0.1, {rotationY:0});
            return;
        }// end function

        public function setInfo(param1:ItemInfo) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(param1.itemModelId);
            if (!PropUtil.isEquip(_loc_3.q_type))
            {
                _loc_2 = new PropInfo();
            }
            else
            {
                _loc_2 = new EquipmentInfo();
            }
            _loc_2.conv(param1);
            this._itemAward.setInfo(_loc_2);
            return;
        }// end function

        public function clean() : void
        {
            if (this._itemAward)
            {
                if (this._itemAward.parent)
                {
                    this._itemAward.parent.removeChild(this._itemAward);
                }
            }
            this.rotationY = -180;
            this.stateCard = 0;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get stateCard() : int
        {
            return this._stateCard;
        }// end function

        public function set stateCard(param1:int) : void
        {
            this._stateCard = param1;
            this._card.gotoAndStop(param1 == 0 ? (1) : (2));
            return;
        }// end function

    }
}
