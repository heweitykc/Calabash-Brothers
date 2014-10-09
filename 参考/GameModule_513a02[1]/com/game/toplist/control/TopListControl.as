package com.game.toplist.control
{
    import __AS3__.vec.*;
    import com.*;
    import com.game.toplist.cfg.*;
    import com.game.toplist.message.*;
    import com.game.toplist.protocol.*;
    import com.game.toplist.view.*;
    import com.model.vo.*;

    public class TopListControl extends Object
    {
        private var _sender:TopListProtocol;
        public const listType:Array;
        public var weaList:Vector.<EquipmentInfo>;
        private var _topFiveInfoList:Vector.<TopListInfo>;
        private var _topSelfInfoList:Vector.<TopListInfo>;
        private var _selfInfo:TopListInfo;
        private var _pageCount:int;
        private var _startIndex:int;
        private var _endIndex:int;
        public var currentType:int;
        private var _panel:TopListPanel;
        private static var _instance:TopListControl;

        public function TopListControl()
        {
            this.listType = [TopCfg.LEVEL_TYPE, TopCfg.HORSE_TYPE, TopCfg.COMBOS_TYPE, TopCfg.FIGHT_FORCE_TYPE, TopCfg.ARTIFACT_TYPE, TopCfg.LABOUR_TYPE, TopCfg.MAGIC_BOOK];
            this._sender = new TopListProtocol();
            return;
        }// end function

        public function get endIndex() : int
        {
            return this._endIndex;
        }// end function

        public function get startIndex() : int
        {
            return this._startIndex;
        }// end function

        public function get pageCount() : int
        {
            return this._pageCount;
        }// end function

        public function get selfInfo() : TopListInfo
        {
            return this._selfInfo;
        }// end function

        public function openTopList() : void
        {
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.open();
            return;
        }// end function

        public function closeTopList() : void
        {
            if (this._panel)
            {
                this._panel.close();
            }
            return;
        }// end function

        public function openOrClose() : void
        {
            if (!this._panel)
            {
                this.initPanel();
            }
            this._panel.openOrClose();
            return;
        }// end function

        public function setType(param1:int, param2:int, param3:int) : void
        {
            this._sender.reqListInfo(param1, param2, param3);
            return;
        }// end function

        public function updateByListInfo(param1:ResGetTopListToClientMessage) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (!this._topFiveInfoList)
            {
                this._topFiveInfoList = new Vector.<TopListInfo>;
            }
            else
            {
                this._topFiveInfoList.splice(0, this._topFiveInfoList.length);
            }
            if (!this._topSelfInfoList)
            {
                this._topSelfInfoList = new Vector.<TopListInfo>;
            }
            else
            {
                this._topSelfInfoList.splice(0, this._topSelfInfoList.length);
            }
            var _loc_2:* = 0;
            var _loc_3:* = param1.top5infolist.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = new TopListInfo();
                _loc_4.conv(param1.top5infolist[_loc_2]);
                this._topFiveInfoList.push(_loc_4);
                _loc_2++;
            }
            _loc_3 = param1.topselfinfolist.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_4 = new TopListInfo();
                _loc_4.conv(param1.topselfinfolist[_loc_2]);
                this._topSelfInfoList.push(_loc_4);
                _loc_2++;
            }
            this._selfInfo = new TopListInfo();
            this._selfInfo.conv(param1.selfIndex);
            this._pageCount = param1.count;
            this._startIndex = param1.start;
            this._endIndex = param1.end;
            if (this._panel)
            {
                this.currentType = param1.toptype;
                _loc_5 = this.listType.indexOf(param1.toptype);
                this._panel.currentList = _loc_5;
            }
            return;
        }// end function

        private function initPanel() : void
        {
            this._panel = new TopListPanel();
            Global.popManager.addPop(this._panel);
            return;
        }// end function

        public function get topFiveInfoList() : Vector.<TopListInfo>
        {
            if (!this._topFiveInfoList)
            {
                this._topFiveInfoList = new Vector.<TopListInfo>;
            }
            return this._topFiveInfoList;
        }// end function

        public function get topSelfInfoList() : Vector.<TopListInfo>
        {
            if (!this._topSelfInfoList)
            {
                this._topSelfInfoList = new Vector.<TopListInfo>;
            }
            return this._topSelfInfoList;
        }// end function

        public static function getInstance() : TopListControl
        {
            var _loc_1:* = new TopListControl;
            _instance = new TopListControl;
            return _instance || _loc_1;
        }// end function

    }
}
