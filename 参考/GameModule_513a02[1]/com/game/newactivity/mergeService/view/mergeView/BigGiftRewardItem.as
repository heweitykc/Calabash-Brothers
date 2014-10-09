package com.game.newactivity.mergeService.view.mergeView
{
    import com.cfg.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.map.control.*;
    import com.game.newactivity.control.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class BigGiftRewardItem extends Component
    {
        private var _info:NewActivityItemInfo;
        private var icon_sign:MovieClip;
        private var _itemList:Array;
        private var btn_get_gift:BaseButton;
        private var txt_rechange:BaseButton;
        public static const MAX_REWARD_COUNT:int = 5;

        public function BigGiftRewardItem(param1 = null, param2:String = null)
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            super(param1, param2);
            this.icon_sign = getDisplayChildByName("icon_sign");
            this.icon_sign.mouseEnabled = false;
            this.icon_sign.mouseChildren = false;
            this.icon_sign.stop();
            this._itemList = [];
            var _loc_3:* = 0;
            while (_loc_3 < MAX_REWARD_COUNT)
            {
                
                _loc_4 = getDisplayChildByName("icon_bg_" + _loc_3);
                _loc_5 = _loc_4.x;
                _loc_6 = _loc_4.y;
                _loc_7 = _loc_4.width;
                _loc_8 = _loc_4.height;
                _loc_9 = _loc_4.parent;
                _loc_10 = _loc_9.getChildIndex(_loc_4);
                _loc_11 = new IconItem(_loc_4);
                _loc_11.move(_loc_5, _loc_6);
                _loc_11.setWH(_loc_7, _loc_8);
                _loc_11.setImageSize(_loc_7, _loc_8);
                _loc_9.addChildAt(_loc_11, _loc_10);
                this._itemList[_loc_3] = _loc_11;
                _loc_3++;
            }
            this.btn_get_gift = new BaseButton(getDisplayChildByName("btn_get_gift"));
            this.txt_rechange = new BaseButton(getDisplayChildByName("txt_rechange"));
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            if (param2.activityItemLists && param2.activityItemLists.length)
            {
                this._info = param2.activityItemLists[0];
                this.updateItems();
                if (this._info.canGet != ActivityStateCfg.ALLOW_PICK)
                {
                    this.btn_get_gift.addEvtListener(MouseEvent.CLICK, this.onPickGiftHandler);
                    this.btn_get_gift.filters = [FrameworkGlobal.colorMat];
                }
                else
                {
                    this.btn_get_gift.addEvtListener(MouseEvent.CLICK, this.onPickGiftHandler);
                    this.btn_get_gift.filters = [];
                }
                this.txt_rechange.addEvtListener(MouseEvent.CLICK, this.onRecargeHandler);
            }
            return;
        }// end function

        private function updateItems() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < MAX_REWARD_COUNT)
            {
                
                _loc_2 = this._itemList[_loc_1];
                _loc_3 = this._info.awardList[_loc_1];
                _loc_2.setInfo(_loc_3);
                _loc_2.visible = _loc_3 != null;
                _loc_1++;
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            this.btn_get_gift.removeEvtListener(MouseEvent.CLICK, this.onPickGiftHandler);
            this.txt_rechange.removeEvtListener(MouseEvent.CLICK, this.onRecargeHandler);
            return;
        }// end function

        private function onPickGiftHandler(event:MouseEvent) : void
        {
            NewActivityControl.getInstance().getActivityReward(this._info.activityId, this._info.index);
            return;
        }// end function

        private function onRecargeHandler(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            return;
        }// end function

    }
}
