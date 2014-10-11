package com.game.redfortress.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.redfortress.model.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesRedFortressTraceView extends Component
    {
        private var _rankList:BaseSprite;
        private var _txtDetail:TextField;
        private var _txtDowntime:TextField;
        private var _txtDownTimeTitle:TextField;
        private var _downtimer:DownTimer;
        private var _vecItems:Vector.<ZonesRedFortressTopItem>;
        private var _selfItem:ZonesRedFortressTopItem;
        private static var RANK_LIST_LENGTH:int = 5;

        public function ZonesRedFortressTraceView(param1 = null, param2:String = null)
        {
            super(param1, param2);
            loadDisplay("res/redfortressrank.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("redfortress_trace_view");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._txtDetail = TextField(getDisplayChildByName("txt_introduce_tips"));
            this._txtDowntime = TextField(getDisplayChildByName("txt_down_time"));
            this._txtDownTimeTitle = TextField(getDisplayChildByName("txtdowntime_title"));
            this._txtDownTimeTitle.visible = false;
            this._txtDetail.htmlText = LanguageCfgObj.getInstance().getByIndex("11114");
            this._vecItems = new Vector.<ZonesRedFortressTopItem>;
            this._rankList = new BaseSprite();
            this.addChild(this._rankList);
            this._rankList.move(16, 112);
            var _loc_1:* = 0;
            while (_loc_1 < RANK_LIST_LENGTH)
            {
                
                _loc_2 = new ZonesRedFortressTopItem(ZonesRedFortressTopItem.RANK_TRACE_ITEM);
                this._vecItems[_loc_1] = _loc_2;
                this._rankList.addChild(_loc_2);
                _loc_2.move(0, _loc_1 * _loc_2.height);
                _loc_1++;
            }
            this._selfItem = new ZonesRedFortressTopItem(ZonesRedFortressTopItem.RANK_TRACE_ITEM);
            this._selfItem.move(16, 287);
            this.addChild(this._selfItem);
            ItemTips.create(this._txtDetail, {}, ZonesRedFortressTraceTips);
            this._downtimer = new DownTimer();
            this._downtimer.callBack = this.callDownBack;
            this.freshView();
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            this.freshView();
            return;
        }// end function

        public function updateView() : void
        {
            this.freshView();
            return;
        }// end function

        private function freshView() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (!UILoaded)
            {
                return;
            }
            var _loc_1:* = ZonesRedfortressModel.getInstance().zonesRankList;
            if (_loc_1)
            {
                _loc_2 = _loc_1.length;
                _loc_3 = 0;
                while (_loc_3 < RANK_LIST_LENGTH)
                {
                    
                    if (_loc_3 < _loc_2)
                    {
                        this._vecItems[_loc_3].info = _loc_1[_loc_3];
                    }
                    else
                    {
                        this._vecItems[_loc_3].info = null;
                    }
                    _loc_3++;
                }
            }
            this._selfItem.info = ZonesRedfortressModel.getInstance().zonesSelfRank;
            return;
        }// end function

        private function callDownBack(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (!UILoaded)
            {
                return;
            }
            if (param1 > 0)
            {
                _loc_3 = param1 / 1000;
                _loc_4 = _loc_3 % 60;
                _loc_3 = _loc_3 / 60;
                _loc_5 = _loc_3 % 60;
                _loc_2 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12176"), [_loc_5, _loc_4]);
            }
            else
            {
                _loc_2 = "";
            }
            this._txtDowntime.text = _loc_2;
            return;
        }// end function

        public function setCDTime(param1:int, param2:int) : void
        {
            if (param2 < 2)
            {
                if (UILoaded)
                {
                    this._txtDownTimeTitle.visible = false;
                }
                return;
            }
            if (this._downtimer)
            {
                this._downtimer.count = param1 * 1000;
                this._txtDownTimeTitle.visible = true;
            }
            return;
        }// end function

        public function close() : void
        {
            this.cleanInfo();
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, -13, 255), GroupPanelType.GROUP_LOW);
            return;
        }// end function

        private function cleanInfo() : void
        {
            return;
        }// end function

    }
}
