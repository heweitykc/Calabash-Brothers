package com.game.newactivity.mayactivity.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.mayactivity.view.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class MayOneGiftView extends Component implements IMayActView
    {
        private var _btnGetGift:BaseButton;
        private var _btnRechange:BaseButton;
        private var _info:NewActivityInfo;

        public function MayOneGiftView(param1 = null, param2:String = null)
        {
            initComponentUI(param1);
            this.displayReady();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnGetGift = new BaseButton(getDisplayChildByName("btn_get_gift"));
            this._btnRechange = new BaseButton(getDisplayChildByName("txt_rechange"));
            var _loc_1:* = MovieClip(getDisplayChildByName("icon_sign"));
            _loc_1.gotoAndStop(1);
            _loc_1.mouseEnabled = false;
            this.initItem();
            return;
        }// end function

        private function initItem() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = GlobalCfgObj.getInstance().getMayOneGeftAward();
            var _loc_2:* = _loc_1.split(";");
            var _loc_5:* = 0;
            while (_loc_5 < 5)
            {
                
                _loc_3 = getDisplayChildByName("icon_bg_" + _loc_5);
                _loc_6 = new IconItem(null);
                _loc_3.addChild(_loc_6);
                _loc_4 = String(_loc_2[_loc_5]).split("_");
                _loc_7 = PropUtil.createItemByCfg(_loc_4[0]);
                _loc_7.num = int(_loc_4[1]);
                if (_loc_5 == 0)
                {
                    _loc_6.move(6, 5);
                    _loc_6.setWH(56, 56);
                    _loc_6.setImageSize(56, 56);
                }
                else
                {
                    _loc_6.setWH(46, 46);
                    _loc_6.image.move(4, 3);
                }
                _loc_7.isbind = 1;
                _loc_6.setInfo(_loc_7);
                _loc_5++;
            }
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            return;
        }// end function

        protected function mouseClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnGetGift:
                {
                    this.getGift();
                    break;
                }
                case this._btnRechange:
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

        private function getGift() : void
        {
            if (this._info)
            {
                NewActivityControl.getInstance().getActivityReward(this._info.activityId, this._info.activityItemLists[0].index);
            }
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            this._info = param1;
            if (this._info.activityItemLists[0].canGet == 1)
            {
                this._btnGetGift.filters = [];
            }
            else
            {
                this._btnGetGift.filters = [ColorFilter.getGrayFilter()];
            }
            return;
        }// end function

    }
}
