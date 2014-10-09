package com.game.newactivity.moonFestival.view
{
    import __AS3__.vec.*;
    import com.events.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.model.*;
    import com.game.newactivity.moonFestival.control.*;
    import com.game.newactivity.moonFestival.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.utils.*;

    public class MoonFestivalPanel extends BaseBox
    {
        private var moon1:MoonDiceView;
        private var moon2:MoonBossView;
        private var moon3:MoonCakeView;
        private var closeBtn:BaseButton;
        private var page_map:Dictionary;
        private var btnDic:Dictionary;
        private var ACTIVITY_MAP:Dictionary;
        private var _infoArr:Dictionary;
        private var _curSelIndex:int;

        public function MoonFestivalPanel()
        {
            this.ACTIVITY_MAP = new Dictionary();
            this.ACTIVITY_MAP[1] = NewActivityConfig.ACTID_MOONFESTIVAL_1;
            this.ACTIVITY_MAP[2] = NewActivityConfig.ACTID_MOONFESTIVAL_2;
            this.ACTIVITY_MAP[3] = NewActivityConfig.ACTID_MOONFESTIVAL_3;
            setWH(774, 550);
            _peaceBox = ["*"];
            loadDisplay("res/moonFestival.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("moonFestivalView");
            this.initUI();
            this.curSelIndex = this._curSelIndex;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_1:* = null;
            this._infoArr = new Dictionary();
            this.page_map = new Dictionary();
            this.moon1 = new MoonDiceView(getDisplayChildByName("item_1"));
            this.moon2 = new MoonBossView(getDisplayChildByName("item_2"));
            this.moon3 = new MoonCakeView(getDisplayChildByName("item_3"));
            this.page_map[1] = this.moon1;
            this.page_map[2] = this.moon2;
            this.page_map[3] = this.moon3;
            this.btnDic = new Dictionary();
            var _loc_2:* = 1;
            _loc_2 = 1;
            while (_loc_2 <= 3)
            {
                
                this.btnDic[_loc_2] = new BaseButton(getDisplayChildByName("btn" + _loc_2));
                this.btnDic[_loc_2].name = _loc_2;
                _loc_1 = NewActivityModel.getInstance().getActivityByActivityId(this.ACTIVITY_MAP[_loc_2]);
                if (!_loc_1.isDetailInit)
                {
                    NewActivityControl.getInstance().getActivityInfo(_loc_1.activityId);
                }
                _loc_1.addEventListener(NewActivityEvent.ACTIVITY_DETAIL_UPDATE, this.updateByActivityInfo);
                this._infoArr[_loc_2] = _loc_1;
                _loc_2++;
            }
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.__closeClickHandler);
            _loc_2 = 1;
            while (_loc_2 <= 3)
            {
                
                this.page_map[_loc_2].visible = false;
                _loc_2++;
            }
            this.addListener();
            return;
        }// end function

        private function addListener() : void
        {
            var _loc_1:* = 1;
            _loc_1 = 1;
            while (_loc_1 <= 3)
            {
                
                this.btnDic[_loc_1].addEventListener(MouseEvent.CLICK, this.clickBtnHandler);
                _loc_1++;
            }
            NewActivityModel.getInstance().addEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function _actDelHandler(event:NewActivityEvent) : void
        {
            if (int(event.data) == NewActivityConfig.GROUP_MOONFESTIVAL_ACT)
            {
                this.removeListener();
                this.close();
            }
            return;
        }// end function

        private function removeListener() : void
        {
            var _loc_1:* = 0;
            if (UILoaded)
            {
                _loc_1 = 1;
                _loc_1 = 1;
                while (_loc_1 <= 3)
                {
                    
                    this.btnDic[_loc_1].removeEventListener(MouseEvent.CLICK, this.clickBtnHandler);
                    _loc_1++;
                }
            }
            NewActivityModel.getInstance().removeEventListener(NewActivityEvent.ACTIVITY_GROUP_REMOVE, this._actDelHandler);
            return;
        }// end function

        private function clickBtnHandler(event:MouseEvent) : void
        {
            var _loc_2:* = int(event.currentTarget.name);
            this.curSelIndex = _loc_2;
            this.dicOpenReq();
            return;
        }// end function

        private function __closeClickHandler(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.dicOpenReq();
            }
            return;
        }// end function

        private function dicOpenReq() : void
        {
            if (this.isDiceActivate)
            {
                MoonFestivalControl.getInstance().openDiceReq();
            }
            return;
        }// end function

        public function get curSelIndex() : int
        {
            return this._curSelIndex;
        }// end function

        public function set curSelIndex(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            if (!UILoaded)
            {
                this._curSelIndex = param1;
                return;
            }
            if (this.btnDic[this._curSelIndex])
            {
                _loc_2 = this.btnDic[this._curSelIndex];
                _loc_2.selected = false;
                _loc_2.enabled = true;
            }
            this._curSelIndex = param1;
            _loc_2 = this.btnDic[this._curSelIndex];
            if (!_loc_2)
            {
                return;
            }
            _loc_2.selected = true;
            _loc_2.enabled = false;
            _loc_3 = 1;
            while (_loc_3 <= 3)
            {
                
                this.page_map[_loc_3].visible = false;
                _loc_3++;
            }
            NewActivityControl.getInstance().getActivityInfo(this._infoArr[this._curSelIndex].activityId);
            this.updateByIndex();
            return;
        }// end function

        private function updateByActivityInfo(event:NewActivityEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.data as NewActivityInfo;
            if (UILoaded && _loc_2 && _loc_2.isDetailInit && _loc_2.activityId == this.ACTIVITY_MAP[this._curSelIndex])
            {
                if (!this.btnDic[this._curSelIndex])
                {
                    return;
                }
                _loc_3 = this._infoArr[this._curSelIndex];
                if (!_loc_3 || !_loc_3.isDetailInit)
                {
                    return;
                }
                this.updateByIndex();
                this.page_map[this._curSelIndex].visible = true;
            }
            return;
        }// end function

        public function createDiceRankTips() : void
        {
            if (this.isDiceActivate)
            {
                (this.page_map[1] as MoonDiceView).createRankTips();
            }
            return;
        }// end function

        public function doDiceResult(param1:int) : void
        {
            if (this.isDiceActivate)
            {
                if (MoonDiceModel.getInstance().opertype != MoonDiceModel.GET_INFO)
                {
                    (this.page_map[1] as MoonDiceView).showResult(param1);
                }
                else
                {
                    MoonDiceModel.getInstance().lastResult = param1;
                    (this.page_map[1] as MoonDiceView).showDice();
                }
            }
            else
            {
                MoonDiceModel.getInstance().lastResult = param1;
            }
            return;
        }// end function

        public function showDiceInfo() : void
        {
            if (this.isDiceActivate)
            {
                (this.page_map[1] as MoonDiceView).showInfo();
                (this.page_map[1] as MoonDiceView).updateBtnStatus();
            }
            return;
        }// end function

        public function get isDiceActivate() : Boolean
        {
            return this.page_map[1] && this.page_map[1] is MoonDiceView && this._curSelIndex == 1;
        }// end function

        private function updateByIndex() : void
        {
            if (!UILoaded)
            {
                return;
            }
            if (this.btnDic[this._curSelIndex] == -1)
            {
                return;
            }
            var _loc_1:* = this._infoArr[this._curSelIndex];
            if (!_loc_1 || !_loc_1.isDetailInit)
            {
                return;
            }
            IMoonFestivalView(this.page_map[this._curSelIndex]).updateByActInfo(_loc_1);
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            if (this.page_map[1] && this.page_map[1] is MoonDiceView)
            {
                (this.page_map[1] as MoonDiceView).clear();
            }
            return;
        }// end function

        public function setPainInfo(param1:int, param2:Vector.<ItemInfo>) : void
        {
            if (this.moon3)
            {
                this.moon3.setPainInfo(param1, param2);
            }
            return;
        }// end function

    }
}
